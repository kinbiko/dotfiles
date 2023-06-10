typeset -U path PATH # Unique-ify the path
path+=("$GOPATH/bin" "$HOME/scripts")

# This makes copy and pasting in the shell be the same as the system clipboard
clipcopy()  { cat "${1:-/dev/stdin}" | pbcopy; }
clippaste() { pbpaste; }

# Docs: https://zsh.sourceforge.io/Doc/Release/Options.html
setopt AUTO_PARAM_SLASH       # tab completing directory appends a slash
setopt HIST_EXPIRE_DUPS_FIRST # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt HIST_IGNORE_DUPS       # Don't append commands to history if they duplicate existing entries
setopt HIST_IGNORE_SPACE      # Don't append commands that start with space to the history
setopt HIST_VERIFY            # Expand history references (e.g. !!) instead of running right away
setopt INTERACTIVECOMMENTS    # Allow comments even in interactive shells.
setopt PROMPT_SUBST           # Make substitutions in prompt strings, allowing for coloring.
setopt SHARE_HISTORY          # share command history data across sessions

source "$DOTFILES_DIR/shell/vi-mode.zsh" # Doesn't work well if it's not first

source "$DOTFILES_DIR/shell/brew.zsh"
source "$DOTFILES_DIR/shell/custom_functions.zsh"
source "$DOTFILES_DIR/shell/fzf.zsh"
source "$DOTFILES_DIR/shell/keybindings.zsh"
source "$DOTFILES_DIR/shell/theme.zsh"
