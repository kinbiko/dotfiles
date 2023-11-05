#!/usr/bin/env zsh
# vim: set ft=sh:

function init_tmux_window() {
  local session="$1"
  local name="$2"
  local org="$3"
  local repo="$4"

  # Create the session if it doesn't exist
  if ! tmux has-session -t "$session" 2>/dev/null; then
      tmux new-session -d -s "$session"
      # If it's the session is being created then instead of creating a new
      # window we should rename the default one 
      tmux rename-window -t "$session:0" "$name"
  fi

  # Create the window if it doesn't exist
  if ! tmux list-windows -t "$session" | grep -q "$name"; then
      tmux new-window -t "$session" -n "$name"
  fi

  tmux send-keys -t "$session:$name" "mkdir \"$session\"" Enter
  tmux send-keys -t "$session:$name" "cd \"$session\"" Enter
  tmux send-keys -t "$session:$name" "gh repo clone $org/$repo" Enter
  tmux send-keys -t "$session:$name" "cd $repo" Enter
}

