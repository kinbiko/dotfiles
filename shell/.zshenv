# This file is run for *every* zsh shell (login and interactive agnostic)
# E.g. commands executed from within vim or scripts in Alfred etc. will also
# benefit from this file.

export EDITOR='nvim'
export DOTFILES_DIR="$HOME/repos/dotfiles"
export XDG_CONFIG_HOME="$HOME/.config"

alias dcd="docker compose down"
alias dcu="docker compose up"
alias effyou="git push -f"
alias fetch="git fetch -p"
alias g="git"
alias ga="git add -A"
alias glint="golangci-lint"
alias gorammit="git commit --amend --no-edit"
alias gorram="git commit --amend --no-edit"
alias gorramit="git commit --amend --no-edit"
alias gorrammit="git commit --amend --no-edit"
alias gs="git status"
alias gtr="go test -race"
alias pull="git pull"
alias push="git push"
alias tf="terraform"
alias v="nvim"
alias vim="nvim"
alias vimdiff="nvim -d"
