import QtQuick 2.15
import QtQuick.Controls 2.15
import Qt5Compat.GraphicalEffects

Item {
    id: bottomSheet
    anchors.fill: parent

    property bool opened: false
    property real closedHeight: parent ? parent.height * 0.2 : 60
    property real openedHeight: parent ? parent.height * 0.9 : 540

    // default property for injecting content
    default property alias content: contentColumn.data

    // DropShadow for smooth visual effect
    DropShadow {
        anchors.fill: sheet
        source: sheet
        horizontalOffset: 0
        verticalOffset: 0
        radius: 24
        samples: 25
        color: "#26000000" // subtle shadow
        z: 0
    }

    Rectangle {
        id: sheet
        width: parent.width
        height: openedHeight
        radius: 16
        color: "#ffffff"
        anchors.horizontalCenter: parent.horizontalCenter
        y: bottomSheet.height - closedHeight
        z: 1
        clip: true

        // Header (drag handle + click-to-toggle)
        Rectangle {
            id: header
            anchors.top: parent.top
            width: parent.width
            height: 24
            color: "transparent"
            z: 2

            Rectangle {
                width: 44
                height: 5
                radius: 3
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                color: "#aaa"
            }

            MouseArea {
                anchors.fill: parent
                drag.target: sheet
                drag.axis: Drag.YAxis
                drag.minimumY: bottomSheet.height - openedHeight
                drag.maximumY: bottomSheet.height - closedHeight
                cursorShape: "PointingHandCursor";
                preventStealing: true  // blocks underlying map


                onClicked: bottomSheet.opened = !bottomSheet.opened

                onReleased: {
                    if (sheet.y < bottomSheet.height - (openedHeight + closedHeight)/2)
                        bottomSheet.opened = true
                    else
                        bottomSheet.opened = false
                }
            }
        }

        // Content container
        Column {
            id: contentColumn
            anchors.top: header.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
        }
    }

    states: [
        State { name: "opened"; when: bottomSheet.opened; PropertyChanges { target: sheet; y: bottomSheet.height - openedHeight } },
        State { name: "closed"; when: !bottomSheet.opened; PropertyChanges { target: sheet; y: bottomSheet.height - closedHeight } }
    ]

    transitions: [
        Transition { NumberAnimation { properties: "y"; duration: 260; easing.type: Easing.InOutQuad } }
    ]
}
