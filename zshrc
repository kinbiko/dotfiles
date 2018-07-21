export ZSH=~/.oh-my-zsh
ZSH_THEME="avit"
HYPHEN_INSENSITIVE="true"
DISABLE_AUTO_UPDATE="true"
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"

#removed git from the below plugins as it prevented my aliases from
#working as expected
plugins=(docker docker-compose golang npm vi-mode)

#===EXPORTS===
export GROOVY_HOME=/usr/local/opt/groovy/libexec
export EDITOR='vim'
export PATH=$PATH:/usr/local/go/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:~/scripts
export EVENT_NOKQUEUE=1 #Solves a tmux/OS 10 Sirra bug
export KEYTIMEOUT=1

export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

#===SOURCES===
source $ZSH/oh-my-zsh.sh

#Load single command for unzipping, untarring etc.
source ~/repos/dotfiles/zsh/extract.sh

#===ALIASES===

alias v=vim
alias vi=vim

#Shell
alias cl="clear";
alias cls="clear";
alias claer="clear"
alias cler="clear"
alias clar="clear"
alias lear="clear"
alias xit="exit"
alias xx="exit"
alias q=exit

#relocate
alias dot="cd ~/repos/dotfiles"
alias repos="cd ~/repos/"
alias gosrc="cd ~/go/src/github.com/"

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
#Yay Firefly!
alias gorram="git commit --amend --no-edit"
alias gorramit="git commit --amend --no-edit"
alias gorammit="git commit --amend --no-edit"
alias gorrammit="git commit --amend --no-edit"

#Snowplow
alias ..="cd ../"
alias ...="cd ../../"
alias ....="cd ../../../" #Free diver
alias .....="cd ../../../../"
alias ......="cd ../../../../../" #New Zealand fur seal
alias .......="cd ../../../../../../"
alias ........="cd ../../../../../../../" #New Zealand sea lion
alias .........="cd ../../../../../../../../"
alias ..........="cd ../../../../../../../../../" #Southern elephant seal
alias ...........="cd ../../../../../../../../../../"
alias ............="cd ../../../../../../../../../../../"
alias .............="cd ../../../../../../../../../../../../" #Sperm whale
alias ..............="cd ../../../../../../../../../../../../../"
alias ...............="cd ../../../../../../../../../../../../../../"
alias ................="cd ../../../../../../../../../../../../../../../" #Mariana Trench
#At this point you probably want 'cd /' anyway...

#Tmux
alias ta="tmux attach"

#Docker
alias dcd="docker-compose down"
alias dcu="docker-compose up"

#Ruby stuff
alias be="bundle exec"

#Add the current inbox task count to the prompt
#Some cool symbols:
#∫¡∞§∑∂ƒ∆√Ω›»
export PROMPT=$PROMPT #'ƒ($(task +inbox +PENDING count))='

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

#Amazing stuff stolen from jessfraz

#Colours in man pages
function man() {
    env \
        LESS_TERMCAP_mb="$(printf '\e[1;31m')" \
        LESS_TERMCAP_md="$(printf '\e[1;31m')" \
        LESS_TERMCAP_me="$(printf '\e[0m')" \
        LESS_TERMCAP_se="$(printf '\e[0m')" \
        LESS_TERMCAP_so="$(printf '\e[1;44;33m')" \
        LESS_TERMCAP_ue="$(printf '\e[0m')" \
        LESS_TERMCAP_us="$(printf '\e[1;32m')" \
        man "$@"
}


#Enable the above function on startup and when modes change
zle -N zle-line-init
zle -N zle-keymap-select
alias dps="docker ps --format 'table {{.Names}}	{{.Status}}	{{.ID}}' | sed 's/dev_//' | sed 's/_1/_1    /' | sort"
