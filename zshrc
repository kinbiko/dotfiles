# pathmunge adds the first argument to the end of the $PATH only if it's not there already.
pathmunge () {
  # If the PATH contains the new value then don't do anything, otherwise append
  # to the end of the PATH.
  # -E -- interpret as extended regexp
  # -q -- Don't print -- only care about a true/false value
  if ! echo "$PATH" | g\rep -Eq "(^|:)$1($|:)" ; then
    PATH="$PATH:$1"
  fi
}

# I think this is more or less the default anyway...
export XDG_CONFIG_HOME="$HOME/.config"

# This makes copy and pasting in the shell be the same as the system clipboard
if (( ${+commands[pbcopy]} )) && (( ${+commands[pbpaste]} )); then
  function clipcopy() { cat "${1:-/dev/stdin}" | pbcopy; }
  function clippaste() { pbpaste; }
elif [ -n "${TMUX:-}" ] && (( ${+commands[tmux]} )); then
  function clipcopy() { tmux load-buffer "${1:--}"; }
  function clippaste() { tmux save-buffer -; }
fi

setopt auto_pushd
setopt pushd_ignore_dups
setopt pushdminus
setopt interactivecomments
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups       # ignore duplicated commands history list
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running it
setopt share_history          # share command history data

# Start typing + [Up-Arrow] - fuzzy find history forward
if [[ -n "${terminfo[kcuu1]}" ]]; then
  autoload -U up-line-or-beginning-search
  zle -N up-line-or-beginning-search
  bindkey -M viins "${terminfo[kcuu1]}" up-line-or-beginning-search
  bindkey -M vicmd "${terminfo[kcuu1]}" up-line-or-beginning-search
fi

# Start typing + [Down-Arrow] - fuzzy find history backward
if [[ -n "${terminfo[kcud1]}" ]]; then
  autoload -U down-line-or-beginning-search
  zle -N down-line-or-beginning-search
  bindkey -M viins "${terminfo[kcud1]}" down-line-or-beginning-search
  bindkey -M vicmd "${terminfo[kcud1]}" down-line-or-beginning-search
fi

# [Shift-Tab] - move through the completion menu backwards
if [[ -n "${terminfo[kcbt]}" ]]; then
  bindkey -M viins "${terminfo[kcbt]}" reverse-menu-complete
  bindkey -M vicmd "${terminfo[kcbt]}" reverse-menu-complete
fi

bindkey '\C-v' edit-command-line

source "$DOTFILES_DIR/vi-mode.zsh"

HYPHEN_INSENSITIVE="true"
DISABLE_AUTO_UPDATE="true"
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"

# Needed so that GPG knows how to open the TUI for entering the PGP password.
export GPG_TTY=$(tty)
export EDITOR='nvim'
export GOPATH=$HOME/go

pathmunge "$GOPATH/bin"

pathmunge "$HOME/scripts"

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

source "$DOTFILES_DIR/theme.zsh"

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

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export FZF_DEFAULT_COMMAND='rg --files-with-matches --hidden .'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS='--preview "bat --color=always --style=numbers --line-range=:500 {}"'

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

gitroot() {
  cd $(git rev-parse --show-toplevel)
}

# The following kubernetes command was stolen from @eqyiel.
# Onto @eqyiel the glory
kubectl() {
  if ! type __start_kubectl >/dev/null 2>&1; then
    source <(command kubectl completion zsh)
    compdef k=kubectl
  fi
  command kubectl "$@"
}
