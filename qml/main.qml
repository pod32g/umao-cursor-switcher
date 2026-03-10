import QtQuick
import QtQuick.Controls as QQC2
import QtQuick.Window

QQC2.ApplicationWindow {
    id: window
    title: "UmaOS Cursor Switcher"
    visible: true
    width: 540
    height: 720
    minimumWidth: 440
    minimumHeight: 500
    color: Theme.nearBlack

    Component.onCompleted: {
        x = Screen.width / 2 - width / 2
        y = Screen.height / 2 - height / 2
    }

    QQC2.StackView {
        id: stackView
        anchors.fill: parent
        initialItem: pickerScreen

        pushEnter: Transition {
            PropertyAnimation { property: "opacity"; from: 0; to: 1; duration: 200 }
        }
        pushExit: Transition {
            PropertyAnimation { property: "opacity"; from: 1; to: 0; duration: 200 }
        }
        popEnter: Transition {
            PropertyAnimation { property: "opacity"; from: 0; to: 1; duration: 200 }
        }
        popExit: Transition {
            PropertyAnimation { property: "opacity"; from: 1; to: 0; duration: 200 }
        }
    }

    Component {
        id: pickerScreen
        PickerScreen {}
    }
    Component {
        id: doneScreen
        DoneScreen {}
    }
}
