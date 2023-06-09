export DOTFILES_DIR=$HOME/repos/dotfiles

alias v="nvim"
alias vim="nvim"
alias vimdiff="nvim -d"

alias claer="clear"
alias clare="clear"
alias caler="clear"
alias cler="clear"
alias clar="clear"
alias lear="clear"

alias q="exit"

alias pingu="ping google.com"

alias cat="bat"
alias top="btop"
alias htop="btop"

alias dot="cd $DOTFILES_DIR"

alias g="git"
alias gs="git status"
alias gd="clear; git diff"
alias gdc="clear; git diff --cached"
alias ga="git add -A"
alias add="clear; git add -p"
alias pull="git pull"
alias push="git push"
alias fetch="git fetch -p"
alias effyou="git push -f"
alias glog='git log --graph --pretty=format:'\''%Cred%h%Creset %Cgreen(%cr)%Creset%Cblue[%an]%Creset %s%Creset%C(yellow)%d%Creset'\'' --abbrev-commit --date=relative'

alias gorram="git commit --amend --no-edit"
alias gorramit="git commit --amend --no-edit"
alias gorammit="git commit --amend --no-edit"
alias gorrammit="git commit --amend --no-edit"

alias ta="tmux -u attach"

alias dcd="docker compose down"
alias dcu="docker compose up"

# When running go command zsh's autocorrection often incorrectly kicks in, e.g. for './...'
# Therefore just assume I typed the go command correctly by default
alias go='nocorrect go'

alias pp="$GOPATH/bin/pp" # Overriding the Perl package manager

alias gtr="go test -race"
alias glint="golangci-lint"

alias tf=terraform

# Shorthand for editing an issue after first listing available issues
alias iedit='gh issue edit $(gh issue list | fzf | cut -f 1)'

alias grep="rg"

alias la='ls -lAh'
