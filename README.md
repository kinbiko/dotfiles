# Dotfiles

Here be daemons.

Works best for Mac. Will need modifications for Linux, but has been done with
relative success.

If you find anything here that's useful, and would like to show your
appreciation, I accept donations in the form of code reviews.  I've created
[this eternal PR](https://github.com/kinbiko/dotfiles/pull/14), where you may
leave a comment on anything you think could be improved.  This is also a good
way to ask questions about what setting `foo` does if it's not clear from the
comments.

Steal what you want, but don't expect my configs to work for you  out of the
box without any issues.  My vim mappings and configs are probably the most
interesting.  I've tried to document these as well as I could but if something
is undocumented Vim's `:help <thing>` is probably what you're looking for.  I
use the following directory structure, and some scripts/configuration may
assume this structure:

```
~/
  .ctags
  .idevimrc
  .khdrc
  .tmux.conf
  .tmux.conf.local
  .tmux.conf.local
  .vim-local/
  .vim/
  .vimrc
  .taskrc
  .zshrc
  screen-256-color-italic.terminfo
  xterm-256-color-italic.terminfo
  repos/
    dotfiles/
    other/
    repos/
```

The dotfiles in the home directory are designed to either source the
`~/repos/dotfiles` equivalent, if not be symlinks.

### Fonts

Install fonts:

```
brew tap caskroom/fonts
brew cask install font-hack-nerd-font
```
Set font in `iterm2>profile>text`

### Italics

Update the iterm profile to make italics available: append `-italic` to
`profile>terminal>report-terminal-type` to get `xterm-256color-italic`

Register the `terminfo` files with `tic`:

```
tic screen-256color-italic.terminfo
tic xterm-256color-italic.terminfo
```

TODO: This doesn't quite work within tmux yet
