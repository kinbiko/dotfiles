#!/bin/sh
# Lock the screen.
#
# hyprlock.conf reads one fixed path (~/.config/wallpapers/lockscreen), so
# choosing an image means repointing that symlink before handing over. The
# image is picked from the first of these that applies:
#
#   1. an argument:      lock.sh ~/.config/wallpapers/totoro.jpg
#   2. a pinned choice:  a path (or symlink) in ~/.config/hypr/lockscreen-image
#   3. otherwise:        a random solarpunk-* from the wallpaper directory
#
# Pin one with:
#   echo ~/.config/wallpapers/starry-night.png > ~/.config/hypr/lockscreen-image
# and go back to shuffling by deleting that file. Both callers (the SUPER+X
# bind and the "Lock Screen" launcher entry) pick the change up, which is why
# the pin lives in a file rather than in either caller.
#
# This is a script rather than an inline bind because a .desktop Exec key
# cannot carry this much shell quoting.
set -eu

wp="$HOME/.config/wallpapers"
pin="$HOME/.config/hypr/lockscreen-image"
choice=""

if [ $# -gt 0 ]; then
	choice=$1
elif [ -f "$pin" ]; then
	# Strip surrounding whitespace and expand a leading ~, so the file can be
	# written by hand without ceremony.
	choice=$(sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//' -e "s|^~|$HOME|" "$pin" | head -n1)
elif [ -d "$wp" ]; then
	choice=$(find -L "$wp" -maxdepth 1 -name 'solarpunk-*' | shuf -n1)
fi

# Never repoint the symlink at something unreadable: hyprlock would fall back
# to the flat `color` from hyprlock.conf, which looks like a failure. Leaving
# the previous image in place is the better degradation.
if [ -n "$choice" ] && [ -r "$choice" ]; then
	ln -sfn "$choice" "$wp/lockscreen"
elif [ -n "$choice" ]; then
	echo "lock.sh: not readable, keeping previous lockscreen: $choice" >&2
fi

exec hyprlock
