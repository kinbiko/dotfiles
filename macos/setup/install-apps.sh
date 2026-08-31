#!/bin/bash
set -euo pipefail

# Install brew
if ! command -v brew >/dev/null 2>&1; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# homebrew/cask-fonts was deprecated and emptied; its casks live in
# homebrew/cask now. Leaving the tap around makes every `brew update` fail.
brew untap homebrew/cask-fonts 2>/dev/null || true

# `brew install` on something already present is an error for --HEAD formulae
# and for versions that came from a tap, and casks whose artifacts already
# exist on disk. Install only what is missing; upgrades are `brew upgrade`.
formula() {
  local f
  for f in "$@"; do
    if brew list --formula --versions "$f" >/dev/null 2>&1; then
      echo "  formula $f already installed"
    else
      brew install "$f"
    fi
  done
}

cask() {
  local c
  for c in "$@"; do
    if brew list --cask --versions "$c" >/dev/null 2>&1; then
      echo "  cask $c already installed"
    else
      # --adopt takes over an app or font that is already on disk but that
      # brew does not know about, instead of erroring out.
      brew install --cask --adopt "$c"
    fi
  done
}

# Install the pretty font that's defined in the alacritty and ghostty configs
cask font-sauce-code-pro-nerd-font

# Install system-wide snippet engine
cask espanso

# Command line tools
formula bat           # cat but pretty
formula btop          # top but prettier
formula fd            # Opinionated alternative to 'find'.
formula fpp           # Open URLs visible in the terminal with the keyboard
formula fzf           # Fuzzy finder. Vim plugin doesn't install to path, nor sets up shell keybindings
formula gh            # GitHub CLI
formula git-delta     # Even better git diffs
formula go            # Go programming language
formula gpg           # For PGP signing
formula jq            # Query JSON
formula ncurses       # Required by fpp, and for the tmux-256color terminfo below
formula ripgrep       # Super fast grep-like application, used by FZF and telescope.nvim
formula tmux          # Terminal multiplexer
formula tree          # Show folders and files easily
formula urlview       # Required for fpp
formula zoxide        # Fast directory switching

# Editor. Tracks HEAD, which is what made the unguarded `brew install` fail on
# every rerun, so it gets the guard by hand rather than through formula().
if brew list --formula --versions neovim >/dev/null 2>&1; then
  echo "  formula neovim already installed"
else
  brew install --HEAD neovim
fi

# basic unix utils as you expect them to work
formula coreutils findutils gnu-tar gnu-sed gawk gnutls gnu-indent gnu-getopt grep

# UI Apps
cask alacritty
cask ghostty
cask alfred     # Productivity heaven
cask anki       # Flashcards
cask obsidian   # Second brain
cask qlmarkdown # Let finder's Preview understand Markdown files

go install github.com/kinbiko/jisho-alfred@latest # Required by the Jisho.org Alfred workflow

"$(brew --prefix)/opt/ncurses/bin/infocmp" tmux-256color >|~/tmux-256color.info
tic -xe tmux-256color ~/tmux-256color.info
infocmp tmux-256color | head
