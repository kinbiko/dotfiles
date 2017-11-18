# Dotfiles

Here be daemons.

Works best for Mac. Will need modifications for Linux, but has been done with
relative success.

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
  .zshrc
  repos/
    dotfiles/
    other/
    repos/
```

The dotfiles in the home directory are designed to either source the
`~/repos/dotfiles` equivalent, if not be symlinks.
