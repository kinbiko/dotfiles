# Make copy/paste in the shell use the system clipboard (Wayland).
# --no-newline is required: wl-paste appends one by default, which would
# corrupt CUTBUFFER on every vi-put.
clipcopy()  { cat "${1:-/dev/stdin}" | wl-copy; }
clippaste() { wl-paste --no-newline; }
