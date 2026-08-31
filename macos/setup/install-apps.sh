#!/bin/bash

# Install brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install the pretty font that's defined in the alacritty and ghostty configs
brew tap homebrew/cask-fonts
brew install font-sauce-code-pro-nerd-font

# Install system-wide snippet engine
brew tap espanso/espanso
brew install espanso

# Command line tools
brew install bat           # cat but pretty
brew install btop          # top but prettier
brew install fd            # Opinionated alternative to 'find'.
brew install fpp           # Open URLs visible in the terminal with the keyboard
brew install fzf           # Fuzzy finder. Vim plugin doesn't install to path, nor sets up shell keybindings
brew install gh            # GitHub CLI
brew install git-delta     # Even better git diffs
brew install go            # Go programming language
brew install gpg           # For PGP signing
brew install jq            # Query JSON
brew install ncurses       # Required by fpp, and for the tmux-256color terminfo below
brew install --HEAD neovim # Editor
brew install ripgrep       # Super fast grep-like application, used by FZF and telescope.nvim
brew install tmux          # Terminal multiplexer
brew install tree          # Show folders and files easily
brew install urlview       # Required for fpp
brew install zoxide        # Fast directory switching

# basic unix utils as you expect them to work
brew install coreutils findutils gnu-tar gnu-sed gawk gnutls gnu-indent gnu-getopt grep

# UI Apps
brew install alacritty
brew install ghostty
brew install alfred     # Productivity heaven
brew install anki       # Flashcards
brew install obsidian   # Second brain
brew install qlmarkdown # Let finder's Preview understand Markdown files

go install github.com/kinbiko/jisho-alfred@latest # Required by the Jisho.org Alfred workflow

"$(brew --prefix)/opt/ncurses/bin/infocmp" tmux-256color >|~/tmux-256color.info
tic -xe tmux-256color ~/tmux-256color.info
infocmp tmux-256color | head
