import QtQuick
import QtQuick.Effects

Item {
    property string fontColor: "#ccc"

    Rectangle {
        id: decrementButton
        width: 20
        height: 40
        color: "black"
        radius: 4

        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left

        Text {
            anchors.centerIn: parent
            color: fontColor
            text: "-"
            font.pixelSize: 14
        }

        MouseArea {
            anchors.fill: parent;
            onClicked: audioHandler.changeVolume(-10);
            cursorShape: "PointingHandCursor"
        }
    }

    Column {
        anchors {
            left: decrementButton.right
            leftMargin: 10
            verticalCenter: parent.verticalCenter
        }
        spacing: 2
        width: targetVolumeIcon.width

        Image {
            id: targetVolumeIcon
            source: audioHandler.volume === 0  ?
                        "qrc:/ui/assets/icons-mute.png"  :
                        audioHandler.volume > 0 && audioHandler.volume <=30  ?
                            "qrc:/ui/assets/icons-low-volume.png" :
                            audioHandler.volume > 30 && audioHandler.volume <=70  ?
                                "qrc:/ui/assets/icons-volume-normal.png" :
                                "qrc:/ui/assets/icons-audio-high.png";

            width: 20
            height: 20
            fillMode: Image.PreserveAspectFit;

            MouseArea {
                anchors.fill: parent;
                cursorShape: "PointingHandCursor";
                onClicked: audioHandler.muteVolume();
            }
        }

        Text {
            id: targetVolumeText
            text: audioHandler.volume;
            font.pixelSize: 10
            color: "#fff"
            width: parent.width
            horizontalAlignment: Text.AlignHCenter
            anchors.topMargin: 4
        }
    }


    Rectangle {
        id: incrementButton
        width: 20
        height: 40
        color: "black"
        radius: 4

        anchors.verticalCenter: parent.verticalCenter
        anchors.left: targetVolumeIcon.parent.right
        anchors.leftMargin: 10

        Text {
            anchors.centerIn: parent
            color: fontColor
            text: "+"
            font.pixelSize: 14
        }

        MouseArea {
            anchors.fill: parent;
            onClicked: audioHandler.changeVolume(10);
            cursorShape: "PointingHandCursor"
        }
    }
}
