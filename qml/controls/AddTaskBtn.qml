import QtQuick 2.12
import QtQuick.Controls 2.12

Button {
    id: toggleBtn

    // Custom Properties
    property url btnIconSource: "../../images/svg_images/add.svg"
    property color btnColorDefault: "#2c313c"
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

    implicitWidth: 35
    implicitHeight: 35

    background: Rectangle {
        color: internal.dynamicColor

        Image {
            id: iconBtn
            source: btnIconSource
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            sourceSize.width: 25
            sourceSize.height: 25
            width: 25
            height: 25
            fillMode: Image.PreserveAspectFit
        }
    }
}
/*##^##
Designer {
    D{i:0;autoSize:true;height:35;width:35}
}
##^##*/
