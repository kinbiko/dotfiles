#!/bin/sh
# Create ~/.config/os and the per-tool symlinks that make the three content
# dirs look like a flat ~/.config to every tool that reads it.
set -eu

REPO=${REPO:-$(cd "$(dirname "$0")/../.." && pwd)}
OS=${OS:?OS must be set to linux or macos}

. "$REPO/common/setup/lib.sh"

# ~/.config/os -> linux | macos. Shared configs reference this one stable path
# instead of doing OS detection; tmux in particular cannot read shell vars.
ln -sfn "$OS" "$REPO/os"
echo "  os -> $OS"

# Mirror an existing repo directory into an existing real destination
# directory, one symlink per entry. Used when the destination cannot be
# replaced wholesale because a tool keeps its own state there (obsidian keeps
# plugin data, espanso creates match/packages).
link_into_dir() {
  srcdir=$1
  destdir=$2
  for f in "$srcdir"/* "$srcdir"/.[!.]*; do
    [ -e "$f" ] || continue
    target=$destdir/$(basename "$f")

    if [ -d "$f" ] && [ -d "$target" ] && [ ! -L "$target" ]; then
      # Recurse in a subshell: sh has no local variables, so a direct
      # recursive call would clobber this frame's loop state. Only filesystem
      # side effects need to escape, so a subshell loses nothing.
      ( link_into_dir "$f" "$target" )
    else
      backup_move "$target"
      ln -sfn "$f" "$target"
      echo "  ${target#"$REPO/"} -> ${f#"$REPO/"}"
    fi
  done
}

link_dir() {
  src=$1              # e.g. common/nvim
  name=$(basename "$src")
  dest="$REPO/$name"

  if [ -L "$dest" ] || [ ! -e "$dest" ]; then
    # Repo-relative target so ~/.config keeps working if the repo moves.
    ln -sfn "$src" "$dest"
    echo "  $name -> $src"
  elif [ -d "$dest" ]; then
    link_into_dir "$REPO/$src" "$dest"
  else
    backup_move "$dest"
    ln -sfn "$src" "$dest"
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
