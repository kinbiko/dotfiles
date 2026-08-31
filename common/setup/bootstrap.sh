#!/bin/sh
# Entry point for setting up this machine. Run via ../../setup.sh.
set -eu

REPO=$(cd "$(dirname "$0")/../.." && pwd)
export REPO

case "$(uname -s)" in
  Linux) OS=linux ;;
  Darwin) OS=macos ;;
  *) echo "unsupported platform: $(uname -s)" >&2; exit 1 ;;
esac
export OS

echo "==> platform: $OS  repo: $REPO"

"$REPO/common/setup/link.sh"
"$REPO/common/setup/zsh.sh"
"$REPO/common/setup/install-apps.sh"

echo "==> done. Open a new shell."
