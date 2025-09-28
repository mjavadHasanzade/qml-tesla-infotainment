import QtQuick

Rectangle {

    id: leftScreen;

    anchors {
        left: parent.left;
        bottom: bottomBar.top;
        right: rightScreen.left;
        top: parent.top;
    }

    width: parent.width *1 /3;

    Image {
        id: carRender
        anchors.centerIn: parent
        width: parent.width *.85
        fillMode: Image.PreserveAspectFit
        source: "qrc:/ui/assets/car.png"
    }

}
