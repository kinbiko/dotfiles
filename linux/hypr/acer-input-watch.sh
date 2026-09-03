#!/usr/bin/env bash
# The Acer is a KVM-less shared monitor: it stays electrically connected to this
# machine (HPD asserted, EDID readable) even when its input is switched to the
# other computer, so Hyprland always believes it is present and happily puts
# workspaces on a screen we cannot see.
#
# Detecting the real state is awkward, because this panel's DDC/CI is per-port
# and cached: VCP 0x60 (Input Source) always answers "HDMI-2" -- our own port --
# regardless of what is actually on screen, and every timing feature (0xAC/0xAE/
# 0xB4) is likewise frozen at our port's values. A full VCP scan taken in both
# states differs in exactly one feature, so that is what we build on:
#
#   0x02 "New control value" is a latch the monitor sets whenever its own
#   controls change (input switch, brightness, ...). Writing 1 clears it.
#
# The latch says "something changed", not what changed, so it only triggers a
# probe. Ground truth comes from a physical asymmetry:
#
#   With our output disabled, our port carries no signal. If the panel is
#   showing the other computer it stays awake and answers DDC; if the panel is
#   on our input it has nothing to display, drops to standby, and stops
#   answering DDC entirely.
#
# So: DDC silent => the panel is ours (asleep, waiting for us to drive it).
#     DDC alive  => the panel is showing the other computer.
#
# That makes the away state self-healing: a latch fired by an unrelated OSD
# tweak costs at most one brief blackout before the probe puts us back.
#
# Nothing about the hardware layout is hardcoded beyond SHARED_MODEL. The panel
# is located by EDID rather than by connector, the fallback monitor is whatever
# else is currently connected, and the restored layout is re-read from
# hyprland.conf. Replacing either monitor degrades to a clean stand-down instead
# of leaving workspaces bound to a display that no longer exists.

set -uo pipefail

# EDID identity of the shared panel, as printed by `ddcutil --brief detect`.
SHARED_MODEL="ACR:ET322QK C:"
HYPR_CONF="$HOME/.config/hypr/hyprland.conf"
POLL_SECONDS=5
DEAD_READS_TO_CONFIRM=3   # consecutive DDC failures before believing standby
PROBE_SETTLE_SECONDS=5    # let an input-switch transient pass before probing
PROBE_SILENCE_SECONDS=10  # unbroken silence that actually means standby
PROBE_TIMEOUT_SECONDS=45  # how long to wait for a starved panel to fall asleep

log() { printf '%s acer-input-watch: %s\n' "$(date -Is)" "$*"; }

# Locate the shared panel by EDID. Bus numbers shuffle across reboots and GPU
# re-probes, and connector names get reused if monitors are swapped around, so
# neither is safe to assume. Prints "<bus> <connector>", or nothing if the panel
# is not attached.
find_shared() {
  ddcutil --brief detect 2>/dev/null | awk -v model="$SHARED_MODEL" '
    /I2C bus:/       { bus = $3; sub(/.*i2c-/, "", bus) }
    /DRM connector:/ { conn = $3; sub(/^card[0-9]+-/, "", conn) }
    /Monitor:/       { $1 = ""; sub(/^ +/, "");
                       if ($0 == model) { print bus, conn; exit } }'
}

# Any other connected output we can park workspaces on. Empty if the shared
# panel is all we have, in which case releasing it would leave no display at all.
fallback_monitor() {
  hyprctl -j monitors 2>/dev/null \
    | python3 -c "import json,sys
ms=[m['name'] for m in json.load(sys.stdin) if m['name']!='$CONNECTOR' and not m['disabled']]
print(ms[0] if ms else '')" 2>/dev/null
}

# Workspace numbers come from the config so this stays in step if they change.
workspace_ids() {
  grep -oP '^\s*workspace\s*=\s*\K[0-9]+' "$HYPR_CONF" 2>/dev/null | sort -un
}

ddc_alive() { ddcutil --bus "$BUS" getvcp 10 >/dev/null 2>&1; }

# Returns 0 if the change latch is set. Always clears it, so each physical
# change is reported exactly once.
latch_fired() {
  local out
  out=$(ddcutil --bus "$BUS" getvcp 02 2>/dev/null) || return 1
  [[ $out == *"(0x02)"* ]] || return 1
  ddcutil --bus "$BUS" setvcp 02 1 >/dev/null 2>&1
  return 0
}

connector_present() {
  hyprctl -j monitors all 2>/dev/null | grep -q "\"name\": \"$CONNECTOR\""
}

disable_output() { hyprctl keyword monitor "$CONNECTOR, disable" >/dev/null; }

# Restoring means re-reading hyprland.conf rather than replaying a copy of the
# layout kept here, so the monitor mode, position and workspace bindings have
# exactly one definition. Only idempotent `exec =` lines are re-run.
apply_docked() { hyprctl reload >/dev/null; }

