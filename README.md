# Dotfiles (MacOS)

These are the configuration files for `vim`, `tmux`, `zsh` and other (generally CLI-based) tools I like for my development environment, along with instructions on how to set up a Mac the way I like it.

Works best for Mac OS (Catalina).

## Steps from a fresh install

Pro tip: Create a git repository of the home directory, so you can go back in time if you mess up.

1. Type `git init` in the home directory.
   - You'll be prompted to install xcode command line tools. Accept.
   - Try `git init` in the home directory again, and ignore the following directories:
     ```
     Applications/
     Desktop/
     Documents/
     Downloads/
     Library/
     Movies/
     Music/
     Pictures/
     Public/
     .Trash/
     zsh_history
     zsh_sessions/
     go/
     .npm/
     ```
1. Password manager
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
1. Automatically hide the menu bar.
1. Keep track of 'none' recent items.
1. Revert scroll direction
1. Trackpad:
   1. Lookup and data detectors -> tap with three fingers
   1. Disable tap to click
1. Accessibility (this is where the good bits are):
   1. System voice to fast, and start speaking with `CMD + D`
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
1. Install oh-my-zsh according to their installation instructions.
1. Make this your `~/.zshrc`:
   ```
   export DOTFILES_DIR=$HOME/repos/dotfiles
   source $DOTFILES_DIR/zshrc
   # Configurations specific to this computer
   # ...
   ```
1. Symlink (assuming you're in `~`):
   ```
   ln -s $DOTFILES_DIR/config/tmux ~/.config/tmux
   ```
1. Configure global git ignore: `git config --global core.excludesFile '~/repos/dotfiles/.gitignore-global'`
1. Install the pretty font that's defined in the alacritty config: `brew tap homebrew/cask-fonts;brew install font-hack-nerd-font`
1. `brew install alacritty` so you can continue with a good terminal.
1. `brew install fzf` and run `/usr/local/opt/fzf/install` and answer yes to auto-completion and key bindings, but no to updating shell config files.
1. Install these other programs from `brew`: `bat diff-so-fancy fpp jq gh go lazygit neovim the_silver_searcher tmux tree up wget zenith node docker google-cloud-sdk postman`
1. Install `prettier` from npm: `npm install -g prettier`
1. Run `compaudit | xargs chmod g-w` to ensure you have access to the completion files that were created in the previous step.
1. neovim:
   ```
   mkdir -p ~/.config/nvim
   echo "set runtimepath^=~/.vim runtimepath+=~/.vim/after" >> ~/.config/nvim/init.vim
   echo "let &packpath = &runtimepath" >> ~/.config/nvim/init.vim
   echo "source ~/.vimrc" >> ~/.config/nvim/init.vim
   echo "source ~/repos/dotfiles/vimrc" >> ~/.vimrc
   ```
1. oh-my-zsh:
   1. WARNING: This next step will override your `~/.zshrc`, make a copy, as you don't want the results!
   1. Install oh-my-zsh according to their instructions.
   1. replace `~/.zshrc` with the copy
1. Alfred:
   1. `brew install alfred` (definitely avoid app store -- it's horribly outdated)
   1. Disable spotlight cmd + space shortcut in keyboard -> shortuts -> spotlight
   1. Set alfred shortcut to cmd + space
   1. Add Nord theme to Alfred: https://www.alfredapp.com/extras/theme/5Y8E7URIWQ/
   1. Set up jisho shortcut https://github.com/janclarin/jisho-alfred
   1. Set up clipboard history. Map to `cmd + p` (who prints these days anyway?)
1. Install go development tools:
   ```console
   go get -u github.com/mfridman/tparse
   go get -u github.com/kinbiko/mokku/cmd/mokku
   go get -u github.com/kinbiko/kokodoko/cmd/kokodoko
   ```
1. Hide fluffy directories from finder that I can't delete: `chflags hidden Applications Movies Music Pictures Public`
1. Set up `all-repos`:
   1. Install `all-repos`: `pip3 install all-repos`
   1. Move `all-repos.json` and `repos.json` to the home directory
   1. run `all-repos-clone` in the home directory.
