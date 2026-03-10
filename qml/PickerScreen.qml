import QtQuick
import QtQuick.Controls as QQC2
import QtQuick.Layouts

Item {
    id: root

    property string selectedTheme: backend.currentTheme
    property int selectionVersion: 0

    function isSelected(themeId) {
        void selectionVersion
        return selectedTheme === themeId
    }

    function selectTheme(themeId) {
        selectedTheme = themeId
        selectionVersion++
    }

    function selectedDisplayName() {
        var themes = backend.themes
        for (var i = 0; i < themes.length; i++) {
            if (themes[i].themeId === selectedTheme)
                return themes[i].displayName
        }
        return ""
    }

    // ── Header ──
    Column {
        id: header
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.leftMargin: 36
        anchors.rightMargin: 36
        anchors.topMargin: 36
        spacing: 6

        Text {
            text: "UMAOS"
            font.family: Theme.sansFont
            font.pixelSize: 13
            font.weight: Font.Medium
            font.letterSpacing: 0.8
            color: Theme.primaryGreen
        }
        Text {
            text: "Cursor Switcher"
            font.family: Theme.sansFont
            font.pixelSize: 28
            font.weight: Font.Bold
            font.letterSpacing: -0.3
            color: Theme.textPrimary
        }
        Text {
            text: "Choose an Uma Musume character cursor for your desktop."
            font.family: Theme.sansFont
            font.pixelSize: 14
            color: Theme.textMuted
        }
    }

    // ── Theme list ──
    ListView {
        id: themeList
        anchors.top: header.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: footer.top
        anchors.topMargin: 20
        anchors.leftMargin: 28
        anchors.rightMargin: 28
        anchors.bottomMargin: 8
        clip: true
        spacing: 6
        model: backend.themes

        delegate: Rectangle {
            id: rowDelegate
            width: themeList.width
            height: 64
            radius: 10
            color: root.isSelected(modelData.themeId) ? Theme.cardBg : "transparent"

            property bool checked: root.isSelected(modelData.themeId)
            property bool isActive: modelData.themeId === backend.currentTheme

            Row {
                anchors.fill: parent
                anchors.leftMargin: 14
                anchors.rightMargin: 14
                spacing: 14

                // Radio button
                Item {
                    width: 22
                    height: 22
                    anchors.verticalCenter: parent.verticalCenter

                    Rectangle {
                        anchors.fill: parent
                        radius: 11
                        color: rowDelegate.checked ? Theme.primaryGreen : "transparent"
                        border.width: rowDelegate.checked ? 0 : 1.5
                        border.color: Theme.borderGreen

                        // Inner dot
                        Rectangle {
                            anchors.centerIn: parent
                            width: 8
                            height: 8
                            radius: 4
                            color: Theme.nearBlack
                            visible: rowDelegate.checked
                        }
                    }
                }

                // Text content
                Column {
                    anchors.verticalCenter: parent.verticalCenter
                    spacing: 3
                    width: parent.width - 50

                    Row {
                        spacing: 8
                        Text {
                            text: modelData.displayName
                            font.family: Theme.sansFont
                            font.pixelSize: 15
                            font.weight: Font.DemiBold
                            color: rowDelegate.checked ? Theme.textPrimary : Theme.textSecondary
                        }
                        // Active badge
                        Rectangle {
                            visible: rowDelegate.isActive
                            width: activeLabel.width + 16
                            height: activeLabel.height + 4
                            radius: 4
                            color: Qt.rgba(1.0, 0.569, 0.753, 0.12)
                            anchors.verticalCenter: parent.children[0].verticalCenter

                            Text {
                                id: activeLabel
                                anchors.centerIn: parent
                                text: "Active"
                                font.family: Theme.sansFont
                                font.pixelSize: 11
                                font.weight: Font.Medium
                                color: Theme.pinkAccent
                            }
                        }
                    }

                    Text {
                        text: modelData.themeId
                        font.family: Theme.monoFont
                        font.pixelSize: 12
                        color: rowDelegate.checked ? Theme.textDim : Theme.faintGreen
                        elide: Text.ElideRight
                        width: parent.width
                    }
                }
            }

            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: root.selectTheme(modelData.themeId)
            }
        }
    }

    // ── Footer ──
    Rectangle {
        id: footer
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        height: 72
        color: "transparent"

        Rectangle {
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            height: 1
            color: Theme.divider
        }

        Row {
            anchors.left: parent.left
            anchors.leftMargin: 36
            anchors.verticalCenter: parent.verticalCenter

            Text {
                text: root.selectedTheme
                    ? root.selectedDisplayName() + " selected"
                    : "No cursor selected"
                font.family: Theme.sansFont
                font.pixelSize: 13
                color: Theme.dimGreen
            }
        }

        Row {
            anchors.right: parent.right
            anchors.rightMargin: 36
            anchors.verticalCenter: parent.verticalCenter
            spacing: 10

            // Cancel button
            Rectangle {
                width: cancelText.width + 40
                height: 40
                radius: 8
                color: "transparent"
                border.width: 1
                border.color: Theme.borderGreen

                Text {
                    id: cancelText
                    anchors.centerIn: parent
                    text: "Cancel"
                    font.family: Theme.sansFont
                    font.pixelSize: 14
                    font.weight: Font.Medium
                    color: Theme.textMuted
                }
                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: Qt.quit()
                }
            }

            // Apply button
            Rectangle {
                width: applyText.width + 48
                height: 40
                radius: 8
                color: hasNewSelection ? Theme.primaryGreen : Theme.borderGreen
                opacity: hasNewSelection ? 1.0 : 0.5

                property bool hasNewSelection: root.selectedTheme !== "" && root.selectedTheme !== backend.currentTheme

                Text {
                    id: applyText
                    anchors.centerIn: parent
                    text: "Apply"
                    font.family: Theme.sansFont
                    font.pixelSize: 14
                    font.weight: Font.DemiBold
                    color: Theme.nearBlack
                }
                MouseArea {
                    anchors.fill: parent
                    cursorShape: parent.hasNewSelection ? Qt.PointingHandCursor : Qt.ArrowCursor
                    onClicked: {
                        if (parent.hasNewSelection) {
                            backend.applyTheme(root.selectedTheme)
                            stackView.push(doneScreen, {
                                "themeName": root.selectedDisplayName()
                            })
                        }
                    }
                }
            }
        }
    }
}
