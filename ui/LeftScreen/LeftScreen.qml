import QtQuick 2.15

Rectangle {

    id: leftScreen;

    anchors {
        left: parent.left;
        bottom: bottomBar.top;
        right: rightScreen.left;
        top: parent.top;
    }

    color: "blue";
    width: parent.width *1 /3;
}
