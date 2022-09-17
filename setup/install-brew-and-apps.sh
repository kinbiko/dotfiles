#!/bin/bash

# Install brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install the pretty font that's defined in the alacritty config
brew tap homebrew/cask-fonts;brew install font-hack-nerd-font

# Command line tools
brew install bat # cat but pretty
brew install btop # top but prettier
brew install diff-so-fancy # Even better git diffs
brew install fpp # Open URLs visible in the terminal with the keyboard
brew install jq # Query JSON
brew install gh # GitHub CLI
brew install go # Go programming language
brew install golangci-lint # Linter for Go
brew install google-cloud-sdk # For interacting with GCP
brew install gpg # For PGP signing
brew install neovim # Editor
brew install node # Global installation required to install prettier
brew instlal pinentry-mac # Lets you enter passwords with a TUI when signing git commits
brew install pre-commit # Framework for setting up Git hooks
brew install terraform # Infra as code
brew install the_silver_searcher # ag grep alternative
brew install tmux # Terminal multiplexer
brew install tree # Show folders and files easily
brew install up # Incrementally build long pipes
brew install urlview # Required for fpp

# UI Apps
brew install alacritty # good terminal emulator
brew install alfred # Productivity heaven
brew install anki # Flashcards
brew install deepl # Translation app, much better than google translate
brew install obsidian # Second brain
brew install spotify # Music

# Expected to be installed in vim config
go install github.com/kinbiko/kokodoko/cmd/kokodoko@latest

# Not required
go install github.com/kinbiko/mokku/cmd/mokku@latest
go install github.com/kinbiko/semver/cmd/upversion@latest

# Makes panic output pretty when piping log output in with
# go run myapp |& pp
go install github.com/maruel/panicparse/v2/cmd/pp@latest

# Install prettier from npm (used by vim)
npm install -g prettier
