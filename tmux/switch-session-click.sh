#!/bin/sh
# Switch to the session under the mouse cursor based on X position.
# Each session is rendered as " name " (space-padded) in the status bar.
# #{S:} iterates in creation order, so we must match that here.
mouse_x=$1
pos=0
tmux list-sessions -F '#{session_created} #{session_name}' | sort -n | awk '{print $2}' | while read -r name; do
  # Each tab is " name " = len(name) + 2
  width=$((${#name} + 2))
  if [ "$mouse_x" -ge "$pos" ] && [ "$mouse_x" -lt "$((pos + width))" ]; then
    tmux switch-client -t "$name"
    exit 0
  fi
  pos=$((pos + width))
done
