import QtQuick 2.12
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.0

Button {
    id: toggleBtn

    // Custom Properties
    property url btnIconSource: "../../images/svg_images/menu_icon.svg"
    property color btnColorDefault: "#1c1d20"
    property color btnColorMouseOver: "#23272E"
    property color btnColorClicked: "#00a1f1"

    QtObject {
        id: internal
        property var dynamicColor: if (toggleBtn.down) {
                                       toggleBtn.down ? btnColorClicked : btnColorDefault
                                   } else {
                                       toggleBtn.hovered ? btnColorMouseOver : btnColorDefault
                                   }
    }

    implicitWidth: 70
    implicitHeight: 60

    background: Rectangle {
        color: internal.dynamicColor

        Image {
            id: iconBtn
            source: btnIconSource
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            width: 25
            height: 25
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

/*##^##
Designer {
    D{i:0;autoSize:true;height:60;width:70}
}
##^##*/
