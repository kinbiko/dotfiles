pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
  id: root

  property string cpuUsage: "0%"
  property string memoryUsage: "0%"
  property string diskUsage: "0%"
  property string networkInfo: "Disconnected"
  property string networkType: "disconnected"
  property string netDown: "0 B/s"
  property string netUp: "0 B/s"
  property int batteryLevelRaw: 0
  property string batteryLevel: "0%"
  property string batteryIcon: "󰂎"
  property bool batteryCharging: false
  property string temperature: "0°C"

  // Low-battery notification thresholds (%). Fires once per threshold per
  // discharge cycle; resets when charging starts.
  readonly property var _batteryWarnThresholds: [10, 5, 3, 2, 1]
  property var _batteryWarned: ({})

  // Previous cumulative byte counters + timestamp, for computing throughput.
  property double _prevRx: -1
  property double _prevTx: -1
  property double _prevTime: 0

  // Previous /proc/stat cumulative counters, for computing CPU usage as an
  // interval delta rather than an average-since-boot.
  property double _prevCpuIdle: -1
  property double _prevCpuTotal: -1

  // Human-readable bytes/second (binary units).
  function _fmtRate(bytesPerSec) {
    const u = ["B/s", "K/s", "M/s", "G/s"]
    let v = bytesPerSec, i = 0
    while (v >= 1024 && i < u.length - 1) { v /= 1024; i++ }
    return (i === 0 ? Math.round(v) : v.toFixed(1)) + " " + u[i]
  }

  // CPU Usage. Reads the aggregate line from /proc/stat directly instead of
  // spawning `top` (which needs its own ~3s internal sample delay to compute
  // a rate, longer than this widget's 2s poll interval - that caused
  // overlapping top/sh/grep/sed/awk pipelines to pile up indefinitely).
  Process {
    id: cpuProc
    command: ["sh", "-c", "head -1 /proc/stat"]
    running: true

    stdout: StdioCollector {
      onStreamFinished: {
        const fields = text.trim().split(/\s+/).slice(1).map(Number)
        const idle = fields[3] + fields[4] // idle + iowait
        const total = fields.reduce((a, b) => a + b, 0)

        if (root._prevCpuTotal >= 0 && total > root._prevCpuTotal) {
          const dIdle = idle - root._prevCpuIdle
          const dTotal = total - root._prevCpuTotal
          root.cpuUsage = Math.round(100 * (1 - dIdle / dTotal)) + "%"
        }

        root._prevCpuIdle = idle
        root._prevCpuTotal = total
      }
    }
  }

  // Memory Usage
  Process {
    id: memProc
    command: ["sh", "-c", "free | grep Mem | awk '{printf \"%.0f%%\", ($3/$2) * 100.0}'"]
    running: true

    stdout: StdioCollector {
      onStreamFinished: {
        root.memoryUsage = text.trim()
      }
    }
  }

  // Disk Usage (root filesystem, % used)
  Process {
    id: diskProc
    command: ["sh", "-c", "df -P / | awk 'NR==2{print $5}'"]
    running: true

    stdout: StdioCollector {
      onStreamFinished: {
        root.diskUsage = text.trim() || "0%"
      }
    }
  }

  // Network I/O throughput (default-route interface, so VPN isn't double-counted)
  Process {
    id: netIoProc
    command: ["sh", "-c", "i=$(ip route show default 2>/dev/null | awk '{print $5; exit}'); [ -z \"$i\" ] && i=lo; echo \"$(cat /sys/class/net/$i/statistics/rx_bytes 2>/dev/null || echo 0) $(cat /sys/class/net/$i/statistics/tx_bytes 2>/dev/null || echo 0)\""]
    running: true

    stdout: StdioCollector {
      onStreamFinished: {
        const parts = text.trim().split(" ")
        const rx = parseFloat(parts[0]) || 0
        const tx = parseFloat(parts[1]) || 0
        const now = Date.now() / 1000

        if (root._prevRx >= 0 && now > root._prevTime) {
          const dt = now - root._prevTime
          // Guard against counter resets (iface change) producing negatives.
          const dRx = Math.max(0, rx - root._prevRx)
          const dTx = Math.max(0, tx - root._prevTx)
          root.netDown = root._fmtRate(dRx / dt)
          root.netUp = root._fmtRate(dTx / dt)
        }

        root._prevRx = rx
        root._prevTx = tx
        root._prevTime = now
      }
    }
  }

  // Network Info (ethernet takes priority over wifi)
  Process {
    id: netProc
    command: ["sh", "-c", "eth=$(nmcli -t -f type,state dev 2>/dev/null | grep '^ethernet:connected'); if [ -n \"$eth\" ]; then echo 'ethernet:Ethernet'; else wifi=$(nmcli -t -f active,ssid dev wifi 2>/dev/null | grep '^yes' | cut -d: -f2); if [ -n \"$wifi\" ]; then echo \"wifi:$wifi\"; else echo 'disconnected:'; fi; fi"]
    running: true

    stdout: StdioCollector {
      onStreamFinished: {
        const result = text.trim()
        const colonIdx = result.indexOf(':')
        const type = result.substring(0, colonIdx)
        const info = result.substring(colonIdx + 1)
        root.networkType = type
        root.networkInfo = info || "Disconnected"
      }
    }
  }

  // Battery
  Process {
    id: batteryProc
    command: ["sh", "-c", "printf '%s\\n%s' \"$(cat /sys/class/power_supply/BAT*/capacity 2>/dev/null || echo '99')\" \"$(cat /sys/class/power_supply/BAT*/status 2>/dev/null || echo 'Discharging')\""]
    running: true

    stdout: StdioCollector {
      onStreamFinished: {
        const lines = text.trim().split("\n")
        const level = parseInt(lines[0]) || 0
        const status = (lines[1] || "Discharging").trim()

        root.batteryLevelRaw = level
        root.batteryLevel = level + "%"
        root.batteryCharging = status === "Charging"

        if (root.batteryCharging) {
          root._batteryWarned = {}
        } else {
          for (const t of root._batteryWarnThresholds) {
            if (level <= t && !root._batteryWarned[t]) {
              root._batteryWarned[t] = true
              const urgency = t <= 3 ? "critical" : "normal"
              Quickshell.execDetached(["notify-send", "-u", urgency, "-i", "battery-caution",
                "Low battery", level + "% remaining"])
            }
          }
        }

        if (root.batteryCharging) root.batteryIcon = ""
        else if (level >= 90) root.batteryIcon = "󰁹"
        else if (level >= 80) root.batteryIcon = "󰂂"
        else if (level >= 70) root.batteryIcon = "󰂁"
        else if (level >= 60) root.batteryIcon = "󰂀"
        else if (level >= 50) root.batteryIcon = "󰁿"
        else if (level >= 40) root.batteryIcon = "󰁾"
        else if (level >= 30) root.batteryIcon = "󰁽"
        else if (level >= 20) root.batteryIcon = "󰁼"
        else if (level >= 10) root.batteryIcon = "󰁻"
        else root.batteryIcon = "󰁺"
      }
    }
  }

  // Temperature
  Process {
    id: tempProc
    command: ["sh", "-c", "for d in /sys/class/hwmon/hwmon*; do if [ \"$(cat \"$d/name\" 2>/dev/null)\" = coretemp ]; then t=$(cat \"$d/temp1_input\" 2>/dev/null); [ -n \"$t\" ] && echo \"$((t/1000))°C\" && exit 0; fi; done; for z in /sys/class/thermal/thermal_zone*; do if [ \"$(cat \"$z/type\" 2>/dev/null)\" = x86_pkg_temp ]; then t=$(cat \"$z/temp\" 2>/dev/null); [ -n \"$t\" ] && echo \"$((t/1000))°C\" && exit 0; fi; done; echo N/A"]
    running: true

    stdout: StdioCollector {
      onStreamFinished: {
        root.temperature = text.trim() || "N/A"
      }
    }
  }

  // Update timer
  Timer {
    interval: 2000
    running: true
    repeat: true
    onTriggered: {
      cpuProc.running = true
      memProc.running = true
      diskProc.running = true
      netProc.running = true
      netIoProc.running = true
      batteryProc.running = true
      tempProc.running = true
    }
  }
}
