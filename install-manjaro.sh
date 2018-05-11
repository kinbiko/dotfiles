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
pacman -S the_silver_searcher #'ag' in the terminal
pacman -S newsboat
pacman -S go
pacman -S ruby
pacman -S spotify
pacman -S nodejs
pacman -S pidgeon
pacman -S jdk8-openjdk
pacman -S emacs # shh! you didn't see anything...
pacman -S texlive-most #LaTeX etc. This is a more interactive install prompt compared to the others.
pacman -S xcape #Tool for remapping caps-lock to be control when held and escape when pressed

#
# Set up docker
#
pacman -S docker
# start the docker daemon on startup
systemctl enable docker
# give the current user permissions to use the docker group
usermod -a -G docker $USER

#
# Set up spacemacs
#
git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d

echo "You must reboot to before using docker"
