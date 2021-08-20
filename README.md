# Dotfiles (MacOS)

These are the configuration files for CLI and TUI based tools I use in my local development environment:

- Terminal: `alacritty`
- Editor: `nvim`
- Shell: `zsh`
- Fuzzy finders: `ag` and `fzf`
- Honorable mentions: `tmux`, `git`
- Self-authored tools:
  - [`kokodoko`](https://github.com/kinbiko/kokodoko): for quickly generating links to GitHub.
  - [`upversion`](https://github.com/kinbiko/semver): for generating the correct next Git tag.
  - [`mokku`](https://github.com/kinbiko/mokku): for generating Go mocks that don't suck.

Works best for Mac OS (Catalina).
Seems to work alright on both `arm64` and `amd64` machines, just remember the `arch -arm64` prefix occasionally.

## Steps from a fresh install

1. Create a Git repository of the home directory, so you can go back in time if you mess up.
1. Type `git init` in the home directory.
   - You'll be prompted to install xcode command line tools. Accept.
   - Try `git init` in the home directory again, and use `config/git/gitignore-for-home-dir` as the `.gitignore` for this repo.
1. Password manager
1. Chrome
   1. Dev tools in dark mode
   1. Extensions:
      1. Adblock Plus
      1. Darkreader
      1. Password Manager
      1. Refined Github
      1. Rikaikun
      1. Vimium
   1. Set as default browser
1. Set up the Mac dock:
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
   1. System voice to fast, and start speaking with `CMD + ESC`
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
1. Symlink the `$XDG_CONFIG_HOME` directory: `ln -s $DOTFILES_DIR/config/ ~/.config`
1. Install the pretty font that's defined in the alacritty config: `brew tap homebrew/cask-fonts;brew install font-hack-nerd-font`
1. `brew install alacritty` so you can continue with a good terminal.
1. Install these other programs from `brew`: `bat diff-so-fancy fpp jq gh go lazygit neovim node the_silver_searcher tmux tree up wget zenith`
1. Install `prettier` from npm: `npm install -g prettier`
1. Run `compaudit | xargs chmod g-w` to ensure you have access to the completion files that were created in the previous step.
1. `oh-my-zsh`:
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
   go get -u github.com/kinbiko/mokku/cmd/mokku
   go get -u github.com/kinbiko/kokodoko/cmd/kokodoko
   go get -u github.com/kinbiko/semver/cmd/upversion
   ```
1. Hide fluffy directories from finder that I can't delete: `chflags hidden Applications Movies Music Pictures Public`
1. Set up `all-repos`:
   1. Install `all-repos`: `pip3 install all-repos`
   1. Move `all-repos.json` and `repos.json` to the home directory
   1. run `all-repos-clone` in the home directory.
