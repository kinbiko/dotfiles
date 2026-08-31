#!/bin/sh
# Helpers shared by the setup scripts. Sourced, never executed.

# Symlinks are never backed up: the repo already holds the content they point
# at, and backing them up would leave a new .bak file behind on every rerun.

_backup_name() {
  _bk=$1.bak.$(date +%Y%m%d-%H%M%S)
  # Nanoseconds are not portable, so disambiguate reruns within the same
  # second with a counter.
  _bkn=1
  while [ -e "$_bk" ]; do
    _bk=$1.bak.$(date +%Y%m%d-%H%M%S).$_bkn
    _bkn=$((_bkn + 1))
  done
  echo "$_bk"
}

# Move an existing path aside, leaving nothing behind. For paths we replace.
backup_move() {
  [ -e "$1" ] || return 0
  if [ -L "$1" ]; then return 0; fi
  _dst=$(_backup_name "$1")
  mv "$1" "$_dst"
  echo "  BACKUP $1 -> $_dst"
}

# Copy an existing path aside, leaving the original in place. For paths we
# edit rather than replace.
backup_copy() {
  [ -e "$1" ] || return 0
  if [ -L "$1" ]; then return 0; fi
  _dst=$(_backup_name "$1")
  cp -R "$1" "$_dst"
  echo "  BACKUP $1 -> $_dst"
}
