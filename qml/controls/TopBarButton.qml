import QtQuick 2.12
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.0

Button {
    id: btnTopBar

    // Custom Properties
    property url btnIconSource: "../../images/svg_images/minimize_icon.svg"
    property color btnColorDefault: "#1c1d20"
    property color btnColorMouseOver: "#23272E"
    property color btnColorClicked: "#00a1f1"

    QtObject {
        id: internal
        property var dynamicColor: if (btnTopBar.down) {
                                       btnTopBar.down ? btnColorClicked : btnColorDefault
                                   } else {
                                       btnTopBar.hovered ? btnColorMouseOver : btnColorDefault
                                   }
    }

    width: 35
    height: 35

    background: Rectangle {
        color: internal.dynamicColor

        Image {
            id: iconBtn
            source: btnIconSource
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            width: 16
            height: 16
            fillMode: Image.PreserveAspectFit
        }

        ColorOverlay {
            anchors.fill: iconBtn
            source: iconBtn
            color: "#ffffff"
            antialiasing: false
        }
    }
}


