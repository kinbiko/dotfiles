#!bin/bash

# Only install dependencies if they're not already there.
if ! hash htop; then
    brew install htop
    brew install ctags
    brew install zsh
    brew install tmux

    gem install tmuxinator
fi

dotfiles_dir=$1                     # dotfiles directory
old_dotfiles_dir=~/dotfiles_old     # old dotfiles backup directory

#Validate that both of these directories were provided.
die(){
    echo >&2 "$@"
    exit 1
}
[ "$#" -eq 1 ] || die "First argument should be path to dotfiles repository, none provided."

# list of files/folders to symlink in homedir
files="vimrc vim tmux.conf tmux.conf.local tmux oh-my-zsh tmuxinator zshrc ctags "

echo "Creating $old_dotfiles_dir for backup of any existing dotfiles in ~"
mkdir -p $old_dotfiles_dir

# change to the dotfiles directory
cd $dotfiles_dir
# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks 
echo "Moving any existing dotfiles from ~ to $old_dotfiles_dir"
for file in $files; do
    mv ~/$file ~/dotfiles_old/ 2 > /dev/null
    echo "Creating symlink to $file in home directory."
    ln -s $dotfiles_dir/$file ~/.$file > /dev/null
done

git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

#TODO: 
#Need to install brew and git
#Delete any old old_dotfiles if it exists
#Fix the submodule issue
#Write installation instructions
#Make executable, and depend on one parameter instead of two.
