import QtQuick 2.12
import QtQuick.Controls 2.15

Button {
    id: customBtn
    text: qsTr("Custom Btn")
    implicitWidth: 200
    implicitHeight: 40

    // custom properties
    property color colorDefault: "#55aaff"
    property color colorMouseOver: "#cccccc"
    property color colorPressed: "#333333"

    QtObject {
        id: internal

        property var dynamicColor: if (customBtn.down) {
                                       customBtn.down ? colorPressed : colorDefault
                                   } else {
                                       customBtn.hovered ? colorMouseOver : colorDefault
                                   }
    }

    background: Rectangle {
        color: internal.dynamicColor
        radius: 10
    }

    contentItem: Item {
        id: element
        Text {
            id: btnText
            text: customBtn.text
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            color: "#ffffff"
        }
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:40;width:200}
}
##^##*/
