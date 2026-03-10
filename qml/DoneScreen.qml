import QtQuick
import QtQuick.Controls as QQC2

Item {
    id: root
    property string themeName: ""

    Column {
        anchors.centerIn: parent
        spacing: 12
        width: parent.width - 72

        // Checkmark circle
        Rectangle {
            width: 64
            height: 64
            radius: 32
            color: Theme.primaryGreen
            anchors.horizontalCenter: parent.horizontalCenter

            Canvas {
                anchors.centerIn: parent
                width: 28
                height: 22
                onPaint: {
                    var ctx = getContext("2d")
                    ctx.strokeStyle = Theme.nearBlack
                    ctx.lineWidth = 3
                    ctx.lineCap = "round"
                    ctx.lineJoin = "round"
                    ctx.beginPath()
                    ctx.moveTo(2, 11)
                    ctx.lineTo(10, 19)
                    ctx.lineTo(26, 3)
                    ctx.stroke()
                }
            }
        }

        Item { width: 1; height: 8 }

        Text {
            text: "Cursor Applied!"
            font.family: Theme.sansFont
            font.pixelSize: 24
            font.weight: Font.Bold
            color: Theme.textPrimary
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Text {
            text: root.themeName + " is now your active cursor."
            font.family: Theme.sansFont
            font.pixelSize: 15
            color: Theme.textSecondary
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Text {
            text: "Log out and back in if it doesn't update immediately."
            font.family: Theme.sansFont
            font.pixelSize: 13
            color: Theme.textMuted
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Item { width: 1; height: 16 }

        // Close button
        Rectangle {
            width: closeText.width + 48
            height: 44
            radius: 8
            color: Theme.primaryGreen
            anchors.horizontalCenter: parent.horizontalCenter

            Text {
                id: closeText
                anchors.centerIn: parent
                text: "Close"
                font.family: Theme.sansFont
                font.pixelSize: 15
                font.weight: Font.DemiBold
                color: Theme.nearBlack
            }
            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: Qt.quit()
            }
        }
    }
}
