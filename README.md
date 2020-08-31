# Dotfiles (MacOS)

These are the configuration files for `vim`, `tmux`, `zsh` and other (generally CLI-based) tools I like for my development environment, along with instructions on how to set up a Mac the way I like it.

Works best for Mac OS (Catalina).

## Steps from a fresh install

Pro tip: Create a git repository of the home directory, so you can go back in time if you mess up.

1. Chrome
   1. Dev tools in dark mode
   1. Extensions:
      1. Vimium
      1. Darkreader
      1. Github refined
      1. Adblock plus
   1. Set as default browser
1. Set up the dock:
   1. Move it to the left-hand side
   1. Make icons much smaller
   1. Pretty decent zoom
   1. Don't animate opening apps
   1. Don't show recent application in dock
   1. Automatically hide and show dock (to get back some screen real estate)
   1. Remove most apps from the dock apart from (final list:) Finder, Chrome, Alacritty, Trash
1. Set system-wide dark mode.
1. Keep track of 'none' recent items.
1. Revert scroll direction
1. Trackpad:
   1. Lookup and data detectors -> tap with three fingers
   1. Disable tap to click
1. Accessibility (this is where the good bits are):
   1. System voice to fast, and start speaking with `CMD + D`
   1. Set up 'type to siri'
   1. Zoom with ctrl + scroll
   1. Pointer control -> trackpad- > 3-finger drag
1. Keyboard:
   1. turn caps lock into ctrl
   1. Make key repeat super fast, not though GUI, but with commands: `https://apple.stackexchange.com/a/83923`
1. GitHub:
   1. Set up SSH keys and GPG keys following their official instructions. (Google it, any links might break)
1. Install [homebrew](https://brew.sh/)
1. Change language with alt + space, and have only two input sources:
   1. American English
   1. Hiragana
1. Install Magnet from the app store. (paid -- I believe there's a free alternative out there too, but I bought Magnet before I knew about it)
1. Clone this repo to `~/repos/dotfiles`
1. Make this your `~/.zshrc`:
   ```
   export DOTFILES_DIR=$HOME/repos/dotfiles
   source $DOTFILES_DIR/zshrc
   # Configurations specific to this computer
   # ...
   ```
1. Symlink (assuming you're in `~`):
   ```
   ln -s repos/dotfiles/alacritty.yml .alacritty.yml
   ln -s repos/dotfiles/vim .vim
   ln -s repos/dotfiles/tmux.conf .tmux.conf
   ln -s repos/dotfiles/tmux .tmux
   ln -s repos/dotfiles/ctags .ctags
   ```
1. `brew cask install alacritty` so you can continue with a good terminal.
1. `brew install fzf` and run `/usr/local/opt/fzf/install` and answer yes to auto-completion and key bindings, but no to updating shell config files.
1. Install these other programs from `brew`: `bat ctags diff-so-fancy pff gh go htop neovim the_silver_searcher tmux tree wget node`
1. Install `prettier` from npm: `npm install -g prettier`
1. Run `compaudit | xargs chmod g-w` to ensure you have access to the completion files that were created in the previous step.
1. Have `~/.zshrc` export a `DOTFILES_DIR=~/repos/dotfiles` directory, and source `$DOTFILES_DIR/zshrc`.
1. neovim:
   ```
   mkdir -p ~/.config/nvim
   echo "set runtimepath^=~/.vim runtimepath+=~/.vim/after" >> ~/.config/nvim/init.vim
   echo "let &packpath = &runtimepath" >> ~/.config/nvim/init.vim
   echo "source ~/.vimrc" >> ~/.config/nvim/init.vim
   echo "source ~/repos/dotfiles/vimrc" >> ~/.vimrc
   ```
1. Install the pretty font that's defined in the alacritty config: `brew tap homebrew/cask-fonts` `brew install font-hack-nerd-font`
1. oh-my-zsh:
   1. WARNING: This next step will override your `~/.zshrc`, make a copy, as you don't want the results!
   1. Install oh-my-zsh according to their instructions.
   1. replace `~/.zshrc` with the copy
1. Alfred:
   1. `brew cask install alfred` (definitely avoid app store -- it's horribly outdated)
   1. Disable spotlight cmd + space shortcut in keyboard -> shortuts -> spotlight
   1. Set alfred shortcut to cmd + space
   1. Set up jisho shortcut https://github.com/janclarin/jisho-alfred
1. Install other 'cask' apps:
   ```bash
   brew cask install docker
   brew cask install google-cloud-sdk
   brew cask install postman
   brew cask install spotify
   ```

TODO:

- Go applications I use like `mokku`, `pp` `up` and a pretty test parser
- Hiding fluffy directories from finder that I can't delete (e.g. Music, Movies, etc.)
