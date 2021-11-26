import QtQuick 2.12
import QtQuick.Controls 2.12

Button {
    id: btnBox
    text: qsTr("Left Menu Btn")

    signal textChanged()
    signal deleteBox ()

    // Custom Properties
    property url btnIconSource: "../../images/svg_images/box.svg"
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
        property var dynamicColor: if (btnBox.down) {
                                       btnBox.down ? btnColorClicked : btnColorDefault
                                   } else {
                                       btnBox.hovered ? btnColorMouseOver : btnColorDefault
                                   }
        function inputTitle() {
            input.visible = true
            input.focus = true
            title.visible = false
        }

        function finishInput () {
            input.visible = false
            input.focus = false
            btnBox.text = input.text
            title.visible = true
            textChanged ()
        }

    }

    onDoubleClicked: {
        internal.inputTitle()
    }

    implicitWidth: 250
    implicitHeight: 60

    background: Rectangle {
        id: bgBtn
        color: internal.dynamicColor
        visible: btnBox.hovered
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
            sourceSize.width: btnBox.iconWidth
            sourceSize.height: btnBox.iconHeight
            width: btnBox.iconWidth
            height: btnBox.iconHeight
            anchors.left: parent.left
            anchors.leftMargin: 25
            fillMode: Image.PreserveAspectFit
        }

        TextInput {
            id: input
            color: "#f5f4f4"
            text: ""
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
            font.pointSize: 15
            anchors.top: parent.top
            anchors.topMargin: 0
            anchors.right: parent.right
            anchors.rightMargin: 0
            anchors.left: parent.left
            anchors.leftMargin: 65
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 0
            visible: false

            selectByMouse: true
            maximumLength: 15

            onEditingFinished: {
                internal.finishInput()
            }
        }

        Text {
            id: title
            color: "#ffffff"
            text: btnBox.text
            font.italic: true
            font.pointSize: 13
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 80

        }
        RoundButton {
            id: roundButton
            x: 302
            y: 12
            width: 20
            height: 20
            text: ""
            anchors.right: parent.right
            anchors.rightMargin: 30
            anchors.verticalCenter: parent.verticalCenter

            background: Rectangle {
                id: bg
                width: 20
                height: 20
                color: "#00000000"
                radius: 10
                Image {
                    source: "../../images/svg_images/delete.svg"
                    anchors.fill: parent
                    width: 20
                    height: 20
                    fillMode: Image.PreserveAspectFit
                }
                visible: btnBox.hovered
            }
            onClicked: deleteBox ()
            // onClicked: console.log ('delete click')
        }
    }
}



/*##^##
Designer {
    D{i:0;autoSize:true;height:60;width:250}D{i:7;anchors_height:60;anchors_width:176;anchors_x:74;anchors_y:0}
D{i:9;anchors_width:20;anchors_x:302}
}
##^##*/
