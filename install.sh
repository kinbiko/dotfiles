#!/bin/bash

set -e

# Symlink the vimrc and .vim directory
# This is so that if shit happens, at least I'll be able to edit stuff
if [ ! -f ~/.vimrc ]; then
  ln -s ~/repos/dotfiles/vim/ ~/.vim
  ln -s ~/repos/dotfiles/vimrc ~/.vimrc
  # Install the plugins from the shell:
  # Run PlugInstall and then close all buffers once done
  vim +PlugInstall +qall
fi

# Create a .zshrc file which simply sources the versioned zshrc
# This is so that the shell can be extended with local environment variables
# and aliases etc. for each computer I use.
if [ ! -f ~/.zshrc ]; then
  source ~/repos/dotfiles/install-oh-my-zsh.sh
  echo "source ~/repos/dotfiles/zshrc" > ~/.zshrc
fi

# Install fonts
git clone https://github.com/powerline/fonts.git
cd fonts
./install.sh
cd ../
rm -rf fonts
