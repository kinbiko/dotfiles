# This file is run for *every* zsh shell (login and interactive agnostic)
# E.g. commands executed from within vim or scripts in Alfred etc. will also
# benefit from this file.

export DOTFILES_DIR=$HOME/repos/dotfiles
export XDG_CONFIG_HOME="$HOME/.config"

alias add="clear; git add -p"
alias caler="clear"
alias cat="bat"
alias claer="clear"
alias clar="clear"
alias clare="clear"
alias cler="clear"
alias dcd="docker compose down"
alias dcu="docker compose up"
alias dot="cd $DOTFILES_DIR"
alias effyou="git push -f"
alias fetch="git fetch -p"
alias g="git"
alias ga="git add -A"
alias gd="clear; git diff"
alias gdc="clear; git diff --cached"
alias gitroot='cd $(git rev-parse --show-toplevel)'
alias glint="golangci-lint"
alias glog='git log --graph --pretty=format:'\''%Cred%h%Creset %Cgreen(%cr)%Creset%Cblue[%an]%Creset %s%Creset%C(yellow)%d%Creset'\'' --abbrev-commit --date=relative'
alias gorammit="git commit --amend --no-edit"
alias gorram="git commit --amend --no-edit"
alias gorramit="git commit --amend --no-edit"
alias gorrammit="git commit --amend --no-edit"
alias grep="rg"
alias gs="git status"
alias gtr="go test -race"
alias htop="btop"
alias iedit='gh issue edit $(gh issue list | fzf | cut -f 1)' # Shorthand for editing an issue after first listing available issues
alias la='ls -lAh'
alias lear="clear"
alias pingu="ping google.com"
alias pull="git pull"
alias push="git push"
alias q="exit"
alias ta="tmux -u attach"
alias tf="terraform"
alias top="btop"
alias v="nvim"
alias vim="nvim"
alias vimdiff="nvim -d"
