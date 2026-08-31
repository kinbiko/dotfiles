import QtQuick 2.15
import QtQuick.Controls 2.15
import SddmComponents 2.0

Rectangle {
    id: root
    width: 1920
    height: 1080

    property string cream: "#fffaf0"
    property string green: "#b4dc8c"
    property string greenDark: "#649650"
    property string shadow: "#80000000"

    // Background
    Image {
        anchors.fill: parent
        source: "/usr/share/sddm/themes/solarpunk/solarpunk-03.png"
        fillMode: Image.PreserveAspectCrop

        Rectangle {
            anchors.fill: parent
            color: "#000000"
            opacity: 0.3
        }
    }

    // Time
    Text {
        id: timeLabel
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.verticalCenter
        anchors.topMargin: -250
        text: Qt.formatTime(new Date(), "hh:mm")
        font.pixelSize: 160
        font.family: "sans-serif"
        color: cream
        style: Text.Raised
        styleColor: shadow
    }

    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: timeLabel.text = Qt.formatTime(new Date(), "hh:mm")
    }

    // Date (Japanese)
    Text {
        id: dateLabel
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.verticalCenter
        anchors.topMargin: -60
        text: {
            var days = ["日曜日", "月曜日", "火曜日", "水曜日", "木曜日", "金曜日", "土曜日"];
            var now = new Date();
            var dayName = days[now.getDay()];
            var year = now.getFullYear();
            var month = String(now.getMonth() + 1).padStart(2, '0');
            var day = String(now.getDate()).padStart(2, '0');
            return dayName + ", " + year + "年" + month + "月" + day + "日";
        }
        font.pixelSize: 40
        font.family: "IPAPGothic"
        color: cream
        style: Text.Raised
        styleColor: shadow
    }

    // Motto line 1
    Text {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.verticalCenter
        anchors.topMargin: 10
        text: "The absence of a particular solution is never the problem."
        font.pixelSize: 24
        font.family: "sans-serif"
        color: green
        style: Text.Raised
        styleColor: shadow
    }

    // Motto line 2
    Text {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.verticalCenter
        anchors.topMargin: 50
        text: "The problem is the problem."
        font.pixelSize: 24
        font.family: "sans-serif"
        color: green
        style: Text.Raised
        styleColor: shadow
    }

    // Login container
    Column {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.verticalCenter
        anchors.topMargin: 120
        spacing: 15

        // Username field
        TextField {
            id: usernameField
            width: 350
            height: 60
            placeholderText: "ユーザー名"
            placeholderTextColor: "#99fffaf0"
            text: userModel.lastUser
            font.pixelSize: 18
            color: cream
            horizontalAlignment: TextInput.AlignHCenter
            background: Rectangle {
                radius: 16
                color: "#4d000000"
                border.color: greenDark
                border.width: 3
            }
            Keys.onReturnPressed: passwordField.focus = true
        }

        // Password field
        TextField {
            id: passwordField
            width: 350
            height: 60
            placeholderText: "パスワード"
            placeholderTextColor: "#99fffaf0"
            echoMode: TextInput.Password
            font.pixelSize: 18
            color: cream
            horizontalAlignment: TextInput.AlignHCenter
            background: Rectangle {
                radius: 16
                color: "#4d000000"
                border.color: greenDark
                border.width: 3
            }
            Keys.onReturnPressed: sddm.login(usernameField.text, passwordField.text, sessionModel.lastIndex)
        }

        // Login button
        Rectangle {
            id: loginButton
            width: 350
            height: 50
            radius: 16
            color: loginArea.pressed ? "#527a40" : greenDark

            Text {
                anchors.centerIn: parent
                text: "Login"
                font.pixelSize: 20
                color: cream
            }

            MouseArea {
                id: loginArea
                anchors.fill: parent
                onClicked: sddm.login(usernameField.text, passwordField.text, sessionModel.lastIndex)
            }
        }
    }

    // Error message
    Text {
        id: errorMessage
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 100
        text: ""
        font.pixelSize: 18
        color: "#cc5050"
        style: Text.Raised
        styleColor: shadow
    }

    Connections {
        target: sddm
        function onLoginFailed() {
            errorMessage.text = "Authentication failed"
            passwordField.text = ""
        }
    }

    Component.onCompleted: {
        if (usernameField.text !== "") {
            passwordField.focus = true
        } else {
            usernameField.focus = true
        }
    }
}
