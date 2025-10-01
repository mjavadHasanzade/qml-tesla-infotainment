import QtQuick 2.15
import Qt5Compat.GraphicalEffects
import QtQuick.Controls 2.15

Row {
    id: musicPlayer
    anchors.margins: 0
    spacing: 20
    height: parent.height * .2
    padding:20
    width: parent.width - padding //parent's padding"

    // Helper function to format time
    function formatTime(seconds) {
        var mins = Math.floor(seconds / 60)
        var secs = Math.floor(seconds % 60)
        return mins + ":" + (secs < 10 ? "0" + secs : secs)
    }

    // Album cover
    Rectangle {
        width: 70
        height: 70
        radius: 12
        color: "transparent"
        anchors.verticalCenter: parent.verticalCenter
        id: ablumArtContainer

        Rectangle {
            id: albumArtContainer
            anchors.fill: parent
            radius: 12
            color: "transparent"
            clip: true

            Image {
                id: albumArt
                anchors.fill: parent
                source: "qrc:/ui/assets/unstopable.jpg"
                fillMode: Image.PreserveAspectCrop
                smooth: true
                layer.enabled: true
                layer.effect: OpacityMask {
                    maskSource: Rectangle {
                        width: albumArtContainer.width
                        height: albumArtContainer.height
                        radius: 12
                    }
                }
            }
        }

        // Drop shadow for album art
        DropShadow {
            anchors.fill: albumArtContainer
            source: albumArtContainer
            horizontalOffset: 0
            verticalOffset: 4
            radius: 12
            samples: 17
            color: "#30000000"
        }
    }

    Column {
        spacing: 3
        width: parent.width * .5 - albumArtContainer.width - parent.spacing * 2 ; // spacing from two sides
        anchors.verticalCenter: parent.verticalCenter

        // Text information
        Column {
            width: parent.width
            spacing: 5

            Text {
                text: "Unstoppable"
                font.pixelSize: 15
                font.weight: Font.Bold
                color: "#2C3E50"
                elide: Text.ElideRight
                width: parent.width
            }

            Text {
                text: "Sia"
                font.pixelSize: 13
                color: "#34495E"
                elide: Text.ElideRight
                width: parent.width
            }

            Text {
                text: "This Is Acting"
                font.pixelSize: 11
                color: "#7F8C8D"
                elide: Text.ElideRight
                width: parent.width
            }
        }

        // Progress slider
        Column {
            width: parent.width

            Slider {
                id: progressSlider
                width: parent.width
                height: 20
                from: 0
                to: 240
                value: 45
                live: true

                background: Rectangle {
                    width: parent.width
                    height: 4
                    radius: 2
                    color: "#ECF0F1"
                    anchors.verticalCenter: parent.verticalCenter

                    Rectangle {
                        width: progressSlider.visualPosition * parent.width
                        height: parent.height
                        radius: 2
                        color: "#3498DB"
                    }
                }

                handle: Rectangle {
                    x: progressSlider.visualPosition * (progressSlider.width - width)
                    y: (progressSlider.height - height) / 2
                    width: 16
                    height: 16
                    radius: 8
                    color: progressSlider.pressed ? "#2980B9" : "#FFFFFF"
                    border.width: 3
                    border.color: "#3498DB"

                    Behavior on color {
                        ColorAnimation { duration: 150 }
                    }

                    scale: progressSlider.pressed ? 1.2 : 1.0
                }

                onMoved: {
                    console.log("Seek to:", formatTime(value))
                }
            }

            // Time labels - properly spaced
            Row {
                width: parent.width

                Text {
                    id: currentTimeLabel
                    text: formatTime(progressSlider.value)
                    font.pixelSize: 11
                    color: "#34495E"
                }

                Item {
                    width: parent.width - currentTimeLabel.width - totalTimeLabel.width
                    height: 1
                }

                Text {
                    id: totalTimeLabel
                    text: formatTime(progressSlider.to)
                    font.pixelSize: 11
                    color: "#7F8C8D"
                }
            }
        }
    }

    Item {
        width: parent.width / 2 - padding
        height: parent.height
        anchors.verticalCenter: parent.verticalCenter

        Row {
            anchors.centerIn: parent
            spacing: 20

            Rectangle {
                width: 35
                height: 35
                anchors.verticalCenter: parent.verticalCenter
                opacity: repeatMouseArea.pressed ? 0.7 : 1.0

                Image {
                    source: "qrc:/ui/assets/icons-repeat.png"
                    width: 16
                    height: 16
                    anchors.centerIn: parent
                    fillMode: Image.PreserveAspectFit
                }

                MouseArea {
                    id: repeatMouseArea
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: console.log("repeat track")
                }
            }

            // Previous button
            Rectangle {
                width: 35
                height: 35
                anchors.verticalCenter: parent.verticalCenter
                opacity: prevMouseArea.pressed ? 0.7 : 1.0

                Image {
                    source: "qrc:/ui/assets/icons-backward.png"
                    width: 20
                    height: 20
                    anchors.centerIn: parent
                    fillMode: Image.PreserveAspectFit
                }

                MouseArea {
                    id: prevMouseArea
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: console.log("Previous track")
                }
            }

            // Play/Pause button
            Rectangle {
                width: 50
                height: 50
                anchors.verticalCenter: parent.verticalCenter
                opacity: playMouseArea.pressed ? 0.7 : 1.0

                Image {
                    source: "qrc:/ui/assets/icons-play.png"
                    width: 22
                    height: 22
                    anchors.centerIn: parent
                    fillMode: Image.PreserveAspectFit
                }

                MouseArea {
                    id: playMouseArea
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: console.log("Play/Pause toggled")
                }
            }

            // Next button
            Rectangle {
                width: 35
                height: 35
                anchors.verticalCenter: parent.verticalCenter
                opacity: nextMouseArea.pressed ? 0.7 : 1.0

                Image {
                    source: "qrc:/ui/assets/icons-forward.png"
                    width: 20
                    height: 20
                    anchors.centerIn: parent
                    fillMode: Image.PreserveAspectFit
                }

                MouseArea {
                    id: nextMouseArea
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: console.log("Next track")
                }
            }

            Rectangle {
                width: 35
                height: 35
                anchors.verticalCenter: parent.verticalCenter
                opacity: shuffleMouseArea.pressed ? 0.7 : 1.0

                Image {
                    source: "qrc:/ui/assets/icons-shuffle.png"
                    width: 16
                    height: 16
                    anchors.centerIn: parent
                    fillMode: Image.PreserveAspectFit
                }

                MouseArea {
                    id: shuffleMouseArea
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: console.log("shuffle tracks")
                }
            }
        }
    }

}
