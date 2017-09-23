#!/bin/bash

dotfiles_dir=~/repos/dotfiles       # dotfiles directory
old_dotfiles_dir=~/dotfiles_old     # old dotfiles backup directory

# list of files/folders to symlink in homedir
files="vimrc vim tmux.conf tmux.conf.local tmux oh-my-zsh zshrc ctags"
  
echo "Creating $old_dotfiles_dir for backup of any existing dotfiles in ~"
mkdir -p $old_dotfiles_dir
  
cd $dotfiles_dir

echo "Moving any existing dotfiles from ~ to $old_dotfiles_dir"
for file in $files; do
    mv ~/$file ~/dotfiles_old/ 2 > /dev/null
    echo "Creating symlink to $file in home directory."
    ln -s $dotfiles_dir/$file ~/.$file > /dev/null
done