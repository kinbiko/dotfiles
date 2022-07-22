#!/usr/bin/env bash

# Simplified version of github.com/tmux-plugins/tmux-urlview

tmux bind-key "u" capture-pane -J \\\; \
  save-buffer "${TMPDIR:-/tmp}/tmux-buffer" \\\; \
  delete-buffer \\\; \
  split-window -l 10 "urlview '${TMPDIR:-/tmp}/tmux-buffer'"
