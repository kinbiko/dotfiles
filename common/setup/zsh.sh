#!/bin/sh
# Point zsh at the config in this repo.
set -eu

REPO=${REPO:-$(cd "$(dirname "$0")/../.." && pwd)}

. "$REPO/common/setup/lib.sh"

# .zshenv defines XDG_CONFIG_HOME, so it has to be linked by absolute path.
backup_move "$HOME/.zshenv"
ln -sfn "$REPO/common/zsh/.zshenv" "$HOME/.zshenv"

# ~/.zshrc stays a real file: installers (claude, asdf, ...) append their own
# PATH lines to it, so it is appended to rather than overwritten.
# Single quotes are correct: refer to the variable name, not the value it
# happens to have during install.
SOURCE_LINE='source $XDG_CONFIG_HOME/zsh/.zshrc'
if [ -e "$HOME/.zshrc" ] && grep -qxF "$SOURCE_LINE" "$HOME/.zshrc"; then
  echo "  ~/.zshenv, ~/.zshrc (already sourced)"
else
  backup_copy "$HOME/.zshrc"
  printf '%s\n' "$SOURCE_LINE" >>"$HOME/.zshrc"
  echo "  ~/.zshenv, ~/.zshrc"
fi
