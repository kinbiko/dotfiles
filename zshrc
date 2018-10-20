export ZSH=~/.oh-my-zsh
ZSH_THEME="avit"
HYPHEN_INSENSITIVE="true"
DISABLE_AUTO_UPDATE="true"
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"

plugins=(vi-mode)

#===EXPORTS===

export EDITOR='vim'

export GOPATH=$HOME/go

export PATH=$PATH:~/scripts
export PATH=$PATH:$GOPATH/bin

#Solves a tmux/OS 10 Sirra bug
export EVENT_NOKQUEUE=1

# Wait 10 ms for additional key sequences. Allows you to enter normal mode in zsh faster than the default 0.4s
export KEYTIMEOUT=1

#===SOURCES===
source $ZSH/oh-my-zsh.sh

#Load single command for unzipping, untarring etc.
source $DOTFILES_DIR/zsh/extract.sh

#===ALIASES===

alias v=vim
alias vi=vim

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

#relocate
alias dot="cd $DOTFILES_DIR"
alias repos="cd ~/repos/"
alias gosrc="cd $GOPATH/src/github.com/"

#Git
alias g=git
alias gi=git
alias gs="git status"
alias gd="git diff"
alias gdc="git diff --cached"
alias ga="git add ."
alias add="git add -p"
alias pull="git pull"
alias push="git push"
alias fetch="git fetch -p"
alias effyou="git push -f"
alias glog="git log --graph --pretty=format:'%Cred%h%Creset %an: %s - %Creset %C(yellow)%d%Creset %Cgreen(%cr)%Creset' --abbrev-commit --date=relative"
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
alias pp="$GOPATH/bin/pp" # Overriding the Perl package manager
alias gt="go test -timeout 3s |& pp"
alias gtr="go test -race"
alias gosrc="cd $GOPATH/src/github.com"

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

# If rbenv is installed, then initialise it
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
