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
  github-cli \
  ghostty \
  git-delta \
  go \
  golangci-lint \
  hyprland \
  hyprlock \
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

# Not in the official repos. Needs yay on PATH; bootstrap it by hand first:
#   git clone https://aur.archlinux.org/yay.git && (cd yay && makepkg -si)
if ! command -v yay >/dev/null 2>&1; then
  echo "yay not found; skipping AUR packages" >&2
  exit 0
fi

yay -S --needed --noconfirm \
  awww \
  espanso-wayland \
  fpp \
  urlview
