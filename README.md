# Dotfiles (MacOS)

Works best for Mac OS (silicon).

## Setup steps from a fresh install

### Create a Git repo of home directory

Open Terminal (for now) and run `git init` in the home directory, so you can go back in time if you mess up.
You'll be prompted to install xcode command line tools. Accept. Wait.

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

Set up the password manager, and install Chrome.
Set Chrome as the default browser and set up sync to get extensions, settings, and bookmarks set up.
Make sure the password manager browser plugin works.

### Fetch and use this repo

Set up SSH keys in GitHub following [the official instructions](https://docs.github.com/en/authentication/connecting-to-github-with-ssh).

Clone this repo:

```
cd
mkdir repos
cd repos
git clone git@github.com:kinbiko/dotfiles.git
```

Set up zsh: `setup/set-up-zsh.sh`

If you close your current shell and open a new one, it should look pretty (and have a few extra features).
That said, most software is not yet installed.

### Install software

Install `brew` and install packages with `setup/install-brew-and-apps.sh`.

You can now close Terminal and use Alacritty instead.

Install [BetterSnapTool](https://folivora.ai/bettersnaptool) (not free -> no brew cask available).

### Post-install software configuration

#### Alfred

- Disable spotlight cmd + space shortcut in keyboard -> shortuts -> spotlight
- Set Alfred shortcut to `cmd + space`
- Add the [Nord theme to Alfred](https://www.alfredapp.com/extras/theme/5Y8E7URIWQ/).
- ~~Set up [jisho shortcut](https://github.com/janclarin/jisho-alfred)~~ This is sadly broken.
- Set up clipboard history. Map to `cmd + p` (who prints these days anyway?)

#### Sign git commits with GPG

Follow [the GitHub instructions](https://docs.github.com/en/authentication/managing-commit-signature-verification) if you get lost.

**Always check that these steps still follow best security practices**.

The following will prompt you to follow an interactive setup:

```
gpg --full-gen-key
```

Defaults are fine, but set your email to be the same as your GitHub email.

Run `gpg --list-secret-keys` to see your generated key ID.
Generate the public key using this ID:

```
$ gpg --armor --export $KEY_ID | pbcopy
```

Add this GPG key to GitHub via the UI.

Configure git to always sign commits:

```
git config --global gpg.program $(which gpg)
git config --global user.signingkey $KEY_ID
git config --global commit.gpgsign true
```

Then set the pinentry program to be pinentry-mac and restart the gpg-agent:

```
echo "pinentry-program $(which pinentry-mac)" >> ~/.gnupg/gpg-agent.conf
killall gpg-agent
```

### FZF

Install shell bindings like ctrl+r and ctrl+t.

```
/opt/homebrew/opt/fzf/install # Install key bindings
```

#### Other

Basically, I can't be arsed to write up detailed instructions for these tools.

- Set up Japanese language learning software: Yomichan and Anki
- Set up any auth required for ops and infra (`google-cloud-sdk`, `terraform`, `k8s`, `gh`, etc.)

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
1. Change language with alt + space, and have only two input sources:
   1. American English
   1. Hiragana
1. Keyboard:
   1. Turn caps lock into ctrl
