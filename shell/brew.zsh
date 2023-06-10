# Run brew commands without forcing an update first.
export HOMEBREW_NO_AUTO_UPDATE=1
# Get homebrew to back off when I'm just trying to install / upgrade one thing
# and there are other things installed that have newer versions.
export HOMEBREW_NO_INSTALLED_DEPENDENTS_CHECK=1

# Set up completion for programs that define these under site-functions
if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH

  autoload -Uz compinit
  compinit
fi
