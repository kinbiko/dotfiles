# Dotfiles (arch)

Works best for Arch-linux (amd64) with hyprland.

## Setup steps from a fresh install

### Create a Git repo of home directory

Install `git` if it's not there already.
Open a terminal and run `git init` in the home directory, so you can go back in time if you mess up.

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

Set up the password manager, and install a browser.
Make sure the password manager browser plugin works.

### Fetch and use this repo

Set up SSH keys in GitHub following [the official instructions](https://docs.github.com/en/authentication/connecting-to-github-with-ssh).

Clone this repo:

```sh
git clone git@github.com:kinbiko/dotfiles.git -b arch ~/.config
```

Set up zsh: `setup/set-up-zsh.sh`

If you close your current shell and open a new one, it should look pretty (and have a few extra features).
That said, most software is not yet installed.

### Install software

Install packages with `setup/install-apps.sh`.

You can now use a better terminal instead.

### Post-install software configuration

#### Sign git commits with GPG

Follow [the GitHub instructions](https://docs.github.com/en/authentication/managing-commit-signature-verification) if you get lost.

**Always check that these steps still follow best security practices**.

#### Japanese language learning software

- Set up Yomichan
- Set up Anki
