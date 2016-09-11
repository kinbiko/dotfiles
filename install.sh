#!bin/bash

clear

dotfiles_dir=$1                     # dotfiles directory
old_dotfiles_dir=~/dotfiles_old     # old dotfiles backup directory

#Validate that both of these directories were provided.
die(){
    echo >&2 "$@"
    exit 1
}
[ "$#" -eq 1 ] || die "First argument should be path to dotfiles repository, none provided."

# list of files/folders to symlink in homedir
files="vimrc vim tmux.conf tmux"

echo "Creating $old_dotfiles_dir for backup of any existing dotfiles in ~"
mkdir -p $old_dotfiles_dir

# change to the dotfiles directory
cd $dotfiles_dir
# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks 
echo "Moving any existing dotfiles from ~ to $old_dotfiles_dir"
for file in $files; do
    mv ~/$file ~/dotfiles_old/ 2> /dev/null
    echo "Creating symlink to $file in home directory."
    ln -s $dotfiles_dir/$file ~/.$file
done

#This doesn't appear to be working as expected
git submodule update --init


#TODOS:
#Delete any old old_dotfiles if it exists
#Fix the submodule issue
