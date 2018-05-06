#!/bin/bash

# Update first
pacman -Syu --noconfirm

# Install packages

pacman -S vim
pacman -S git
pacman -S tmux
# pacman -S ranger # Has a bug re: python 3.5 changes -> use AUR in the mean time
yaourt -S ranger-git
pacman -S rofi # Alfred thingy
pacman -S ctags
pacman -S fzf
pacman -S the_silver_searcher
pacman -S newsboat
pacman -S go
pacman -S ruby
pacman -S spotify
pacman -S nodejs
pacman -S jdk8-openjdk

pacman -S docker
# start the docker daemon on startup
systemctl enable docker
# give the current user permissions to use the docker group
usermod -a -G docker $USER


echo "You must reboot to before using docker"

# TODO
# Fix glyphs in terminal font
# Save my config to my dotfiles, in particular ~/.i3 and ~/.config, .newsboat
# install brave
# Install, configure and learn mutt
# Install, configure and learn an IRC client
# install a music player. cmus?
# install a video player. vlc?
# Attempt to migrate to nvim or spacemacs
# Fix fzf w.r.t. ctrl+r and ctrl+t works again
# Make it so that I can do the following with a single keyboard shortcut:
#   Change keyboard layouts (uk qwerty, hiragana, colemak)
# Configure tmux
# Disable the new(?) loud warnings in vim (e.g. attempting to paste empty buffer)
