import Quickshell
import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland
import Quickshell.Widgets
import Quickshell.Services.SystemTray
import Quickshell.Io
import Quickshell.Services.Mpris
import Quickshell.Services.Pipewire
Scope {
  id: root
  property var theme: DefaultTheme {}
  property string font: "FiraCode Nerd Font"
  property bool barVisible: true

  // Sizing tokens — tweak here to scale the whole bar.
  property int fontSize: 13
  property int iconSize: 16
  property int pillHeight: 30

  // Tray items whose id or title contains any of these (lowercased) substrings
  // are hidden - for apps that sit in the tray with nothing useful to offer.
  property var trayIgnore: ["wox"]

  // MPRIS active player
  property var activePlayer: {
    const players = Mpris.players.values;
    if (!players || players.length === 0) return null;
    for (const p of players) {
      if (p.playbackState === MprisPlaybackState.Playing) return p;
    }
    return players[0];
  }

  IpcHandler {
    target: "bar"
    function toggle(): void { root.barVisible = !root.barVisible; }
  }

  // Japanese financial numerals (daiji), e.g. 1->壱 2->弐 ... 10->拾.
  function daiji(n: int): string {
    const d = ["〇", "壱", "弐", "参", "肆", "伍", "陸", "漆", "捌", "玖"];
    if (n === 10) return "拾";
    if (n >= 0 && n <= 9) return d[n];
    // Fallback for 11-99: 拾 with unit digit, e.g. 12->拾弐, 20->弐拾.
    if (n > 10 && n < 100) {
      const tens = Math.floor(n / 10);
      const ones = n % 10;
      return (tens > 1 ? d[tens] : "") + "拾" + (ones > 0 ? d[ones] : "");
    }
    return String(n);
  }

  // Launch a command detached (used for click-through to TUIs in the terminal).
  function run(cmd: list<string>): void { Quickshell.execDetached(cmd); }

  // Reserve a monospace label width for `n` chars, so pills don't resize (and
  // bump their neighbours) as their values change. FiraCode advance ≈ 0.6em.
  function labelW(n: int): int { return Math.round(n * root.fontSize * 0.62); }

  // Reusable "icon + label" bar pill. Highlights on hover; runs `onActivate`
  // (if set) on left-click, showing a pointer cursor when actionable.
  component MetricPill: Rectangle {
    id: pill
    property string icon: ""
    property color iconColor: root.theme.accentPrimary
    property string label: ""
    // Reserve a fixed label width of this many chars (0 = fit to content).
    property int labelChars: 0
    property string a11y: ""
    property var onActivate: null

    height: root.pillHeight
    radius: root.pillHeight / 2
    width: pillRow.width + 16
    color: pillMouse.containsMouse ? root.theme.bgSelected : root.theme.bgSurface
    Behavior on color { ColorAnimation { duration: 120 } }

    Accessible.role: onActivate ? Accessible.Button : Accessible.StaticText
    Accessible.name: pill.a11y

    Row {
      id: pillRow
      anchors.centerIn: parent
      spacing: 6

      Text {
        anchors.verticalCenter: parent.verticalCenter
        visible: pill.icon !== ""
        text: pill.icon
        color: pill.iconColor
        font.pixelSize: root.iconSize
        font.family: root.font
      }
      Text {
        anchors.verticalCenter: parent.verticalCenter
        visible: pill.label !== ""
        text: pill.label
        width: pill.labelChars > 0 ? root.labelW(pill.labelChars) : implicitWidth
        horizontalAlignment: Text.AlignRight
        color: root.theme.textPrimary
        font.pixelSize: root.fontSize
        font.family: root.font
      }
    }

    MouseArea {
      id: pillMouse
      anchors.fill: parent
      hoverEnabled: true
      cursorShape: pill.onActivate ? Qt.PointingHandCursor : Qt.ArrowCursor
      onClicked: if (pill.onActivate) pill.onActivate()
    }
  }

  PwObjectTracker {
    objects: [Pipewire.defaultAudioSink]
  }

  // Brightness state
  property real brightnessValue: 0
  property real brightnessMax: 1

  FileView {
    id: brightnessFile
    path: ""
    watchChanges: true
    onFileChanged: brightnessReadProc.running = true
  }

  Process {
    id: brightnessReadProc
    command: ["brightnessctl", "get"]
    running: false
    stdout: StdioCollector {
      onStreamFinished: {
        const val = parseInt(text.trim());
        if (!isNaN(val) && root.brightnessMax > 0)
          root.brightnessValue = val / root.brightnessMax;
      }
    }
  }

  Process {
    id: brightnessSetProc
    running: false
  }

  Process {
    id: backlightDiscovery
    command: ["sh", "-c", "p=$(ls -d /sys/class/backlight/*/brightness 2>/dev/null | head -1); [ -n \"$p\" ] && echo \"$p\" && cat \"${p%brightness}max_brightness\""]
    running: true
    stdout: StdioCollector {
      onStreamFinished: {
        const lines = text.trim().split("\n");
        if (lines.length >= 2) {
          const max = parseInt(lines[1]);
          if (!isNaN(max) && max > 0) root.brightnessMax = max;
          brightnessFile.path = lines[0];
          brightnessReadProc.running = true;
        }
      }
    }
  }

  Variants {
    model: Quickshell.screens

    PanelWindow {
      id: win
      required property var modelData
      screen: modelData
      visible: root.barVisible

      anchors {
        top: true
        left: true
        right: true
      }

      implicitHeight: root.pillHeight + 10
      color: "transparent"
      // Don't reserve screen space — the bar floats over windows and auto-hides.
      exclusiveZone: 0

      readonly property int triggerHeight: 4
      // Revealed while the cursor is on the top-edge trigger or on the bar.
      property bool revealed: topHover.hovered || barHover.hovered

      // Only take pointer input where something is actually shown: a thin strip
      // at the top edge while hidden, the whole bar while revealed. Everywhere
      // else clicks fall through to the windows underneath.
      mask: Region {
        width: win.width
        height: win.revealed ? win.height : win.triggerHeight
      }

      // Always-present hover zone pinned to the very top edge of the screen.
      Item {
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        height: win.triggerHeight
        HoverHandler { id: topHover }
      }

      // The bar proper — slides up out of view until revealed.
      Rectangle {
        id: barArea
        anchors.left: parent.left
        anchors.right: parent.right
        height: root.pillHeight + 8
        color: "transparent"
        y: win.revealed ? 2 : -height
        Behavior on y { NumberAnimation { duration: 200; easing.type: Easing.OutCubic } }

        HoverHandler { id: barHover }

        Item {
          anchors.fill: parent
          anchors.leftMargin: 10
          anchors.rightMargin: 10

        // Left section: Time + Workspaces + Now Playing
        Row {
          id: leftSection
          anchors.left: parent.left
          anchors.verticalCenter: parent.verticalCenter
          spacing: 8

          // Time — click opens a 3-month calendar in the terminal.
          Rectangle {
            height: root.pillHeight
            width: timeDate.width + 16
            radius: root.pillHeight / 2
            color: timeMouse.containsMouse ? root.theme.bgSelected : root.theme.bgSurface
            Behavior on color { ColorAnimation { duration: 120 } }

            Accessible.role: Accessible.Button
            Accessible.name: "Date and time: " + Time.weekdayJa + " " + Time.stampString

            Row {
              id: timeDate
              anchors.centerIn: parent
              spacing: 6

              Text {
                anchors.verticalCenter: parent.verticalCenter
                text: ""
                color: root.theme.accentPrimary
                font.pixelSize: root.iconSize
                font.family: root.font
              }

              Text {
                anchors.verticalCenter: parent.verticalCenter
                text: Time.weekdayJa
                color: root.theme.accentCyan
                font.pixelSize: root.fontSize
                font.family: root.font
              }

              Text {
                anchors.verticalCenter: parent.verticalCenter
                text: Time.stampString
                color: root.theme.textPrimary
                font.pixelSize: root.fontSize
                font.family: root.font
              }
            }

            MouseArea {
              id: timeMouse
              anchors.fill: parent
              hoverEnabled: true
              cursorShape: Qt.PointingHandCursor
              onClicked: root.run(["xdg-open", "https://calendar.proton.me/"])
            }
          }

          // Workspaces
          Row {
            spacing: 4

            Repeater {
              model: Hyprland.workspaces

              Rectangle {
                id: wsPill
                required property var modelData
                property bool urgentBlink: false

                Accessible.role: Accessible.Button
                Accessible.name: "Workspace " + modelData.id + (modelData.focused ? ", active" : "") + (modelData.urgent ? ", urgent" : "")

                width: modelData.focused ? root.pillHeight + 10 : root.pillHeight
                height: root.pillHeight
                radius: root.pillHeight / 2
                color: modelData.focused ? root.theme.accentPrimary :
                       modelData.urgent && urgentBlink ? root.theme.accentRed :
                       wsMouse.containsMouse ? root.theme.bgSelected : root.theme.bgSurface

                Behavior on color {
                  ColorAnimation { duration: 150 }
                }

                SequentialAnimation {
                  loops: Animation.Infinite
                  running: wsPill.modelData.urgent && !wsPill.modelData.focused

                  PropertyAction { target: wsPill; property: "urgentBlink"; value: true }
                  PauseAnimation { duration: 500 }
                  PropertyAction { target: wsPill; property: "urgentBlink"; value: false }
                  PauseAnimation { duration: 500 }

                  onStopped: wsPill.urgentBlink = false
                }

                Text {
                  anchors.centerIn: parent
                  text: root.daiji(wsPill.modelData.id)
                  color: wsPill.modelData.focused ? root.theme.bgBase : root.theme.textPrimary
                  font.pixelSize: root.fontSize
                  font.family: root.font
                  font.bold: wsPill.modelData.focused
                }

                MouseArea {
                  id: wsMouse
                  anchors.fill: parent
                  hoverEnabled: true
                  cursorShape: Qt.PointingHandCursor
                  onClicked: wsPill.modelData.activate()
                }

                Behavior on width {
                  NumberAnimation { duration: 150 }
                }
              }
            }
          }

          // Now Playing — click toggles play/pause, scroll switches track.
          Rectangle {
            height: root.pillHeight
            width: nowPlayingContent.width + 16
            radius: root.pillHeight / 2
            color: npMouse.containsMouse ? root.theme.bgSelected : root.theme.bgSurface
            visible: root.activePlayer !== null
            Behavior on color { ColorAnimation { duration: 120 } }

            Accessible.role: Accessible.Button
            Accessible.name: {
              if (!root.activePlayer) return "No media";
              const artist = root.activePlayer.trackArtist || "";
              const title = root.activePlayer.trackTitle || "";
              return "Now playing: " + (artist ? artist + " - " : "") + title;
            }

            Row {
              id: nowPlayingContent
              anchors.verticalCenter: parent.verticalCenter
              anchors.left: parent.left
              anchors.leftMargin: 8
              spacing: 6

              Text {
                anchors.verticalCenter: parent.verticalCenter
                text: root.activePlayer && root.activePlayer.isPlaying ? "󰐊" : "󰏤"
                color: root.theme.accentPrimary
                font.pixelSize: root.iconSize
                font.family: root.font
              }

              Text {
                anchors.verticalCenter: parent.verticalCenter
                text: {
                  if (!root.activePlayer) return "";
                  const artist = root.activePlayer.trackArtist || "";
                  const title = root.activePlayer.trackTitle || "";
                  return artist ? artist + " - " + title : title;
                }
                color: root.theme.textPrimary
                font.pixelSize: root.fontSize
                font.family: root.font
                elide: Text.ElideRight
                width: Math.min(implicitWidth, 200)
              }
            }

            MouseArea {
              id: npMouse
              anchors.fill: parent
              hoverEnabled: true
              cursorShape: Qt.PointingHandCursor
              onClicked: root.activePlayer.togglePlaying()
              onWheel: (wheel) => {
                if (!root.activePlayer) return;
                if (wheel.angleDelta.y > 0) root.activePlayer.next();
                else root.activePlayer.previous();
              }
            }
          }
        }

        // Right section: System Info + System Tray
        Row {
          id: rightSection
          anchors.right: parent.right
          anchors.verticalCenter: parent.verticalCenter
          spacing: 8

          // Volume — click mutes, scroll adjusts.
          Rectangle {
            height: root.pillHeight
            width: volContent.width + 12
            radius: root.pillHeight / 2
            color: volMouse.containsMouse ? root.theme.bgSelected : root.theme.bgSurface
            Behavior on color { ColorAnimation { duration: 120 } }

            Accessible.role: Accessible.Button
            Accessible.name: {
              const sink = Pipewire.defaultAudioSink;
              if (!sink || !sink.audio) return "Volume";
              if (sink.audio.muted) return "Volume: muted";
              return "Volume: " + Math.round(sink.audio.volume * 100) + "%";
            }

            Row {
              id: volContent
              anchors.centerIn: parent
              spacing: 6

              Text {
                anchors.verticalCenter: parent.verticalCenter
                text: {
                  const sink = Pipewire.defaultAudioSink;
                  if (!sink || !sink.audio || sink.audio.muted || sink.audio.volume <= 0) return "󰖁";
                  if (sink.audio.volume < 0.33) return "󰕿";
                  if (sink.audio.volume < 0.66) return "󰖀";
                  return "󰕾";
                }
                color: {
                  const sink = Pipewire.defaultAudioSink;
                  if (!sink || !sink.audio || sink.audio.muted) return root.theme.textMuted;
                  return root.theme.accentPrimary;
                }
                font.pixelSize: root.iconSize
                font.family: root.font
              }

              Text {
                anchors.verticalCenter: parent.verticalCenter
                text: {
                  const sink = Pipewire.defaultAudioSink;
                  if (!sink || !sink.audio) return "–";
                  if (sink.audio.muted) return "Mute";
                  return Math.round(sink.audio.volume * 100) + "%";
                }
                width: root.labelW(4)
                horizontalAlignment: Text.AlignRight
                color: root.theme.textPrimary
                font.pixelSize: root.fontSize
                font.family: root.font
              }
            }

            MouseArea {
              id: volMouse
              anchors.fill: parent
              hoverEnabled: true
              cursorShape: Qt.PointingHandCursor
              acceptedButtons: Qt.LeftButton
              onClicked: {
                const sink = Pipewire.defaultAudioSink;
                if (sink && sink.audio) sink.audio.muted = !sink.audio.muted;
              }
              onWheel: (wheel) => {
                const sink = Pipewire.defaultAudioSink;
                if (!sink || !sink.audio) return;
                const delta = wheel.angleDelta.y > 0 ? 0.05 : -0.05;
                sink.audio.volume = Math.max(0, Math.min(1.5, sink.audio.volume + delta));
              }
            }
          }

          // Brightness — scroll adjusts.
          Rectangle {
            height: root.pillHeight
            width: brightContent.width + 12
            radius: root.pillHeight / 2
            color: brightMouse.containsMouse ? root.theme.bgSelected : root.theme.bgSurface
            visible: brightnessFile.path !== ""
            Behavior on color { ColorAnimation { duration: 120 } }

            Accessible.role: Accessible.StaticText
            Accessible.name: "Brightness: " + Math.round(root.brightnessValue * 100) + "%"

            Row {
              id: brightContent
              anchors.centerIn: parent
              spacing: 6

              Text {
                anchors.verticalCenter: parent.verticalCenter
                text: "󰃠"
                color: root.theme.accentOrange
                font.pixelSize: root.iconSize
                font.family: root.font
              }

              Text {
                anchors.verticalCenter: parent.verticalCenter
                text: Math.round(root.brightnessValue * 100) + "%"
                width: root.labelW(4)
                horizontalAlignment: Text.AlignRight
                color: root.theme.textPrimary
                font.pixelSize: root.fontSize
                font.family: root.font
              }
            }

            MouseArea {
              id: brightMouse
              anchors.fill: parent
              hoverEnabled: true
              cursorShape: Qt.PointingHandCursor
              onWheel: (wheel) => {
                brightnessSetProc.command = wheel.angleDelta.y > 0
                  ? ["brightnessctl", "set", "5%+"]
                  : ["brightnessctl", "set", "5%-"];
                brightnessSetProc.running = true;
              }
            }
          }

          // System Info — metric pills open a system monitor / net TUI on click.
          Row {
            id: sysInfo

            readonly property color batteryColor: {
              if (SystemInfo.batteryCharging) return root.theme.accentGreen;
              if (SystemInfo.batteryLevelRaw > 20) return root.theme.batteryGood;
              if (SystemInfo.batteryLevelRaw > 10) return root.theme.batteryWarning;
              return root.theme.batteryCritical;
            }

            spacing: 4

            // CPU
            MetricPill {
              icon: "󰻠"
              iconColor: root.theme.accentOrange
              label: SystemInfo.cpuUsage
              labelChars: 4
              a11y: "CPU: " + SystemInfo.cpuUsage
              onActivate: () => root.run(["ghostty", "-e", "btop"])
            }

            // Memory
            MetricPill {
              icon: "󰍛"
              iconColor: root.theme.accentCyan
              label: SystemInfo.memoryUsage
              labelChars: 4
              a11y: "Memory: " + SystemInfo.memoryUsage
              onActivate: () => root.run(["ghostty", "-e", "btop"])
            }

            // Disks - one pill per mounted filesystem. External (hot-pluggable)
            // drives get a distinct icon colour.
            Repeater {
              model: SystemInfo.disks

              MetricPill {
                required property var modelData

                icon: "󰋊"
                iconColor: modelData.removable ? root.theme.accentYellow : root.theme.accentPrimary
                label: modelData.usage
                labelChars: 4
                a11y: (modelData.removable ? "External disk " : "Disk ") + modelData.mount + ": " + modelData.usage
                onActivate: () => root.run(["ghostty", "-e", "sh", "-c", "df -h; echo; read -n1 -s -r -p 'Press any key to close…'"])
              }
            }

            // Network throughput (down / up)
            Rectangle {
              height: root.pillHeight
              width: netIoContent.width + 12
              radius: root.pillHeight / 2
              color: netIoMouse.containsMouse ? root.theme.bgSelected : root.theme.bgSurface
              Behavior on color { ColorAnimation { duration: 120 } }

              Accessible.role: Accessible.Button
              Accessible.name: "Network I/O: down " + SystemInfo.netDown + ", up " + SystemInfo.netUp

              // Down over up, stacked, to keep the pill narrow. Uses a smaller
              // font so two lines fit the pill height; label width reserved so
              // the pill stays a constant size as throughput changes.
              Column {
                id: netIoContent
                anchors.centerIn: parent
                spacing: 0
                readonly property int lineFont: root.fontSize - 2
                readonly property int lineIcon: root.iconSize - 4
                readonly property int lineW: Math.round(9 * lineFont * 0.62)

                Row {
                  spacing: 4
                  Text {
                    anchors.verticalCenter: parent.verticalCenter
                    text: "󰇚"
                    color: root.theme.accentGreen
                    font.pixelSize: netIoContent.lineIcon
                    font.family: root.font
                  }
                  Text {
                    anchors.verticalCenter: parent.verticalCenter
                    text: SystemInfo.netDown
                    width: netIoContent.lineW
                    horizontalAlignment: Text.AlignRight
                    color: root.theme.textPrimary
                    font.pixelSize: netIoContent.lineFont
                    font.family: root.font
                  }
                }
                Row {
                  spacing: 4
                  Text {
                    anchors.verticalCenter: parent.verticalCenter
                    text: "󰕒"
                    color: root.theme.accentOrange
                    font.pixelSize: netIoContent.lineIcon
                    font.family: root.font
                  }
                  Text {
                    anchors.verticalCenter: parent.verticalCenter
                    text: SystemInfo.netUp
                    width: netIoContent.lineW
                    horizontalAlignment: Text.AlignRight
                    color: root.theme.textPrimary
                    font.pixelSize: netIoContent.lineFont
                    font.family: root.font
                  }
                }
              }

              MouseArea {
                id: netIoMouse
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onClicked: root.run(["ghostty", "-e", "btop"])
              }
            }

            // Network (link type + SSID) — click opens nmtui.
            Rectangle {
              height: root.pillHeight
              width: netContent.width + 12
              radius: root.pillHeight / 2
              color: netMouse.containsMouse ? root.theme.bgSelected : root.theme.bgSurface
              Behavior on color { ColorAnimation { duration: 120 } }

              Accessible.role: Accessible.Button
              Accessible.name: {
                if (SystemInfo.networkType === "ethernet") return "Network: Ethernet"
                if (SystemInfo.networkType === "wifi") return "Network: WiFi " + SystemInfo.networkInfo
                return "Network: Disconnected"
              }

              Row {
                id: netContent
                anchors.centerIn: parent
                spacing: 6

                Text {
                  anchors.verticalCenter: parent.verticalCenter
                  text: {
                    if (SystemInfo.networkType === "ethernet") return "󰈀"
                    if (SystemInfo.networkType === "wifi") return "󰖩"
                    return "󰖪"
                  }
                  color: SystemInfo.networkType === "disconnected" ? root.theme.textMuted : root.theme.accentGreen
                  font.pixelSize: root.iconSize
                  font.family: root.font
                }
                Text {
                  anchors.verticalCenter: parent.verticalCenter
                  text: SystemInfo.networkInfo
                  color: root.theme.textPrimary
                  font.pixelSize: root.fontSize
                  font.family: root.font
                }
              }

              MouseArea {
                id: netMouse
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onClicked: root.run(["ghostty", "-e", "sh", "-c", "command -v nmtui >/dev/null && exec nmtui || exec iwctl"])
              }
            }

            // Battery - absent on desktops, where there is no BAT* supply.
            MetricPill {
              visible: SystemInfo.batteryPresent
              icon: SystemInfo.batteryIcon
              iconColor: sysInfo.batteryColor
              label: SystemInfo.batteryLevel
              a11y: "Battery: " + SystemInfo.batteryLevel
              onActivate: () => root.run(["ghostty", "-e", "btop"])
            }

            // Temperature
            MetricPill {
              icon: "󰔏"
              iconColor: root.theme.accentRed
              label: SystemInfo.temperature
              a11y: "Temperature: " + SystemInfo.temperature
              onActivate: () => root.run(["ghostty", "-e", "btop"])
            }
          }

          // System Tray
          // There's an issue that some tray not display correctly.
          // https://github.com/quickshell-mirror/quickshell/issues/26
          // https://github.com/quickshell-mirror/quickshell/pull/777
          Rectangle {
            implicitHeight: root.pillHeight
            implicitWidth: trayIcons.implicitWidth + 4
            radius: root.pillHeight / 2
            color: root.theme.bgSurface

            RowLayout {
              id: trayIcons
              anchors.centerIn: parent
              spacing: 2

              Repeater {
                model: SystemTray.items.values.filter(item => !root.trayIgnore.some(
                  ignored => (item.id || "").toLowerCase().includes(ignored)
                    || (item.title || "").toLowerCase().includes(ignored)))

                MouseArea {
                  id: trayDelegate
                  required property SystemTrayItem modelData

                  Accessible.role: Accessible.Button
                  Accessible.name: modelData.tooltipTitle || modelData.title || "System tray item"

                  Layout.preferredWidth: root.pillHeight
                  Layout.preferredHeight: root.pillHeight
                  hoverEnabled: true
                  cursorShape: Qt.PointingHandCursor

                  acceptedButtons: Qt.LeftButton | Qt.RightButton | Qt.MiddleButton

                  onClicked: (mouse) => {
                    if (mouse.button === Qt.LeftButton) {
                      modelData.activate()
                    } else if (mouse.button === Qt.RightButton) {
                      if (modelData.hasMenu) {
                        menuAnchor.open()
                      }
                    } else if (mouse.button === Qt.MiddleButton) {
                      modelData.secondaryActivate()
                    }
                  }

                  IconImage {
                    anchors.centerIn: parent
                    source: trayDelegate.modelData.icon
                    implicitSize: root.iconSize
                  }

                  QsMenuAnchor {
                    id: menuAnchor
                    menu: trayDelegate.modelData.menu

                    anchor.window: trayDelegate.QsWindow.window
                    anchor.adjustment: PopupAdjustment.Flip
                    anchor.onAnchoring: {
                      const window = trayDelegate.QsWindow.window;
                      const widgetRect = window.contentItem.mapFromItem(
                        trayDelegate, 0, trayDelegate.height,
                        trayDelegate.width, trayDelegate.height);
                      menuAnchor.anchor.rect = widgetRect;
                    }
                  }
                }
              }
            }
          }
        }
        }
      }

    }
  }
}
