# This file is run for interactive shells only.

typeset -U path PATH # Unique-ify the path

# Unable to load these in zshenv because it can't find the go binary yet
export GOPATH="$(go env GOPATH)"
export GOBIN="$GOPATH/bin"

export QUICK_TMUX_REPOS="$HOME/repos/kinbiko"
export QUICK_TMUX_MONOREPOS=""

path+=("$GOBIN" "$HOME/scripts" "$XDG_CONFIG_HOME/zsh/scripts")

fpath+="$XDG_CONFIG_HOME/zsh/functions"
autoload -Uz \
  bigquery \
  default-branch \
  git-purge \
  kube \
  pod-logs \
  pod-port-forward-grpc \
  pod-port-forward-http \
  pod-sync \
  pr-comments \
  toiletpresence \

# Wait 10 ms for additional key sequences.
# Allows you to enter normal mode in zsh faster than the default 0.4s
export KEYTIMEOUT=1

# Docs: https://zsh.sourceforge.io/Doc/Release/Options.html
setopt AUTO_PARAM_SLASH # Tab completing directory appends a slash
setopt INTERACTIVE_COMMENTS # Allow comments even in interactive shells.
setopt NO_CLOBBER # Don't overwrite files with > redirects. Use >| to force
setopt MAGIC_EQUAL_SUBST # Auto-complete paths in arguments

source "$XDG_CONFIG_HOME/zsh/vi-mode.zsh" # Doesn't work well if it's not first

# Per-OS overlay. $XDG_CONFIG_HOME/os is a symlink to linux/ or macos/,
# created by setup. clipcopy/clippaste (pbcopy vs wl-copy) live here.
for f in "$XDG_CONFIG_HOME"/os/zsh/*.zsh(N); do source "$f"; done

# Must come after every fpath/FPATH contribution -- os/zsh/brew.zsh adds
# brew's site-functions to FPATH.
autoload -Uz compinit
compinit

source "$XDG_CONFIG_HOME/zsh/fzf.zsh"
source "$XDG_CONFIG_HOME/zsh/history.zsh"
source "$XDG_CONFIG_HOME/zsh/keybindings.zsh"
source "$XDG_CONFIG_HOME/zsh/theme.zsh"

alias add="clear; git add -p"
alias caler="clear"
alias cat="bat"
alias claer="clear"
alias clar="clear"
alias clare="clear"
alias cler="clear"
alias dot="cd $XDG_CONFIG_HOME"
alias gd="clear; git diff"
alias gdc="clear; git diff --cached"
alias gdno="git diff --name-only"
alias gitroot='cd $(git rev-parse --show-toplevel)'
alias glog='git log --graph --pretty=format:'\''%Cred%h%Creset %Cgreen(%cr)%Creset%Cblue[%an]%Creset %s%Creset%C(yellow)%d%Creset'\'' --abbrev-commit --date=relative'
alias htop="btop"
alias iedit='gh issue edit $(gh issue list | fzf | cut -f 1)' # Shorthand for editing an issue after first listing available issues
alias jq="jq -Sr"
alias la='ls -lAh'
alias lear="clear"
alias pingu="ping google.com"
alias q="exit"
alias rg='clear; rg'
alias sd="z"
alias sdi="zi"
alias ta="tmux new-session -A -s kinbiko" # New session or attach if it already exists
alias today='cd "$EXOCORTEX_DIR/me/journal/$(date +"%Y-%m-%d %A")"'
alias top="btop"

eval "$(zoxide init zsh)"
eval "$(direnv hook zsh)"
