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

    HVACComponent {
        id: driveHVACControl;

        anchors {
            top:parent.top;
            bottom: parent.bottom;
            left: carSettingsIcon.right;
            leftMargin: parent.width /6;
        }
        hvacController: driverHVAC;
    }

    HVACComponent {
        id: passengerHVACControl;

        anchors {
            top:parent.top;
            bottom: parent.bottom;
            right: parent.right;
            rightMargin: parent.width /6;
        }
        hvacController: passengerHVAC;
    }
}
