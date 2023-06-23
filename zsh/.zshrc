# This file is run for interactive shells only.

typeset -U path PATH # Unique-ify the path
path+=("$GOBIN" "$HOME/scripts" "$XDG_CONFIG_HOME/zsh/scripts")

fpath+="$XDG_CONFIG_HOME/zsh/functions"
autoload bigquery

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
alias gitroot='cd $(git rev-parse --show-toplevel)'
alias glog='git log --graph --pretty=format:'\''%Cred%h%Creset %Cgreen(%cr)%Creset%Cblue[%an]%Creset %s%Creset%C(yellow)%d%Creset'\'' --abbrev-commit --date=relative'
alias grep="rg"
alias htop="btop"
alias iedit='gh issue edit $(gh issue list | fzf | cut -f 1)' # Shorthand for editing an issue after first listing available issues
alias la='ls -lAh'
alias lear="clear"
alias pingu="ping google.com"
alias q="exit"
alias sd="cd"
alias ta="tmux -u attach"
alias top="btop"

eval "$(nodenv init -)"
