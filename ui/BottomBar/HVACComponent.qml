import QtQuick

Item {

    property string fontColor: "#ccc";
    property var hvacController;

    Rectangle {
        id: decrementButton;
        anchors {
            left: parent.left;
            top: parent.top;
            bottom: parent.bottom;
        }

        width: height / 2;
        color: "black";

        Text {
            id: decrementText;
            color: fontColor;
            anchors.centerIn: parent;
            text: "◀";
            font.pixelSize: 12;
        }

        MouseArea {
            anchors.fill: parent;
            onClicked: hvacController.chnageTargetTemprature(-1);
        }
    }

    Text {
        id: targetTempratureText;
        anchors {
            left: decrementButton.right;
            leftMargin: 15;
            verticalCenter: parent.verticalCenter;
        }
        color: fontColor;
        font.pixelSize: 24;
        text: hvacController.targetTemprature;
    }



    Rectangle {
        id: incrementButton;
        anchors {
            left: targetTempratureText.right;
            top: parent.top;
            bottom: parent.bottom;
            leftMargin: 15;
        }

        width: height / 2;
        color: "black";

        Text {
            id: incrementText;
            color: fontColor;
            anchors.centerIn: parent;
            text: "▶";
            font.pixelSize: 12;
        }

        MouseArea {
            anchors.fill: parent;
            onClicked: hvacController.chnageTargetTemprature(1);
        }
    }



}
