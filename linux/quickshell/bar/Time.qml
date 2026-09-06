pragma Singleton

import Quickshell
import QtQuick

Singleton {
  id: root

  // Japanese single-char weekday abbreviation (日=Sun … 土=Sat).
  readonly property string weekdayJa: {
    const w = ["日", "月", "火", "水", "木", "金", "土"]
    return w[clock.date.getDay()]
  }

  // ISO-ish stamp, minute precision: yyyy-MM-ddThh:mm
  readonly property string stampString: {
    Qt.formatDateTime(clock.date, "yyyy-MM-ddThh:mm")
  }

  SystemClock {
    id: clock
    precision: SystemClock.Seconds
  }
}
