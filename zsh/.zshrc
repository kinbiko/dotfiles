# This file is run for interactive shells only.

typeset -U path PATH # Unique-ify the path

# Unable to load these in zshenv because it can't find the go binary yet
export GOPATH="$(go env GOPATH)"
export GOBIN="$GOPATH/bin"

export QUICK_TMUX_REPOS="$HOME/repos $HOME/.config"
export QUICK_TMUX_MONOREPOS=""

path+=("$GOBIN" "$HOME/scripts" "$XDG_CONFIG_HOME/zsh/scripts" "$HOME/.cargo/bin")

fpath+="$XDG_CONFIG_HOME/zsh/functions"
autoload \
  bigquery \
  kk \
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

# This makes copy and pasting in the shell be the same as the system clipboard
clipcopy()  { cat "${1:-/dev/stdin}" | pbcopy; }
clippaste() { pbpaste; }

# Docs: https://zsh.sourceforge.io/Doc/Release/Options.html
setopt AUTO_PARAM_SLASH # Tab completing directory appends a slash
setopt INTERACTIVE_COMMENTS # Allow comments even in interactive shells.
setopt NO_CLOBBER # Don't overwrite files with > redirects. Use >| to force
setopt MAGIC_EQUAL_SUBST # Auto-complete paths in arguments

source "$XDG_CONFIG_HOME/zsh/vi-mode.zsh" # Doesn't work well if it's not first

source "$XDG_CONFIG_HOME/zsh/brew.zsh"
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
alias top="btop"

eval "$(zoxide init zsh)"
eval "$(direnv hook zsh)"
