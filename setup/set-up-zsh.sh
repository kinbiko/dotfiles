#!/bin/zsh

source "~/.config/shell/.zshenv"
# .zshenv contains $XDG_CONFIG_HOME so link only after this environment
# variable is available
ln -s "$XDG_CONFIG_HOME/shell/.zshenv" ~/.zshenv

# Single quotes here is correct. Want to refer to the variable name in zsh, not
# the value it has at the time of install.
echo 'source $XDG_CONFIG_HOME/shell/.zshrc' >~/.zshrc
