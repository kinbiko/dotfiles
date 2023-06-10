#!/bin/zsh

echo 'source $DOTFILES_DIR/zshrc' >~/.zshrc

# DOTFILES_DIR is defined in zshenv
source "$HOME/repos/dotfiles/zshenv"
ln -s "$DOTFILES_DIR/config/" ~/.config
ln -s "$DOTFILES_DIR/zshenv" ~/.zshenv
