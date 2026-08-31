# Make copy/paste in the shell use the system clipboard.
clipcopy()  { cat "${1:-/dev/stdin}" | pbcopy; }
clippaste() { pbpaste; }
