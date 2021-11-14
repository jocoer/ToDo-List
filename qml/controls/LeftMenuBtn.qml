import QtQuick 2.12
import QtQuick.Controls 2.12

Button {
    id: btnLeftMenu
    text: qsTr("Left Menu Btn")

    // Custom Properties
    property url btnIconSource: "../../images/svg_images/home.svg"
    property color btnColorDefault: "#1c1d20"
    property color btnColorMouseOver: "#23272E"
    property color btnColorClicked: "#00a1f1"
    property color activeMenuColor: "#00a1f1"
    property color activeMenuColorRight: "#2c313c"
    property int iconWidth: 30
    property int iconHeight: 30

    property bool isActiveMenu: false

    QtObject {
        id: internal
        property var dynamicColor: if (btnLeftMenu.down) {
                                       btnLeftMenu.down ? btnColorClicked : btnColorDefault
                                   } else {
                                       btnLeftMenu.hovered ? btnColorMouseOver : btnColorDefault
                                   }
    }

    implicitWidth: 250
    implicitHeight: 60

    background: Rectangle {
        id: bgBtn
        color: internal.dynamicColor

        Rectangle {
            anchors {
                top: parent.top
                left: parent.left
                bottom: parent.bottom
            }
            width: 3
            color: activeMenuColor
            visible: isActiveMenu
        }
        Rectangle {
            anchors {
                top: parent.top
                right: parent.right
                bottom: parent.bottom
            }
            width: 5
            color: activeMenuColorRight
            visible: isActiveMenu
        }
    }
    contentItem: Item {
        id: content
        anchors.fill: parent
        Image {
            id: iconBtn
            source: btnIconSource
            anchors.verticalCenter: parent.verticalCenter
            sourceSize.width: btnLeftMenu.iconWidth
            sourceSize.height: btnLeftMenu.iconHeight
            width: btnLeftMenu.iconWidth
            height: btnLeftMenu.iconHeight
            anchors.left: parent.left
            anchors.leftMargin: 25
            fillMode: Image.PreserveAspectFit
        }

        Text {
            color: "#ffffff"
            text: btnLeftMenu.text
            font.italic: true
            font.pointSize: 13
//            font: btnLeftMenu.font
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 80

        }
    }
}



/*##^##
Designer {
    D{i:0;height:60;width:250}
}
##^##*/
