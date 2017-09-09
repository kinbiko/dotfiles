export ZSH=/Users/roger/.oh-my-zsh
ZSH_THEME="simple"

plugins=(git, docker)

#===EXPORTS===
export GROOVY_HOME=/usr/local/opt/groovy/libexec
export EDITOR='vim'
export PATH=$PATH:/usr/local/go/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:~/scripts
export EVENT_NOKQUEUE=1 #Solves a tmux/OS 10 Sirra bug
export KEYTIMEOUT=1
export PATH="$HOME/.ndenv/bin:$PATH"

export NVM_DIR=~/.nvm

export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/bin


#===SOURCES===
source $ZSH/oh-my-zsh.sh
#Load gcp autocompletion
source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc'
source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc'
source $(brew --prefix nvm)/nvm.sh

#FIXME: Don't assume file structure.
#Load single command for unzipping, untarring etc.
source ~/repos/dotfiles/zsh/extract.sh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

#===ALIASES===

alias v=vim
alias top=htop

#Shell
alias cl="clear";
alias cls="clear";
alias claer="clear"
alias cler="clear"
alias clar="clear"
alias lear="clear"

#relocate
alias dot="cd ~/repos/dotfiles"
alias repos="cd ~/repos/"

#Git
alias g=git
alias gi=git
alias gs="git status"
alias gd="git diff"
alias gdc="git diff --cached"
alias ga="git add ."
alias pull="git pull"
alias push="git push"
alias fetch="git fetch -p"
alias gorramit="git commit --amend"

#Tmux
alias ta="tmux attach"

#Docker
alias dcd="docker-compose down"
alias dcu="docker-compose up"

#rabbit
alias rabbit=rabbitmqadmin

#gradle
alias check="gradle clean test checkstyleMain checkstyleTest"
alias checkstyle="gradle checkstyleMain checkstyleTest"

#===Shell magic<3===
#Enable vim mode in terminal, and set the timeout to 0.1s
bindkey -v

#Tell me when I'm in normal mode in the shell
function zle-line-init zle-keymap-select {
    VIM_PROMPT="%{$fg_bold[yellow]%} [% NORMAL]% %{$reset_color%}"
    RPS1="${${KEYMAP/vicmd/$VIM_PROMPT}/(main|viins)/} $EPS1"
    zle reset-prompt
}

#Enable the above function on startup and when modes change
zle -N zle-line-init
zle -N zle-keymap-select

#===evals===
eval "$(rbenv init -)"
eval "$(ndenv init -)"
