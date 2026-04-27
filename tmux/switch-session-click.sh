#!/bin/sh
# Click handler for the 2-line status bar.
# Line 0: switch session, Line 1: switch window.
mouse_x=$1
mouse_y=${2:-0}

if [ "$mouse_y" = "0" ]; then
  pos=0
  tmux list-sessions -F '#{session_name}' | sort | while read -r name; do
    width=$((${#name} + 2))
    if [ "$mouse_x" -ge "$pos" ] && [ "$mouse_x" -lt "$((pos + width))" ]; then
      tmux switch-client -t "$name"
      exit 0
    fi
    pos=$((pos + width))
  done
elif [ "$mouse_y" = "1" ]; then
  pos=0
  tmux list-windows -F '#{window_index}:#{window_name}' | while read -r entry; do
    width=$((${#entry} + 2))
    if [ "$mouse_x" -ge "$pos" ] && [ "$mouse_x" -lt "$((pos + width))" ]; then
      index="${entry%%:*}"
      tmux select-window -t ":$index"
      exit 0
    fi
    pos=$((pos + width))
  done
fi
