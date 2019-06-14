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

export EDITOR='nvim'

export GOPATH=$HOME/go

pathmunge "$HOME/scripts"
pathmunge "$GOPATH/bin"

pathmunge "$DOTFILES_DIR/scripts"

#Solves a tmux/OS 10 Sirra bug
export EVENT_NOKQUEUE=1

# Wait 10 ms for additional key sequences. Allows you to enter normal mode in zsh faster than the default 0.4s
export KEYTIMEOUT=1

# Run brew commands without forcing an update first.
export HOMEBREW_NO_AUTO_UPDATE=1

source $ZSH/oh-my-zsh.sh

#===ALIASES===

alias v=nvim
alias vi=nvim
alias vim=nvim
alias vimdiff="nvim -d"
alias nvimdiff="nvim -d"

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
alias q=exit
alias pingu="ping google.com"
alias q="exit"
alias cat="bat"
alias grep="ag"

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

# Hey, I just met you, and this is crazy, but here's my alias, so start vifm, maybe
alias ls="vifm ."
alias la="/bin/ls -la"

#relocate
alias dot="cd $DOTFILES_DIR"
alias repos="cd ~/repos/"
alias gosrc="cd $GOPATH/src/github.com/"

#Git
alias g=git
alias gi=git
alias gs="git status"
alias gd="clear; git diff"
alias gdc="clear; git diff --cached"
alias ga="git add ."
alias add="clear; git add -p"
alias pull="git pull"
alias push="git push"
alias fetch="git fetch -p"
alias effyou="git push -f"
alias glog='git log --graph --pretty=format:'\''%Cred%h%Creset %an: %s %Cblue[%GS]%Creset - %Creset %C(yellow)%d%Creset %Cgreen(%cr)%Creset'\'' --abbrev-commit --date=relative'
# I swear by my pretty floral bonnet, I will commit you
alias gorram="git commit --amend --no-edit"
alias gorramit="git commit --amend --no-edit"
alias gorammit="git commit --amend --no-edit"
alias gorrammit="git commit --amend --no-edit"

alias ..="cd ../" # Swimming pool
alias ...="cd ../../" # Free diver
alias ....="cd ../../../" # New Zealand fur seal
alias .....="cd ../../../../" # New Zealand sea lion
alias ......="cd ../../../../../" # Southern elephant seal
alias .......="cd ../../../../../../" # Sperm whale
alias ........="cd ../../../../../../../" #Mariana Trench
#At this point you probably want 'cd /' anyway...

#Tmux
alias ta="tmux attach"

#Docker
alias dcd="docker-compose down"
alias dcu="docker-compose up"
alias dps="docker ps --format 'table {{.Names}}	{{.Status}}	{{.ID}}' | sed 's/dev_//' | sed 's/_1/_1    /' | sort"

#Ruby stuff
alias be="bundle exec"

#Go stuff

# When running go command zsh's autocorrection often incorrectly kicks in, e.g. for './...'
# Therefore just assume I typed the go command correctly by default
alias go='nocorrect go'

alias pp="$GOPATH/bin/pp" # Overriding the Perl package manager
gt() {
  if [[ $# -eq 0 ]] ; then
    ( nocorrect go test -timeout 3s ./... |& pp )
  else
    ( nocorrect go test -timeout 3s $@ |& pp )
  fi
}
alias gtr="go test -race"
alias gosrc="cd $GOPATH/src/github.com"
alias glint="golangci-lint"

#===Shell magic<3===

#Enable vim mode in terminal, and set the timeout to 0.1s
bindkey -v
# Pop open vim to edit the current command with ctrl+x ctrl+x
# Stolen from wincent
autoload -U edit-command-line
zle -N edit-command-line
bindkey '^x^x' edit-command-line

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

# If rbenv is installed, then initialise it
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

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

# grm opens up the GitHub README for the repo whose slug you provide.
# e.g. grm kinbiko/jsonassert will open the README of the latest master branch
# of github.com/kinbiko/jsonassert in vim, stored in a temporary file
grm() {
  curl https://raw.githubusercontent.com/$1/master/README.md > /tmp/README.md
  vim /tmp/README.md
}
