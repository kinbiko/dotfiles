#!/bin/bash
# Arch package installation.
# One full upgrade first, then a single -S: `pacman -Syu <pkg>` per line is a
# system upgrade each time, and partial upgrades are unsupported on Arch.
set -euo pipefail

# bootstrap.sh exports REPO; the fallback lets this script run standalone.
REPO=${REPO:-$(cd "$(dirname "$0")/../.." && pwd)}

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
  yazi \
  yt-dlp \
  zoxide

# Not in the official repos. Needs yay on PATH; bootstrap it by hand first:
#   git clone https://aur.archlinux.org/yay.git && (cd yay && makepkg -si)
if command -v yay >/dev/null 2>&1; then
  yay -S --needed --noconfirm \
    awww \
    quickshell \
    espanso-wayland \
    urlview \
    wox-bin \
    zen-browser-bin
else
  echo "yay not found; skipping AUR packages" >&2
fi

# Start espanso at login. The unit is tracked at linux/systemd/user/ and
# symlinked into place by link.sh, so this only has to enable it.
systemctl --user daemon-reload
systemctl --user enable --now espanso.service

# quickshell owns the notification daemon, but mako is D-Bus activated and
# would otherwise grab org.freedesktop.Notifications the moment anything sends
# a notification before the shell is up. Masking blocks that activation without
# uninstalling mako, so the fallback path in hyprland.conf stays one
# `systemctl --user unmask mako.service` away.
# quickshell.service itself is started by hyprland.conf, not enabled here - see
# the comment in linux/systemd/user/quickshell.service for why.
systemctl --user mask mako.service

# Launcher entries for actions with no application of their own (see
# linux/applications/README.md). They belong on the XDG *data* path, not in
# ~/.config, so link.sh does not reach them.
mkdir -p ~/.local/share/applications
for f in "$REPO"/linux/applications/*.desktop; do
  ln -sfn "$f" ~/.local/share/applications/"$(basename "$f")"
done
update-desktop-database ~/.local/share/applications 2>/dev/null || true
