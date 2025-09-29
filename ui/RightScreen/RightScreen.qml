import QtQuick 2.15
import QtLocation
import QtPositioning

Rectangle {
    id: rightScreen

    anchors {
        top: parent.top;
        bottom: bottomBar.top;
        right: parent.right;
    }
    width: parent.width *2 /3;

    Plugin {
        id: mapPlugin
        name: "osm"

        PluginParameter{
            name: "osm.mapping.custom.host";
            value: "https://tile.openstreetmap.org/";
        }
    }

    Map {
        id: map
        activeMapType: map.supportedMapTypes[map.supportedMapTypes.length - 1];
        anchors.fill: parent
        plugin: mapPlugin
        center: QtPositioning.coordinate(35.7219, 51.3347) // Tehran
        zoomLevel: 14
        property geoCoordinate startCentroid

        PinchHandler {
            id: pinch
            target: null
            onActiveChanged: if (active) {
                                 map.startCentroid = map.toCoordinate(pinch.centroid.position, false)
                             }
            onScaleChanged: (delta) => {
                                map.zoomLevel += Math.log2(delta)
                                map.alignCoordinateToPoint(map.startCentroid, pinch.centroid.position)
                            }
            onRotationChanged: (delta) => {
                                   map.bearing -= delta
                                   map.alignCoordinateToPoint(map.startCentroid, pinch.centroid.position)
                               }
            grabPermissions: PointerHandler.TakeOverForbidden
        }
        WheelHandler {
            id: wheel
            // workaround for QTBUG-87646 / QTBUG-112394 / QTBUG-112432:
            // Magic Mouse pretends to be a trackpad but doesn't work with PinchHandler
            // and we don't yet distinguish mice and trackpads on Wayland either
            acceptedDevices: Qt.platform.pluginName === "cocoa" || Qt.platform.pluginName === "wayland"
                             ? PointerDevice.Mouse | PointerDevice.TouchPad
                             : PointerDevice.Mouse
            rotationScale: 1/120
            property: "zoomLevel"
        }
        DragHandler {
            id: drag
            target: null
            onTranslationChanged: (delta) => map.pan(-delta.x, -delta.y)
        }
        Shortcut {
            enabled: map.zoomLevel < map.maximumZoomLevel
            sequence: StandardKey.ZoomIn
            onActivated: map.zoomLevel = Math.round(map.zoomLevel + 1)
        }
        Shortcut {
            enabled: map.zoomLevel > map.minimumZoomLevel
            sequence: StandardKey.ZoomOut
            onActivated: map.zoomLevel = Math.round(map.zoomLevel - 1)
        }
    }

    Image {
        id: lockIcon;
        width: 25;
        height: 25;


        anchors {
            left: parent.left;
            top: parent.top;
            margins: 20
        }

        source: (systemHandler.carLocked ? "qrc:/ui/assets/icons-lock.png" : "qrc:/ui/assets/icons-unlock.png");

        MouseArea {
            anchors.fill: parent;
            onClicked: systemHandler.setCarLocked(!systemHandler.carLocked);
        }

    }

    Text {
        id: dateTimeDisplay

        anchors {
            left: lockIcon.right;
            leftMargin: 40;
            bottom: lockIcon.bottom
        }

        font{
            pixelSize: 14;
            bold: true;
        }

        color: "black";
        text: systemHandler.currentTime;
    }

    Text {
        id: outdoorTempDisplay

        anchors {
            left: dateTimeDisplay.right;
            leftMargin: 40;
            bottom: lockIcon.bottom
        }

        font{
            pixelSize: 14;
            bold: true;
        }

        color: "black";
        text: systemHandler.outdoorTemp + "°F";
    }


    Text {
        id: userNameDisplay

        anchors {
            left: outdoorTempDisplay.right;
            leftMargin: 40;
            bottom: lockIcon.bottom
        }

        font{
            pixelSize: 14;
            bold: true;
        }

        color: "black";
        text: systemHandler.userName;
    }

    NavigationSearchBox {
        id: navigationSearchBox;

        anchors{

            top: lockIcon.bottom;
            left: parent.left;
            margins:20;
        }

        color: "white";
        width: parent.width /3;
        height: 50
    }

}
