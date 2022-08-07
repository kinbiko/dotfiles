# pathmunge adds the first argument to the end of the $PATH only if it's not there already.
pathmunge () {
  # If the PATH contains the new value then don't do anything, otherwise append
  # to the end of the PATH.
  # -E -- interpret as extended regexp
  # -q -- Don't print -- only care about a true/false value
  if ! echo "$PATH" | grep -Eq "(^|:)$1($|:)" ; then
    PATH="$PATH:$1"
  fi
}

# I think this is more or less the default anyway...
export XDG_CONFIG_HOME="$HOME/.config"

export ZSH=~/.oh-my-zsh
ZSH_THEME="avit"
HYPHEN_INSENSITIVE="true"
DISABLE_AUTO_UPDATE="true"
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"

plugins=(vi-mode)

# Needed so that GPG knows how to open the TUI for entering the PGP password.
export GPG_TTY=$(tty)
export EDITOR='nvim'
export GOPATH=$HOME/go

pathmunge "$GOPATH/bin"

# Wait 10 ms for additional key sequences. Allows you to enter normal mode in zsh faster than the default 0.4s
export KEYTIMEOUT=1

# Run brew commands without forcing an update first.
export HOMEBREW_NO_AUTO_UPDATE=1
# Get homebrew to back off when I'm just trying to install / upgrade one thing
# and there are other things installed that have newer versions.
export HOMEBREW_NO_INSTALLED_DEPENDENTS_CHECK=1

# Set up completion for programs that define these under site-functions
if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH

  autoload -Uz compinit
  compinit
fi

source $ZSH/oh-my-zsh.sh

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

#Enable vim mode in terminal, and set the timeout to 0.1s
bindkey -v

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='ag --files-with-matches --hidden'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# Disable the default right-hand-side status
RPS1=""

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

function ag() {
  emulate -L zsh

  # Stolen and slightly tweaked from wincent
  # whenever ag is invoked, actually call it with less as a pager, and do fancy thhings with colours
  command ag --pager="less -iFMRSX" --color-path=34\;1 --color-line-number=35 --color-match=35\;1\;4 "$@"
}
# Most aliases are kept in zshenv but some part of my zsh startup script
# (probably in oh-my-zsh somewhere) probably uses grep, and a special flag of
# grep, that's not mirrored in ag, hence the script spits out an error whenever
# you open a new shell.
# This particular alias is therefore defined here instead.
alias grep="ag"
