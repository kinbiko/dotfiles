# Dotfiles

These are the configuration files for `vim`, `tmux`, `zsh` and other (generally CLI-based) tools I like for my development environment.
I've tried to document things as best as I can, but some bits I'm sure are still cryptic.

Works best for Mac OS (Mojave).

## Install

> **These reminders for myself, not instructions.**

Start off by installing [homebrew](https://brew.sh/), then install Git.

```bash
brew install git
```

There may be issues here around XCode CLI tools. Figure it out.

Then let's install some more goodies. These probably won't work as-is, as the correct tap must be specified for many.

```
brew install bat
brew install cmus
brew install ctags
brew install ctop
brew install diff-so-fancy
brew install fpp
brew install fzf
brew install gh
brew install go
brew install htop
brew install mongodb-community-shell
brew install neofetch
brew install neovim
brew install node
brew install pandoc
brew install the_silver_searcher
brew install tig
brew install tmux
brew install tree
brew install unrar
brew install vifm
brew install vim
brew install w3m
brew install watch
brew install weechat
brew install wget
brew install youtube-dl
brew install zsh

brew tap homebrew/cask-fonts

brew cask install alacritty
brew cask install alfred
brew cask install dash
brew cask install docker
brew cask install font-hack-nerd-font
brew cask install google-cloud-sdk
brew cask install iterm2
brew cask install keycastr
brew cask install now
brew cask install obs
brew cask install postman
brew cask install spotify
brew cask install steam
brew cask install transmission
brew cask install virtualbox
brew cask install vlc
```

Then clone this repository.
I generally tend to put all my repos in `$HOME/repos/`.

> Note: I usually define this path as a `DOTFILES_DIR` environment variable in `~/.zshrc`, but no guarantees that renaming this is all that's required to use a different directory.

Install `oh-my-zsh` based on the official installation instructions.

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

Then, you'll probably want to do the same pattern as above (source the dotfiles file, while keeping computer specific config below):

```
$HOME/.vimrc -> $DOTFILES_DIR/vimrc
$HOME/.tmux.conf -> $DOTFILES_DIR/tmux.conf
$HOME/.ideavimrc -> $DOTFILES_DIR/ideavimrc
```

symlink the following:

```bash
$HOME/.vim/ -> $DOTFILES_DIR/vim
$HOME/.ctags -> $DOTFILES_DIR/ctags
```

You'll then probably want to set up the Alfred <-> Dash integration.
For which you'll probably need the Dash/Alfred license keys.

Install vim plugins:

```bash
vim +PlugInstall +qall
```

To run with neovim instead of vim:

```
mkdir -p ~/.config/nvim
echo "set runtimepath^=~/.vim runtimepath+=~/.vim/after" >> ~/.config/nvim/init.vim
echo "let &packpath = &runtimepath" >> ~/.config/nvim/init.vim
echo "source ~/.vimrc" >> ~/.config/nvim/init.vim
```

Install prettier as that's required for one of the vim plugins (for markdown, js, ts, css)
