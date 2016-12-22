# Path to your oh-my-zsh installation.
export ZSH=/Users/roger/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="nanotech"

plugins=(git, docker)

source $ZSH/oh-my-zsh.sh

alias rn="react-native"
alias rios="react-native run-ios"
alias v=vim
alias :q=exit
alias :Q=exit

#Shell
alias cl="clear";
alias repos="cd ~/repos/"

#Git
alias g=git
alias gs="git status"
alias gd="git diff"
alias gdc="git diff --cached"
alias ga="git add ."
alias gc="git commit"
alias pull="git pull"
alias push="git push"

#Tmux
alias ta="tmux attach"
alias tls="tmux ls"
alias t="tmux attach"
alias yoject="mux Yoject"
alias yoj="mux Yoject"
alias hiragana="mux Hiragana"
alias dotfiles="mux Dotfiles"
alias dot="mux Dotfiles"

source ~/repos/dotfiles/zsh/tmuxinator.zsh #Zsh bindings to tmuxinator
export GROOVY_HOME=/usr/local/opt/groovy/libexec
export EDITOR='vim'
export PATH=$PATH:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/octave/3.8.0/bin
export EVENT_NOKQUEUE=1 #Solves a tmux/OS 10 Sirra bug
