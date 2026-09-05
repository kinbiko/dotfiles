#!/bin/sh
# Open a URL picker over a captured tmux pane, bound to prefix + u.
#
# urlview is unmaintained and not packaged everywhere, so prefer it when
# present and fall back to urlscan, its maintained drop-in. Setups that have
# urlview keep using it, and common/urlview/config along with it.
#
# Kept as a script (rather than a conditional inline in a tmux binding) so the
# choice lives in one place and can be tested on its own.
set -eu
buffer=${1:-/tmp/tmux-buffer}

if command -v urlview >/dev/null 2>&1; then
  exec urlview "$buffer"
elif command -v urlscan >/dev/null 2>&1; then
  exec urlscan "$buffer"
else
  echo "neither urlview nor urlscan is installed" >&2
  read -r _
  exit 1
fi
