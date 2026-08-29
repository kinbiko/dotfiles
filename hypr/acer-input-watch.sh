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

set -uo pipefail

CONNECTOR="HDMI-A-1"
MONITOR_SPEC="HDMI-A-1, 3840x2160@60, 0x0, 1"
POLL_SECONDS=5
DEAD_READS_TO_CONFIRM=3   # consecutive DDC failures before believing standby
PROBE_SETTLE_SECONDS=6    # time for the panel to drop to standby when starved

log() { printf '%s acer-input-watch: %s\n' "$(date -Is)" "$*"; }

# Bus numbers shuffle across reboots and GPU re-probes, so resolve by DRM
# connector rather than hardcoding.
find_bus() {
  ddcutil --brief detect 2>/dev/null | awk -v c="$CONNECTOR" '
    /I2C bus:/       { bus = $3 }
    /DRM connector:/ { if ($3 ~ c "$") { sub(/.*i2c-/, "", bus); print bus; exit } }'
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
  hyprctl -j monitors all | grep -q "\"name\": \"$CONNECTOR\""
}

disable_output() { hyprctl keyword monitor "$CONNECTOR, disable" >/dev/null; }

# default: is set explicitly on every workspace because `hyprctl keyword
# workspace` merges into the existing rule rather than replacing it, so a stale
# default:true would otherwise survive the switch.
apply_docked() {
  local batch="keyword monitor $MONITOR_SPEC"
  for ws in 1 2 6 7 8 9 10; do
    batch+=" ; keyword workspace $ws, monitor:$CONNECTOR, default:$([[ $ws == 1 ]] && echo true || echo false)"
  done
  for ws in 3 4 5; do
    batch+=" ; keyword workspace $ws, monitor:DP-1, default:$([[ $ws == 3 ]] && echo true || echo false)"
  done
  hyprctl --batch "$batch" >/dev/null
}

apply_solo() {
  local batch="keyword monitor $CONNECTOR, disable"
  for ws in $(seq 1 10); do
    batch+=" ; keyword workspace $ws, monitor:DP-1, default:$([[ $ws == 1 ]] && echo true || echo false)"
  done
  hyprctl --batch "$batch" >/dev/null
}

# Starve the port and see whether the panel sleeps. Leaves the output disabled;
# the caller decides what to do with the answer. 0 = panel is ours.
probe_is_ours() {
  disable_output
  sleep "$PROBE_SETTLE_SECONDS"
  local i
  for ((i = 0; i < DEAD_READS_TO_CONFIRM; i++)); do
    if ddc_alive; then return 1; fi
    sleep 1
  done
  return 0
}

BUS=$(find_bus)
[[ -n ${BUS:-} ]] || { log "Acer not on any i2c bus at startup; will retry"; BUS=-1; }

state=unknown
dead_reads=0

while true; do
  if ! connector_present; then
    # Genuinely unplugged or powered off. Leave Hyprland's native hotplug
    # handling alone and re-resolve the bus, which has gone away too.
    [[ $state == absent ]] || { log "$CONNECTOR gone from Hyprland; standing down"; state=absent; }
    BUS=$(find_bus); BUS=${BUS:--1}
    sleep "$POLL_SECONDS"; continue
  fi

  [[ $BUS == -1 ]] && { BUS=$(find_bus); BUS=${BUS:--1}; }
  [[ $BUS == -1 ]] && { sleep "$POLL_SECONDS"; continue; }

  case $state in
    docked)
      # Panel is ours and driven. Only the change latch can tell us the user
      # touched the monitor; confirm what actually happened with a probe.
      if latch_fired; then
        log "monitor controls changed; probing"
        if probe_is_ours; then
          log "still ours; restoring"
          apply_docked
        else
          log "switched to the other computer; releasing"
          apply_solo; state=solo
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
      log "determining initial state"
      if probe_is_ours; then log "initial state: ours"; apply_docked; state=docked
      else log "initial state: other computer"; apply_solo; state=solo; fi
      latch_fired >/dev/null
      ;;
  esac

  sleep "$POLL_SECONDS"
done
