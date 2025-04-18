#!/bin/bash

# Install brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install the pretty font that's defined in the alacritty config
brew tap homebrew/cask-fonts
brew install font-sauce-code-pro-nerd-font

# Install system-wide snippet engine
brew tap espanso/espanso
brew install espanso

# Command line tools
brew install bat           # cat but pretty
brew install btop          # top but prettier
brew install curses        # Required for fpp
brew install fd            # Opinionated alternative to 'find'.
brew install fpp           # Open URLs visible in the terminal with the keyboard
brew install fzf           # Fuzzy finder. Vim plugin doesn't install to path, nor sets up shell keybindings
brew install gh            # GitHub CLI
brew install git-delta     # Even better git diffs
brew install go            # Go programming language
brew install gpg           # For PGP signing
brew install grpcurl       # For making gRPC requests from the command line
brew install jq            # Query JSON
brew install ncurses       # Pretty terminal stuff -- needed for tmux-256color
brew install --HEAD neovim # Editor
brew install pinentry-mac  # Lets you enter passwords with a TUI when signing git commits
brew install rg            # Super fast grep-like application, used by FZF and telescope.nvim
brew install skim          # PDF viewer with auto-refresh functionality for writing LaTeX
brew install tmux          # Terminal multiplexer
brew install tree          # Show folders and files easily
brew install up            # Incrementally build long pipes
brew install urlview       # Required for fpp
brew install zoxide        # Fast directory switching

# basic unix utils as you expect them to work
brew install coreutils findutils gnu-tar gnu-sed gawk gnutls gnu-indent gnu-getopt grep

# UI Apps
brew install alfred     # Productivity heaven
brew install anki       # Flashcards
brew install obsidian   # Second brain
brew install qlmarkdown # Let finder's Preview understand Markdown files

go install github.com/kinbiko/kokodoko/cmd/kokodoko@latest # Required by neovim bindings
go install github.com/kinbiko/jisho-alfred@latest          # Required by the Jisho.org Alfred workflow

# Optional
go install github.com/kinbiko/mokku/cmd/mokku@latest
go install github.com/kinbiko/semver/cmd/upversion@latest

"$(brew --prefix)/opt/ncurses/bin/infocmp" tmux-256color >|~/tmux-256color.info
tic -xe tmux-256color ~/tmux-256color.info
infocmp tmux-256color | head
