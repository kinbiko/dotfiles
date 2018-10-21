# Dotfiles

These are the configuration files for `vim`, `tmux`, `zsh` and other (generally CLI-based) tools I like for my development environment. I've tried to document things as best as I can, but there are still remnants from when I copied stuff from other people's setups, especially around `tmux`, without knowing what I was doing.

Works best for Mac OS (Mojave). Will need modifications for Linux, but has been done with relative success on arch-based distros.

If you find anything here that's useful (steal whatever you want), and would like to show your appreciation, I accept donations in the form of code reviews.
I've created [this eternal PR](https://github.com/kinbiko/dotfiles/pull/14), where you may leave a comment on anything you think could be improved.
This is also a good way to ask questions about what setting `foo` does if it's not clear from the comments.

## Installation guidelines

> These are not instructions. These are mainly reminders for myself. There's an install script that might work. But probably doesn't.

Start off by installing [homebrew](https://brew.sh/), then install Git.

```bash
brew install git
```

There may be issues here around XCode CLI tools. Figure it out.

Then let's install some more goodies:

```
brew install bat
brew install ctags
brew install dep
brew install diff-so-fancy
brew install fzf
brew install git
brew install go
brew install htop
brew install node
brew install the_silver_searcher
brew install tig
brew install tmux
brew install tree
brew install vifm
brew install vim
brew install watch

brew cask install alfred
brew cask install dash
brew cask install docker
brew cask install intellij-idea-ce
brew cask install iterm2
brew cask install java
brew cask install spotify
brew cask install vlc
```

Then clone this repository. I generally tend to put all my non-Go repos in `$HOME/repos/`, and the rest of the guide will assume this was done.

Install `zsh` and `oh-my-zsh`. I've stolen the installation script for `oh-my-zsh`, as at the time of writing the recommended installation process was to run a random shell command from the internet. (I suppose these instructions are too, but at least I know who wrote them.)

```bash
brew install zsh
zsh $DOTFILES_REPO/install-oh-my-zsh.sh
```

After installing `zsh` and `oh-my-zsh` you'll want to delete the default `.zshrc` file and replace with:

```bash
# This variable is used throughout the dotfiles.
# Should be the first line in order for everything to load appropriately
export DOTFILES_DIR=$HOME/repos/dotfiles
# The file that actually contains all the good stuff.
source $DOTFILES_DIR/zshrc

# Configurations specific to this computer
# ...
```


Then, you'll probably want to set up the following symlinks:

```bash
$HOME/.vimrc -> $DOTFILES_DIR/vimrc
$HOME/.vim/ -> $DOTFILES_DIR/vim
$HOME/.tmux.conf -> $DOTFILES_DIR/tmux.conf
$HOME/.ideavimrc -> $DOTFILES_DIR/ideavimrc
$HOME/.ctags -> $DOTFILES_DIR/ctags
$HOME/.config/vifm/vifmrc -> $DOTFILES_DIR/vifmrc
```

Set font in `iterm2>profile>text`

You'll then probably want to set up the Alfred <-> Dash integration. For which you'll probably need the Dash/Alfred license keys.

Install vim plugins:

```bash
vim +PlugInstall +qall
```

To run with neovim instead of vim:

```
brew install neovim
mkdir ~/.config/nvim
echo "set runtimepath^=~/.vim runtimepath+=~/.vim/after" >> ~/.config/nvim/init.vim
echo "let &packpath = &runtimepath" >> ~/.config/nvim/init.vim
echo "source ~/.vimrc" >> ~/.config/nvim/init.vim
```
