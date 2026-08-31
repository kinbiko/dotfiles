#!/bin/sh
# Create ~/.config/os and the per-tool symlinks that make the three content
# dirs look like a flat ~/.config to every tool that reads it.
set -eu

REPO=${REPO:-$(cd "$(dirname "$0")/../.." && pwd)}
OS=${OS:?OS must be set to linux or macos}

# ~/.config/os -> linux | macos. Shared configs reference this one stable path
# instead of doing OS detection; tmux in particular cannot read shell vars.
ln -sfn "$OS" "$REPO/os"
echo "  os -> $OS"

link_dir() {
  src=$1              # e.g. common/nvim
  name=$(basename "$src")
  dest="$REPO/$name"

  if [ -L "$dest" ]; then
    ln -sfn "$src" "$dest"
    echo "  $name -> $src"
  elif [ -d "$dest" ]; then
    # Some tools (obsidian) keep their own state in ~/.config/<name>, so the
    # directory cannot be replaced. Link the individual config files into it
    # instead, and leave anything already there alone.
    for f in "$REPO/$src"/* "$REPO/$src"/.[!.]*; do
      [ -e "$f" ] || continue
      base=$(basename "$f")
      if [ -e "$dest/$base" ] && [ ! -L "$dest/$base" ]; then
        echo "  SKIP $name/$base: exists and is not a symlink" >&2
      else
        ln -sfn "$f" "$dest/$base"
        echo "  $name/$base -> $src/$base"
      fi
    done
  elif [ -e "$dest" ]; then
    echo "  SKIP $name: $dest already exists and is not a symlink" >&2
  else
    ln -s "$src" "$dest"
    echo "  $name -> $src"
  fi
}

# common/ first, then the OS dir. Anything in the OS dir that shares a name
# with a common/ dir is an *overlay* reached through ~/.config/os, not a
# top-level link, so it is skipped here.
for d in "$REPO"/common/*/; do
  name=$(basename "$d")
  [ "$name" = "setup" ] && continue
  link_dir "common/$name"
done

for d in "$REPO/$OS"/*/; do
  name=$(basename "$d")
  [ "$name" = "setup" ] && continue
  [ -d "$REPO/common/$name" ] && continue   # overlay, reached via os/
  link_dir "$OS/$name"
done
