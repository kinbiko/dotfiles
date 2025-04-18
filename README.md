# Dotfiles (macOS)

Works best for macOS (silicon).

## Setup steps from a fresh install

### Create a Git repo of home directory

Open Terminal (for now) and run `git init` in the home directory, so you can go back in time if you mess up.
You'll be prompted to install Xcode command line tools. Accept. Wait.

Once that's done set up the git repo in home with (replace with appropriate email):

```
git config --global user.name "kinbiko"
git config --global user.email "your@email.com"

# Try `git init` in the home directory again.
cd
git init

# Use `config/git/gitignore-for-home-dir` as the `.gitignore` for this repo:
curl https://raw.githubusercontent.com/kinbiko/dotfiles/master/config/git/git-ignore-for-home-dir > .gitignore
git add .
git commit -m 'Initial commit'
```

### Start getting access

Set up the password manager, and install a better browser.

### Fetch and use this repo

Set up SSH keys in GitHub following [the official instructions](https://docs.github.com/en/authentication/connecting-to-github-with-ssh).

Clone this repo:

```sh
git clone git@github.com:kinbiko/dotfiles.git ~/.config
```

Set up zsh: `setup/set-up-zsh.sh`

If you close your current shell and open a new one, it should look pretty (and have a few extra features).
That said, most software is not yet installed.

### Install software

Install `brew` and install packages with `setup/install-brew-and-apps.sh`.

You can now close Terminal and use a better one.

### Post-install software configuration

#### Alfred

- Disable spotlight cmd + space shortcut in keyboard -> shortuts -> spotlight
- Set Alfred shortcut to `cmd + space`
- Add a theme to Alfred.
- Set up [the Jisho.org workflow](https://github.com/kinbiko/jisho-alfred).
- Set up clipboard history. Map to `cmd + p` (who prints these days anyway?)

#### Japanese language learning

- Set up Yomitan
- Set up Anki

## System preferences

Run `setup/mac-system-config.sh`

Do the rest manually for now, until I figure out the command-line commands to run for all of these.

1. Set up the Mac dock:
   1. Move it to the left-hand side
   1. Make icons much smaller
   1. Pretty decent zoom
   1. Don't animate opening apps
   1. Don't show recent application in dock
   1. Automatically hide and show dock (to get back some screen real estate)
   1. Remove most apps from the dock.
1. Set system-wide theme.
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
1. Change language with alt + space, and have only two input sources:
   1. American English
   1. Hiragana
1. Keyboard:
   1. Turn caps lock into ctrl
