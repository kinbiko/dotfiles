#!/bin/bash

pacman -Syu anki
pacman -Syu bat 
pacman -Syu btop                        
pacman -Syu espanso
pacman -Syu fd
pacman -Syu fpp
pacman -Syu fzf
pacman -Syu gh
pacman -Syu ghostty
pacman -Syu git-delta
pacman -Syu go
pacman -Syu golangci-lint
pacman -Syu jq
pacman -Syu neovim
pacman -Syu obsidian
pacman -Syu pre-commit
pacman -Syu rg
pacman -Syu tmux
pacman -Syu tree
pacman -Syu urlview
pacman -Syu zoxide

go install github.com/kinbiko/kokodoko/cmd/kokodoko@latest # Required by neovim bindings
go install github.com/kinbiko/mokku/cmd/mokku@latest
go install github.com/kinbiko/semver/cmd/upversion@latest
