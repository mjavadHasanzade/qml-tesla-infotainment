import QtQuick

Rectangle {

    id: leftScreen;

    anchors {
        left: parent.left;
        bottom: bottomBar.top;
        right: rightScreen.left;
        top: parent.top;
    }

    Image {
        id: carRender
        anchors.centerIn: parent
        width: parent.width
        fillMode: Image.PreserveAspectFit
        source: "://ui/assets/car.png"
    }

    color: "blue";
    width: parent.width *1 /3;

}
