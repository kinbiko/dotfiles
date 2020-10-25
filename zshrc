# pathmunge adds the first argument to the end of the $PATH only if it's not there already.

pathmunge () {
  if ! echo "$PATH" | grep -Eq "(^|:)$1($|:)" ; then
    PATH="$PATH:$1"
  fi
}

export ZSH=~/.oh-my-zsh
ZSH_THEME="avit"
HYPHEN_INSENSITIVE="true"
DISABLE_AUTO_UPDATE="true"
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"

plugins=(vi-mode)

#===EXPORTS===

# Needed so that GPG knows how to open the TUI for entering the PGP password.
export GPG_TTY=$(tty)

export EDITOR='nvim'

export GOPATH=$HOME/go

pathmunge "$GOPATH/bin"

# Wait 10 ms for additional key sequences. Allows you to enter normal mode in zsh faster than the default 0.4s
export KEYTIMEOUT=1

# Run brew commands without forcing an update first.
export HOMEBREW_NO_AUTO_UPDATE=1

# Set up completion for programs that define these under site-functions
if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH

  autoload -Uz compinit
  compinit
fi

source $ZSH/oh-my-zsh.sh

#===ALIASES===

alias v=nvim
alias vim=nvim
alias vimdiff="nvim -d"

#Shell
alias cl="clear";
alias cls="clear";
alias claer="clear"
alias clare="clear"
alias caler="clear"
alias cler="clear"
alias clar="clear"
alias lear="clear"
alias xit="exit"
alias xx="exit"
alias pingu="ping google.com"
alias q="exit"
alias cat="bat"
alias grep="ag"
alias top="zenith"

# Make zsh completion:
# - Try exact (case-sensitive) match first.
# - Then fall back to case-insensitive.
# - Accept abbreviations after . or _ or - (ie. f.b -> foo.bar).
# - Substring complete (ie. bar -> foobar).
zstyle ':completion:*' matcher-list '' '+m:{[:lower:]}={[:upper:]}' '+m:{[:upper:]}={[:lower:]}' '+m:{_-}={-_}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# Colorize completions using default `ls` colors.
zstyle ':completion:*' list-colors ''

# tab completing directory appends a slash
setopt AUTO_PARAM_SLASH

#relocate
alias dot="cd $DOTFILES_DIR"
alias repos="cd ~/repos/"

#Git
alias g=git
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
# I swear by my pretty floral bonnet, I will commit you
alias amend="git commit --amend"
alias gorram="git commit --amend --no-edit"
alias gorramit="git commit --amend --no-edit"
alias gorammit="git commit --amend --no-edit"
alias gorrammit="git commit --amend --no-edit"

#Tmux
alias ta="tmux -u attach"

#Docker
alias dcd="docker-compose down"
alias dcu="docker-compose up"

#Go stuff

# When running go command zsh's autocorrection often incorrectly kicks in, e.g. for './...'
# Therefore just assume I typed the go command correctly by default
alias go='nocorrect go'

alias pp="$GOPATH/bin/pp" # Overriding the Perl package manager

# gtv is go test, plus a bunch of convenient settings, but also print the logs for any failing tests
gtv() {
  if [[ $# -eq 0 ]] ; then
    ( nocorrect go test ./... -p 1 -json | tparse |& pp )
  else
    ( nocorrect go test $@ -p 1 -json | tparse |& pp )
  fi
}

alias gtr="go test -race"
alias glint="golangci-lint"

#===Shell magic<3===

#Enable vim mode in terminal, and set the timeout to 0.1s
bindkey -v

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

#Tell me when I'm in normal mode in the shell
function zle-line-init zle-keymap-select {
    VIM_PROMPT="%{$fg_bold[yellow]%} [% NORMAL]% %{$reset_color%}"
    RPS1="${${KEYMAP/vicmd/$VIM_PROMPT}/(main|viins)/} $EPS1"
    zle reset-prompt
}

#Enable the above function on startup and when modes change
zle -N zle-line-init
zle -N zle-keymap-select

# extract can decompress most compressed files, assuming the correct tool is installed.
# Cred to DevRant user Jilano: https://devrant.com/users/Jilano
extract () {
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2) tar xvjf $1;;
            *.tar.gz) tar xvzf $1;;
            *.bz2) bunzip2 $1;;
            *.rar) unrar x $1;;
            *.gz) gunzip $1;;
            *.tar) tar xvf $1;;
            *.tbz2) tar xvjf $1;;
            *.tgz) tar xvzf $1;;
            *.zip) unzip $1;;
            *.Z) uncompress $1;;
            *.7z) 7z x $1;;
            *) echo "No idea how to extract this filetype";;
        esac
    else
        "'$1' is not a valid file!"
    fi
}
