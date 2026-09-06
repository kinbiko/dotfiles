//@ pragma UseQApplication
//@ pragma Env QT_QPA_PLATFORMTHEME=gtk3
//@ pragma Env QS_NO_RELOAD_POPUP=1
//@ pragma Env QSG_RENDER_LOOP=threaded
//@ pragma Env QT_QUICK_FLICKABLE_WHEEL_DECELERATION=10000

// Lean Quickshell shell: bar, notification daemon, OSD and wallpaper picker,
// stripped from doannc2212/quickshell-config (upstream commit
// 4fa5e975f94d7c8c3675dba783215d5fa2a1a583).
//
// Shared verbatim between this repo (Arch; reached at ~/.config/quickshell via
// the setup.sh symlink) and github.com/kinbiko/nixos (home/quickshell.nix).
// Keep it host-agnostic: no monitor names, no absolute paths, no assumption
// about how many screens exist - every module lays itself out over
// Quickshell.screens, so one monitor works as well as three.
//
// Dropped from upstream: the app launcher, monitor manager and theme switcher.
// Each module falls back to its own DefaultTheme.qml - recolour those to
// retheme. The launcher, lock screen and session actions are standalone tools,
// wired up per host (hyprland.conf here, home/quickshell.nix on NixOS).

import Quickshell
import QtQuick
import "bar"
import "notifications"
import "wallpaper"
import "osd"

Scope {
  Bar {}
  NotificationPopup {}
  WallpaperManager {}
  OSD {}
}
