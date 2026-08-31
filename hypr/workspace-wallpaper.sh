#!/usr/bin/env python3
"""Cycle wallpapers per workspace via swww."""

import json, os, socket, subprocess, time

WALLPAPERS = [
    "arch-01.png",
    "balamb-garden.png",
    "dream-office.png",
    "solarpunk-01.jpg",
    "solarpunk-02.jpg",
    "solarpunk-03.png",
    "solarpunk-04.png",
    "solarpunk-05.png",
    "solarpunk-06.png",
    "solarpunk-07.png",
    "solarpunk-08.jpeg",
    "solarpunk-09.png",
]
WALLPAPER_DIR = os.path.expanduser("~/.config/wallpapers")
WALLPAPERS = [os.path.join(WALLPAPER_DIR, w) for w in WALLPAPERS]


def set_wallpaper(ws: int):
    idx = (ws - 1) % len(WALLPAPERS)
    subprocess.run(["swww", "img", WALLPAPERS[idx], "--transition-type", "none"])


# Wait for swww-daemon to be ready
time.sleep(2)

# Set for current workspace on startup
raw = subprocess.check_output(["hyprctl", "activeworkspace", "-j"])
set_wallpaper(json.loads(raw)["id"])

# Listen for workspace changes
sock_path = (
    os.environ["XDG_RUNTIME_DIR"]
    + "/hypr/"
    + os.environ["HYPRLAND_INSTANCE_SIGNATURE"]
    + "/.socket2.sock"
)
s = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
s.connect(sock_path)

buf = b""
while True:
    data = s.recv(4096)
    if not data:
        break
    buf += data
    while b"\n" in buf:
        line, buf = buf.split(b"\n", 1)
        decoded = line.decode()
        if decoded.startswith("workspace>>"):
            try:
                ws = int(decoded.split(">>")[1])
                set_wallpaper(ws)
            except (ValueError, IndexError):
                pass
