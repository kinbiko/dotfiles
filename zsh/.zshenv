# This file is run for *every* zsh shell (login and interactive agnostic)
# E.g. commands executed from within vim or scripts in Alfred etc. will also
# benefit from this file.

export EDITOR='nvim'
export XDG_CONFIG_HOME="$HOME/.config"
export BIGQUERYRC="$XDG_CONFIG_HOME/bigquery/bigqueryrc"
export RIPGREP_CONFIG_PATH="$XDG_CONFIG_HOME/ripgrep/ripgreprc"
export LANG=en_US.UTF-8

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
