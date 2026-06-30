#!/bin/sh
# gpodder launches this as its audio player (player string: this path + %U).
# Receives streamed episode URLs as args. Runs ONE windowless mpv whose
# playback the Waybar media buttons control over the IPC socket below.
SOCK="${XDG_RUNTIME_DIR:-/tmp}/mpv-podcast.sock"

# Replace any currently-running podcast mpv so there is only ever one.
pkill -f -- "--input-ipc-server=$SOCK" 2>/dev/null
rm -f "$SOCK"

exec mpv \
  --no-video \
  --force-window=no \
  --idle=no \
  --save-position-on-quit \
  --input-ipc-server="$SOCK" \
  --msg-level=all=warn \
  -- "$@"
