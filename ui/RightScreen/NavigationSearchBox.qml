import QtQuick 2.15
import QtQuick.Effects
import QtQuick.Controls

Rectangle {
    id: navigationSearchBox

    anchors {
        top: lockIcon.bottom
        left: parent.left
        margins: 20
    }

    width: parent.width / 3
    height: parent.height / 12

    color: "#f5f6f7"
    radius: 8

    // Shadow effect
    // RectangularShadow {
    //     anchors.fill: navigationSearchBox
    //     // source: navigationSearchBox
    //     blur: 10
    //     spread: 0.2
    //     color: "#2f4f4f"
    //     radius: 8
    // }

    Image {

        id: searchIcon;
        anchors{
            left: parent.left;
            leftMargin: 20;
            verticalCenter: parent.verticalCenter;
        }

        height: parent.height * .45;
        fillMode: Image.PreserveAspectFit

        source: "qrc:/ui/assets/icons-search.png"
    }

    Text {
        id: navigationPlaceHolderText;
        color: "#373737";
        text: "Navigate";
        anchors {
            verticalCenter: parent.verticalCenter;
            left: searchIcon.right;
            leftMargin: 20;
        }

        visible: navigationTextInput.text === "";


        MouseArea{
            cursorShape: Qt.PointingHandCursor;
            anchors.fill: parent;
        }
    }

    TextInput{
        id: navigationTextInput;

        anchors {
            top: parent.top;
            bottom: parent.bottom;
            right: parent.right;
            left: searchIcon.right;
            leftMargin: 20;
        }

        verticalAlignment: Text.AlignVCenter;
        font.pixelSize: 14;
        clip: true; //avoid text overflow

    }
}
