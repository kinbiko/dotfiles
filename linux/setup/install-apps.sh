#!/bin/bash
# Arch package installation.
# One full upgrade first, then a single -S: `pacman -Syu <pkg>` per line is a
# system upgrade each time, and partial upgrades are unsupported on Arch.
set -euo pipefail

sudo pacman -Syu --noconfirm

sudo pacman -S --needed --noconfirm \
  anki \
  bat \
  btop \
  direnv \
  fd \
  fzf \
  gh \
  ghostty \
  git-delta \
  go \
  golangci-lint \
  hyprland \
  jq \
  kanshi \
  mako \
  neovim \
  obsidian \
  pre-commit \
  ripgrep \
  sddm \
  tmux \
  tree \
  ttf-sourcecodepro-nerd \
  waybar \
  wl-clipboard \
  wofi \
  yazi \
  zoxide

# Not in the official repos.
yay -S --needed --noconfirm \
  espanso \
  fpp \
  swww \
  urlview
