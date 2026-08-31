# Dotfiles

This repo *is* `~/.config`. One branch, `main`, serves both an Arch Linux
(amd64, hyprland) machine and a macOS (Apple silicon) one. Platform
differences are expressed by where a file lives, not by which branch you are
on.

## Layout

```
~/.config/
  setup.sh              # the only thing you run
  common/               # everything that works on both systems
  linux/                # Wayland stack and Linux-only overrides
  macos/                # macOS-only overrides
  os -> linux           # symlink, created by setup, gitignored
  nvim -> common/nvim   # per-tool symlinks, created by setup, gitignored
  hypr -> linux/hypr
  ...
```

A tool goes in `common/` if it *can* run on both systems, even when it is
only used on one today. It goes in `linux/` or `macos/` only when it cannot
exist on the other.

`setup.sh` creates a symlink per tool, so every program still finds its
config at the usual `~/.config/<tool>` path.

### The `os` symlink

`~/.config/os` points at `linux/` or `macos/`. Shared configs reference that
one stable path rather than detecting the OS themselves:

```sh
# common/zsh/.zshrc
for f in "$XDG_CONFIG_HOME"/os/zsh/*.zsh(N); do source "$f"; done
```

```tmux
# common/tmux/tmux.conf
source-file ~/.config/os/tmux/local.conf
```

tmux cannot read shell variables, so a symlink is the only mechanism both zsh
and tmux can follow without bespoke logic on each side.

## Setup from a fresh install

1. Set up the password manager and a browser, and check the browser plugin
   works.
2. Set up SSH keys in GitHub following
   [the official instructions](https://docs.github.com/en/authentication/connecting-to-github-with-ssh).
   On macOS you will be prompted to install the Xcode command line tools on
   first `git` invocation; accept, and wait.
3. Clone this repo over `~/.config`:

   ```sh
   git clone git@github.com:kinbiko/dotfiles.git ~/.config
   ```

4. Run it:

   ```sh
   ~/.config/setup.sh
   ```

   This creates the symlinks, points zsh at the repo, and installs packages.

5. Create `~/.local.gitconfig` with this machine's email address. The repo
   deliberately sets no `user.email`, so commits fail loudly until you do:

   ```
   [user]
     email = your@email.com
   ```

6. Open a new shell.

## Post-install

### Both platforms

- `gh auth login` to authenticate the GitHub CLI.
- Set up GPG and configure commit signing, following
  [the GitHub instructions](https://docs.github.com/en/authentication/managing-commit-signature-verification).
  **Always check that these steps still follow best security practices.**
- Set `GOPRIVATE` for private Go modules.
- Set up Yomitan and Anki for Japanese study.

### Arch

- Enable the display manager: `sudo systemctl enable sddm`.
- The Wayland stack (hyprland, waybar, wox, mako, kanshi, swww) is installed
  by `linux/setup/install-apps.sh`; AUR packages need `yay` on PATH first.

### macOS

Additional tools not yet in the setup script (install via `brew`):

- `uv` (Python toolchain)
- `git-lfs`
- `docker` (Docker Desktop cask)
- `google-cloud-sdk` (cask)
- `kubectl`
- `kubectx` (provides `kubectx` and `kubens`)
- `claude-code`

Install Better Snap Tool from the App Store.

#### Wox

- Disable the spotlight cmd + space shortcut in keyboard -> shortcuts ->
  spotlight
- Set the Wox query hotkey to `cmd + space`.
- Grant Accessibility and (if you use the screenshot plugin) Screen Recording
  permissions when prompted.
- Add a theme.
- Set up clipboard history. Map to `cmd + p` (who prints these days anyway?)

#### System preferences

Run `macos/setup/system-config.sh`.

Also run:

- `defaults write -g ApplePressAndHoldEnabled -bool false` (then
  logout/login) to disable letter variations on key hold.
- `touch ~/.hushlogin` to remove the "Last login" line from new shells.

Do the rest manually for now, until I figure out the command-line commands to
run for all of these.

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
   1. Pointer control -> trackpad -> 3-finger drag
1. Change language with alt + space, and have only two input sources:
   1. American English
   1. Hiragana
1. Keyboard:
   1. Turn caps lock into ctrl
   1. Disable auto-correct
1. Add the relevant `repos/*` directories (e.g. `repos/kinbiko`) to the
   Finder sidebar.
