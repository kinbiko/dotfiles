-- Hyprland config. Lua replaced hyprlang in 0.55; the old hyprland.conf format
-- still loads but is scheduled for removal.
-- See https://wiki.hypr.land/Configuring/Start/

------------------
---- MONITORS ----
------------------

hl.monitor({ output = "HDMI-A-1", mode = "3840x2160@60", position = "0x0",    scale = 1 })
hl.monitor({ output = "DP-1",     mode = "3440x1440@60", position = "3840x0", scale = 1 })

-- Dual monitor example on G15 Strix
-- eDP-1 is the built in monitor while DP-1 is external
-- Both monitors here are at 1440 and 165Hz
-- DP-1 is on the left and eDP-1 is on the right
-- hl.monitor({ output = "DP-1",  mode = "2560x1440@165", position = "0x0",    scale = 1 })
-- hl.monitor({ output = "eDP-1", mode = "2560x1440@165", position = "2560x0", scale = 1.25 })


-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

-- Dark theme for Qt apps (Transmission etc.) — needs adwaita-qt5/adwaita-qt6
hl.env("QT_STYLE_OVERRIDE", "Adwaita-Dark")


-------------------
---- AUTOSTART ----
-------------------

hl.on("hyprland.start", function()
    hl.exec_cmd("~/.config/hypr/xdg-portal-hyprland")
    hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
    hl.exec_cmd("systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
    hl.exec_cmd("/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1")

    -- Desktop shell: bar, notifications, OSD and wallpaper picker, all from the
    -- hand-owned QML config in linux/quickshell.
    hl.exec_cmd("systemctl --user start quickshell.service")
    hl.exec_cmd("blueman-applet")
    hl.exec_cmd("nm-applet --indicator")

    -- quickshell.service pulls in awww.service, so the daemon is already up. The
    -- wallpaper itself is whatever the picker last set (persisted to
    -- ~/.config/quickshell/wallpaper.conf and re-applied by WallpaperService at
    -- startup); seed a default only when that file has never been written.
    hl.exec_cmd("sh -c 'sleep 2; [ -s ~/.config/quickshell/wallpaper.conf ] || awww img ~/.config/wallpapers/arch-01.png --transition-type none'")

    hl.exec_cmd("fcitx5")

    -- Launcher. Runs as a daemon so the SPACE bind below only has to raise it;
    -- a cold start would otherwise cost a second on every invocation.
    hl.exec_cmd("wox")

    -- The Acer is shared with another computer via its own input switch. Hyprland
    -- can't tell the difference, so this watches DDC/CI and disables/enables it.
    hl.exec_cmd("~/.config/hypr/acer-input-watch.sh >> /tmp/acer-input-watch.log 2>&1")
end)

-- kanshi removed: it raced with Hyprland's native monitor rules on hotplug,
-- leaving both outputs stacked at 0x0 (cursor on both screens + slowness) when
-- the LG's input was switched away and back. Hyprland reapplies the hl.monitor
-- rules above on reconnect natively, so kanshi is redundant here.

-- Runs on every config load, not just startup, so a reload re-asserts the theme.
hl.exec_cmd("gsettings set org.gnome.desktop.interface gtk-theme 'Orchis-Dark-Compact'")
hl.exec_cmd("gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'")


-----------------------
---- LOOK AND FEEL ----
-----------------------

hl.config({
    general = {
        gaps_in     = 46,
        gaps_out    = 41,
        border_size = 1,

        col = {
            active_border   = "rgb(cdd6f4)",
            inactive_border = "rgba(595959aa)",
        },

        layout = "dwindle",
    },

    decoration = {
        rounding = 4,

        blur = {
            enabled           = true,
            size              = 7,
            passes            = 4,
            new_optimizations = true,
        },
    },

    misc = {
        disable_hyprland_logo = true,
    },

    animations = {
        enabled = true,
    },

    dwindle = {
        preserve_split = true,
    },

    gestures = {
        workspace_swipe_min_speed_to_force = 10,
        workspace_swipe_invert             = false,
    },
})

hl.curve("myBezier", { type = "bezier", points = { {0.10, 0.9}, {0.1, 1.05} } })

hl.animation({ leaf = "windows",    enabled = true,  speed = 4,   bezier = "myBezier", style = "slide" })
hl.animation({ leaf = "windowsOut", enabled = true,  speed = 4,   bezier = "myBezier", style = "slide" })
hl.animation({ leaf = "border",     enabled = true,  speed = 5,   bezier = "default" })
hl.animation({ leaf = "fade",       enabled = true,  speed = 4,   bezier = "default" })
hl.animation({ leaf = "workspaces", enabled = false, speed = 0.5, bezier = "default" })


---------------
---- INPUT ----
---------------

hl.config({
    input = {
        kb_layout  = "us",
        kb_variant = "",
        kb_model   = "",
        kb_options = "ctrl:nocaps",
        kb_rules   = "",

        follow_mouse = 0,

        sensitivity = 0.0, -- -1.0 - 1.0, 0 means no modification.

        touchpad = {
            natural_scroll      = false,
            scroll_factor       = 0.3,
            tap_to_click        = false,
            clickfinger_behavior = true, -- 1, 2, or 3 fingers map to LMB, RMB, MMB.
        },
    },
})

hl.gesture({ fingers = 4, direction = "horizontal", action = "workspace" })


---------------------
---- WINDOW RULES ----
---------------------

hl.window_rule({ match = { class = "^(alacritty)$" }, opacity = "0.8 0.8", animation = "popin" })
hl.window_rule({ match = { title = "^(pavucontrol)$" },           float = true })
hl.window_rule({ match = { title = "^(blueman-manager)$" },       float = true })
hl.window_rule({ match = { title = "^(nm-connection-editor)$" },  float = true })
hl.window_rule({ match = { title = "^(update-sys)$" },            float = true })

hl.window_rule({
    name  = "yomihan",
    match = { class = "^(yomihan)$" },
    float = true,
    pin   = true,
})


---------------------
---- KEYBINDINGS ----
---------------------

local mainMod = "SUPER"

hl.bind(mainMod .. " + Q",      hl.dsp.window.close())                  -- close the active window
hl.bind(mainMod .. " + V",      hl.dsp.window.float({ action = "toggle" })) -- allow a window to float
hl.bind(mainMod .. " + F",      hl.dsp.window.fullscreen())
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd("alacritty"))
hl.bind(mainMod .. " + W",      hl.dsp.exec_cmd("zen-browser"))
hl.bind(mainMod .. " + E",      hl.dsp.exec_cmd("nemo"))
hl.bind(mainMod .. " + S",      hl.dsp.exec_cmd('grim -t jpeg -q 100 -g "$(slurp)" - | swappy -f -')) -- take a screenshot
hl.bind(mainMod .. " + P",      hl.dsp.exec_cmd("hyprpicker"))
hl.bind(mainMod .. " + X",      hl.dsp.exec_cmd("~/.config/hypr/lock.sh"))
hl.bind(mainMod .. " + Z",      hl.dsp.exec_cmd("~/repos/yomihan/target/release/yomihan trigger"))

