#!/bin/sh
# Point zsh at the config in this repo.
set -eu

REPO=${REPO:-$(cd "$(dirname "$0")/../.." && pwd)}

# .zshenv defines XDG_CONFIG_HOME, so it has to be linked by absolute path.
ln -sfn "$REPO/common/zsh/.zshenv" "$HOME/.zshenv"

# Single quotes are correct: refer to the variable name, not the value it
# happens to have during install.
echo 'source $XDG_CONFIG_HOME/zsh/.zshrc' >|"$HOME/.zshrc"

echo "  ~/.zshenv, ~/.zshrc"
