# Dotfiles

Here be daemons.

Works best for Mac. Will need modifications for Linux, but has been done with relative success.

Steal what you want, but don't expect my configs to work for you without any issues.
My vim mappings and configs are probably the most interesting.
I've tried to document these as well as I could but if something is undocumented Vim's `:help <thing>` is probably what you're looking for.

I use the following directory structure, and some scripts/configuration may assume this structure:

```
~/
  .vimrc
  .tmux.conf
  .tmux.conf.local
  .tmux.conf.local
  .zshrc
  .ctags
  .idevimrc
  .khdrc
  .vim/
  repos/
    dotfiles/
    other/
    repos/
```

The dotfiles in the home directory are designed to either source the `~/repos/dotfiles` equivalent, if not be symlinks.
