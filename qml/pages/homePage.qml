import QtQuick 2.0
import QtQuick.Controls 2.15
import "../controls"

Item {
    id: root

    Rectangle {
        id: bg
        color: "#2c313c"
        anchors.fill: parent

        Rectangle {
            id: box
            width: 220
            color: "#00000000"
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 0
            anchors.left: parent.left
            anchors.leftMargin: 0
            anchors.top: parent.top
            anchors.topMargin: 0

            Rectangle {
                id: boxList
                color: "#00000000"
                anchors.top: boxTop.bottom
                anchors.topMargin: 0
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 0
                anchors.right: parent.right
                anchors.rightMargin: 0
                anchors.left: parent.left
                anchors.leftMargin: 0

                ListView {
                    id: boxView
                    x: 0
                    y: 0
                    spacing: 5
                    clip: true
                    anchors.topMargin: 30
                    anchors.fill: parent
                    model: boxModel
                    focus: true
                    delegate: BoxBtn {
                        text: dmBox
                        isActiveMenu: ListView.isCurrentItem
                        onTextChanged: {
                            backend.editBox (index, text)
                        } 
                        onClicked: {
                            backend.changeBox (index)
                            boxView.currentIndex = index
                        }
                        onDeleteBox: {
                            backend.removeBox (index)
                        }
                    }
                }
            }

            Rectangle {
                id: boxTop
                height: 35
                color: "#00000000"
                anchors.right: parent.right
                anchors.rightMargin: 0
                anchors.left: parent.left
                anchors.leftMargin: 0
                anchors.top: parent.top
                anchors.topMargin: 10

                Label {
                    id: label
                    color: "#79b7f5"
                    text: qsTr("Task Box")
                    font.pointSize: 15
                    anchors.right: parent.right
                    anchors.rightMargin: 35
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    anchors.left: parent.left
                    anchors.leftMargin: 0
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 0
                    anchors.top: parent.top
                    anchors.topMargin: 0
                }

                TopBarButton {
                    width: 35
                    btnColorDefault: "#2c313c"
                    btnIconSource: "../../images/svg_images/add.svg"
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 0
                    anchors.right: parent.right
                    anchors.rightMargin: 0
                    anchors.left: label.right
                    anchors.leftMargin: 0
                    anchors.top: parent.top
                    anchors.topMargin: 0
                    onClicked: {
                        backend.addBox ("add")
                    }
                }
            }
        }

        Rectangle {
            id: task
            color: "#30506d"
            anchors.left: box.right
            anchors.leftMargin: 0
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 0
            anchors.right: parent.right
            anchors.rightMargin: 0
            anchors.top: parent.top
            anchors.topMargin: 0

            Rectangle {
                id: content
                color: "#00000000"
                anchors.rightMargin: 10
                anchors.leftMargin: 10
                anchors.bottomMargin: 10
                anchors.topMargin: 10
                anchors.fill: parent

                Rectangle {
                    id: topDescription
                    height: 35
                    color: "#00000000"
                    anchors.right: parent.right
                    anchors.rightMargin: 0
                    anchors.left: parent.left
                    anchors.leftMargin: 0
                    anchors.top: parent.top
                    anchors.topMargin: 0

                    Label {
                        id: label1
                        color: "#79b7f5"
                        text: qsTr("Today")
                        font.pointSize: 15
                        leftPadding: 10
                        anchors.right: parent.right
                        anchors.rightMargin: 35
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignLeft
                        anchors.left: parent.left
                        anchors.leftMargin: 0
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 0
                        anchors.top: parent.top
                        anchors.topMargin: 0
                    }

                    TopBarButton {
                        btnIconSource: "../../images/svg_images/add.svg"
                        anchors.right: parent.right
                        anchors.rightMargin: 0
                        anchors.left: label1.right
                        anchors.leftMargin: 0
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 0
                        anchors.top: parent.top
                        anchors.topMargin: 0
                        onClicked: {
                            backend.addTask (boxView.currentIndex, "new Task")
                        }
                    }
                }

                Rectangle {
                    id: rectangle
                    x: -10
                    y: 90
                    color: "#00000000"
                    anchors.top: topDescription.bottom
                    anchors.topMargin: 0
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 0
                    anchors.right: parent.right
                    anchors.rightMargin: 0
                    anchors.left: parent.left
                    anchors.leftMargin: 0

                    ListView {
                        id: taskView
                        spacing: 8
                        anchors.leftMargin: 20
                        clip: true
                        anchors.topMargin: 10
                        anchors.fill: parent
                        model: taskModel
                        delegate: Task {
                            text: taskName
                            finished: finish
                            width: rectangle.width
                            isActiveMenu: ListView.isCurrentItem
                            onClicked: taskView.currentIndex = index
                            onNameChanged:{
                                backend.editTask (boxView.currentIndex, index, text, 0)
                            }
                            onFinishChanged: {
                                backend.editTask (boxView.currentIndex, index, str, 1)
                            }
                            onDeleteTask: {
                                backend.removeTask (boxView.currentIndex, index)
                            }
                        }
                    }
                }
            }
        }
    }
    Connections {
        target: boxModel
    }
    Connections {
        target: taskModel
    }

    Connections {
        target: backend
    }
}



/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}D{i:3;anchors_height:263;anchors_width:137;anchors_x:0;anchors_y:37}
D{i:7;anchors_width:102;anchors_x:0;anchors_y:9}D{i:6;anchors_width:200;anchors_x:56;anchors_y:8}
D{i:2;anchors_height:300}D{i:12;anchors_width:187;anchors_x:0;anchors_y:9}D{i:11;anchors_width:260;anchors_x:0;anchors_y:0}
D{i:15;anchors_height:160;anchors_width:110;anchors_x:59;anchors_y:50}D{i:14;anchors_height:200;anchors_width:200}
D{i:10;anchors_height:200;anchors_width:200;anchors_x:40;anchors_y:56}D{i:9;anchors_height:300;anchors_width:364;anchors_x:136;anchors_y:0}
}
##^##*/
