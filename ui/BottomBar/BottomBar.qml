import QtQuick


Rectangle {
    id: bottomBar
    anchors {
        left: parent.left
        right: parent.right
        bottom: parent.bottom
    }

    color: "black"
    height: parent.height / 12

    Image {
        id: carSettingsIcon
        source: "qrc:/ui/assets/icon-car.png"

        anchors {
            left: parent.left;
            leftMargin: 30;
            verticalCenter: parent.verticalCenter;
        }

        height: parent.height * .85;
        width: 40;
        fillMode: Image.PreserveAspectFit;
    }
}
