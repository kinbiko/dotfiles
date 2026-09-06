pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Hyprland

Singleton {
  id: root

  property list<string> wallpapers: []
  property string currentWallpaper: ""
  property string backend: "awww"

  // Guards the one-shot restore in the FileView below. Without it, the write
  // that setWallpaper() performs would be read straight back and re-applied.
  property bool restored: false

  // awww caches wallpapers per-output, so a newly connected monitor doesn't
  // inherit the wallpaper already showing elsewhere - it comes up blank until
  // something explicitly sets it. Re-apply the current wallpaper (to *all*
  // outputs, since `awww img` with no `-o` targets every output) whenever
  // Hyprland reports a new monitor, so every display always shows the same
  // wallpaper. The short delay gives awww-daemon time to register the new
  // wl_output before we send the image.
  Connections {
    target: Hyprland

    function onRawEvent(event) {
      if (event.name === "monitoraddedv2" && root.currentWallpaper !== "") {
        reapplyTimer.restart();
      }
    }
  }

  Timer {
    id: reapplyTimer
    interval: 500
    onTriggered: root.setWallpaper(root.currentWallpaper)
  }

  Process {
    id: scanner
    command: ["sh", "-c",
      "find -L ~/.config/wallpapers ~/Pictures/Wallpapers ~/Pictures -maxdepth 2 -type f \\( -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' -o -iname '*.webp' \\) 2>/dev/null | sort -u | head -200"
    ]
    running: false
    stdout: SplitParser {
      onRead: data => {
        const path = data.trim();
        if (path !== "") {
          root.wallpapers = [...root.wallpapers, path];
        }
      }
    }
  }

  // Load the saved wallpaper path, and re-apply it once on startup. Neither
  // awww-daemon nor the compositor remembers the last wallpaper across a
  // session, so without this the desktop comes up bare until the picker is
  // opened.
  FileView {
    id: configFile
    path: Quickshell.env("HOME") + "/.config/quickshell/wallpaper.conf"
    onTextChanged: {
      const saved = configFile.text().trim();
      if (saved === "") return;
      root.currentWallpaper = saved;
      if (!root.restored) {
        root.restored = true;
        restoreTimer.start();
      }
    }
  }

  // awww-daemon is started alongside the shell, so it may not be accepting
  // connections yet at the moment the config file is first read.
  Timer {
    id: restoreTimer
    interval: 1000
    onTriggered: root.setWallpaper(root.currentWallpaper)
  }

  Component.onCompleted: {
    scanner.running = true;
  }

  function rescan() {
    wallpapers = [];
    scanner.running = true;
  }

  function setWallpaper(path) {
    currentWallpaper = path;
    restored = true;

    setProcess.command = ["awww", "img", path,
      "--transition-type", "grow", "--transition-pos", "center",
      "--transition-duration", "1"];
    setProcess.running = true;

    // Save to config
    saveProcess.command = ["sh", "-c", 'printf "%s" "$1" > "$HOME/.config/quickshell/wallpaper.conf"', "sh", path];
    saveProcess.running = true;
  }

  Process {
    id: setProcess
    command: []
    running: false
  }

  Process {
    id: saveProcess
    command: []
    running: false
  }
}