# default: is set explicitly on every workspace because `hyprctl keyword
# workspace` merges into the existing rule rather than replacing it, so a stale
# default:true would otherwise survive the switch.
apply_solo() {
  local target=$1 first=1 batch="keyword monitor $CONNECTOR, disable"
  for ws in $(workspace_ids); do
    batch+=" ; keyword workspace $ws, monitor:$target, default:$([[ $first == 1 ]] && echo true || echo false)"
    first=0
  done
  hyprctl --batch "$batch" >/dev/null
}

# Starve the port and wait to see whether the panel falls asleep. Measured
# standby latency on this panel is ~17s, so we poll for the silence rather than
# sleeping a fixed period: the "it is ours" verdict lands as soon as the panel
# drops off the bus, and only the "showing the other computer" verdict pays the
# full timeout -- which costs nothing, since the output is meant to be off then
# anyway.
#
# The silence must be *sustained* to count. A probe runs the moment the change
# latch trips, which is exactly when the panel's controller is re-initialising
# after an input switch, and it drops off the bus for a few seconds while it
# does. That transient is indistinguishable from standby in any single read --
# but standby silence is permanent, so requiring an unbroken run of it tells
# the two apart. Settling first keeps the worst of the transient out of the
# measurement entirely.
#
# Leaves the output disabled; the caller decides what to do with the answer.
# 0 = panel is ours.
probe_is_ours() {
  sleep "$PROBE_SETTLE_SECONDS"
  disable_output
  local deadline=$(( $(date +%s) + PROBE_TIMEOUT_SECONDS )) silent_since=0 now
  while now=$(date +%s); ((now < deadline)); do
    if ddc_alive; then
      silent_since=0
    else
      ((silent_since == 0)) && silent_since=$now
      ((now - silent_since >= PROBE_SILENCE_SECONDS)) && return 0
    fi
    sleep 1
  done
  return 1
}

BUS=-1
CONNECTOR=""
state=unknown
dead_reads=0

while true; do
  read -r bus conn <<<"$(find_shared)"

  if [[ -z ${conn:-} ]]; then
    # Panel not attached, or replaced by different hardware. Leave Hyprland's
    # native hotplug handling to it.
    [[ $state == absent ]] || { log "shared panel not attached; standing down"; state=absent; }
    BUS=-1; CONNECTOR=""
    sleep "$POLL_SECONDS"; continue
  fi

  BUS=$bus; CONNECTOR=$conn

  if ! connector_present; then
    [[ $state == absent ]] || { log "$CONNECTOR gone from Hyprland; standing down"; state=absent; }
    sleep "$POLL_SECONDS"; continue
  fi

  # Never release the shared panel while it is the only thing we can draw on.
  fallback=$(fallback_monitor)
  if [[ -z $fallback && $state != docked ]]; then
    [[ $state == sole ]] || { log "shared panel is the only display; leaving it enabled"; state=sole; apply_docked; }
    sleep "$POLL_SECONDS"; continue
  fi

  case $state in
    docked)
      # Panel is ours and driven. Only the change latch can tell us the user
      # touched the monitor; confirm what actually happened with a probe.
      #
      # Release first, ask questions after. "Away" is only provable by the
      # panel *failing* to fall asleep, so it costs the whole probe timeout --
      # but probing means starving the port, so the screen is dark for that
      # window regardless of what we conclude. Acting pessimistically makes the
      # common case (you did just switch away) instant, and costs the false
      # alarm nothing it was not already paying.
      if latch_fired; then
        if [[ -z $fallback ]]; then
          log "controls changed but no other display; not probing"
        else
          log "monitor controls changed; releasing to $fallback while we check"
          apply_solo "$fallback"; state=solo
          if probe_is_ours; then
            log "false alarm; still ours, restoring"
            apply_docked; state=docked
          else
            log "confirmed: switched to the other computer"
          fi
        fi
      fi
      ;;

    solo)
      # Output is disabled, so a live DDC channel means the panel is awake on
      # the other computer's input. Silence means it went to standby waiting
      # for us.
      if ddc_alive; then
        dead_reads=0
      else
        ((dead_reads++))
        if ((dead_reads >= DEAD_READS_TO_CONFIRM)); then
          log "panel stopped answering while starved; it is ours again"
          apply_docked; state=docked; dead_reads=0
          # Clear any latch the input switch set, so it does not immediately
          # re-trigger a probe.
          sleep 3; latch_fired >/dev/null
        fi
      fi
      ;;

    *)
      log "determining initial state (panel on $CONNECTOR, bus $BUS)"
      if probe_is_ours; then log "initial state: ours"; apply_docked; state=docked
      else log "initial state: other computer"; apply_solo "$fallback"; state=solo; fi
      latch_fired >/dev/null
      ;;
  esac

  sleep "$POLL_SECONDS"
done
