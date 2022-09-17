#!/bin/bash

# If this next step fails: Install `oh-my-zsh` according to [their instructions](https://ohmyz.sh/).
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Make this your `~/.zshrc` (the oh-my-zsh generated `.zshrc` will be overwritten. That's OK):
cat << EOF > ~/.zshrc
export DOTFILES_DIR=$HOME/repos/dotfiles
source $DOTFILES_DIR/zshrc

# Configurations specific to this computer:
# ...
EOF

# Symlink the $XDG_CONFIG_HOME directory
ln -s $DOTFILES_DIR/config/ ~/.config

# Symlink the `.zshenv` file
ln -s $DOTFILES_DIR/zshenv ~/.zshenv
