import QtQuick 2.12
import QtQuick.Controls 2.12

Button {
    id: btnBox
    text: qsTr("Left Menu Btn")

    // Custom Properties
    property color btnColorDefault: "#1c1d20"
    property color btnColorMouseOver: "#23272E"
    property color btnColorClicked: "#00a1f1"
    property color activeMenuColor: "#00a1f1"
    property color activeMenuColorRight: "#2c313c"

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
        }

        function checkTask () {
            if (checkBox.checkState === Qt.Checked)
            {
                title.font.strikeout = true
                title.opacity = 0.5
            }
            else
            {
                title.font.strikeout = false
                title.opacity = 1
            }
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
            font.italic: false
            font.pointSize: 12
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 65

        }

        CheckBox {
            id: checkBox
            text: qsTr("")
            anchors.left: parent.left
            anchors.leftMargin: 10
            anchors.top: parent.top
            anchors.topMargin: 0
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 0
            display: AbstractButton.IconOnly
            onCheckStateChanged: internal.checkTask()
        }

        RoundButton {
            id: roundButton
            x: 302
            y: 12
            width: 20
            height: 20
            text: ""
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: 25

            background: Rectangle {
                id: bg
                width: 20
                height: 20
                color: "#00000000"
                radius: 10
//                anchors.fill: parent
                Image {
                    source: "../../images/svg_images/delete.svg"
                    anchors.fill: parent
                    width: 20
                    height: 20
                    fillMode: Image.PreserveAspectFit
                }
                visible: isActiveMenu
            }
        }
    }
}



/*##^##
Designer {
    D{i:0;autoSize:true;height:60;width:250}D{i:8;anchors_x:8;anchors_y:12}D{i:9;anchors_y:12}
}
##^##*/
