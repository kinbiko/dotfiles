#!/bin/sh
# Render session tabs alphabetically for the status bar.
# Active session uses bold blue; others use muted gray.
current=$(tmux display-message -p '#{client_session}')
tmux list-sessions -F '#{session_name}' | LC_ALL=C sort | while read -r name; do
  if [ "$name" = "$current" ]; then
    printf '#[bg=#7aa2f7,fg=#1a1a2e,bold] %s #[bg=#3b3b50]' "$name"
  else
    printf '#[bg=#3b3b50,fg=#888899] %s #[default]' "$name"
  fi
done