-- Launcher. Wox registers its own global hotkeys through `hyprctl eval`, which
-- only works while Hyprland is running, so it cannot claim them before the
-- session exists. Wox's own hotkeys are therefore left blank in its settings and
-- bound here instead. Passing a deeplink rather than running `wox` bare means the
-- new process hands off to the running instance over loopback and exits, so a
-- second press toggles rather than cold-starting a duplicate.
hl.bind(mainMod .. " + space",         hl.dsp.exec_cmd("wox wox://toggle")) -- show the graphical app launcher
hl.bind(mainMod .. " + SHIFT + space", hl.dsp.exec_cmd("wox wox://select")) -- query the current selection

-- Audio controls
hl.bind("F10", hl.dsp.exec_cmd("pactl set-sink-mute @DEFAULT_SINK@ toggle"))
hl.bind("F11", hl.dsp.exec_cmd("pactl set-sink-volume @DEFAULT_SINK@ -5%"))
hl.bind("F12", hl.dsp.exec_cmd("pactl set-sink-volume @DEFAULT_SINK@ +5%"))

-- Volume knob (media keys). `locked` keeps them working on the lockscreen;
-- `repeating` lets the knob spin without one bind per detent.
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("pactl set-sink-volume @DEFAULT_SINK@ +2%"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("pactl set-sink-volume @DEFAULT_SINK@ -2%"), { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("pactl set-sink-mute @DEFAULT_SINK@ toggle"),     { locked = true })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("pactl set-source-mute @DEFAULT_SOURCE@ toggle"), { locked = true })

-- Move focus with mainMod + hjkl
hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "l" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "r" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "u" }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "d" }))

-- Switch workspaces with mainMod + [0-9], move the active window there with SHIFT
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key,         hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })
