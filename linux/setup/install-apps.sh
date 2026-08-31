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
  fcitx5 \
  fcitx5-configtool \
  fcitx5-gtk \
  fcitx5-mozc \
  fcitx5-qt \
  fd \
  fzf \
  ghostty \
  git-delta \
  github-cli \
  go \
  golangci-lint \
  hyprland \
  hyprlock \
  jq \
  kanshi \
  kubectl \
  mako \
  neovim \
  obsidian \
  pre-commit \
  ripgrep \
  sddm \
  tmux \
  tree \
  ttf-sourcecodepro-nerd \
  ueberzugpp \
  waybar \
  wl-clipboard \
  wofi \
  yazi \
  yt-dlp \
  zoxide

# Not in the official repos. Needs yay on PATH; bootstrap it by hand first:
#   git clone https://aur.archlinux.org/yay.git && (cd yay && makepkg -si)
if command -v yay >/dev/null 2>&1; then
  yay -S --needed --noconfirm \
    awww \
    espanso-wayland \
    urlview \
    zen-browser-bin
else
  echo "yay not found; skipping AUR packages" >&2
fi

# Start espanso at login. The unit is tracked at linux/systemd/user/ and
# symlinked into place by link.sh, so this only has to enable it.
systemctl --user daemon-reload
systemctl --user enable --now espanso.service
