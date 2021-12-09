import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.15

import "./controls"


Window {
    id: mainWindow
    visible: true
    width: 1000
    height: 580
    minimumWidth: 500
    minimumHeight: 380
    color: "#00000000"
    title: qsTr("Hello World")

    // Remove the title bar
    flags: Qt.Window | Qt.FramelessWindowHint

    // Properties
    property int isMaximize: 0
    QtObject {
        id: internal
        function maximizeRestore () {
            if (isMaximize == 0) {
                mainWindow.showMaximized()
                isMaximize = 1
                btnMaxmize.btnIconSource = "../images/svg_images/restore_icon.svg"
            } else {
                mainWindow.showNormal()
                isMaximize = 0
                btnMaxmize.btnIconSource = "../images/svg_images/maximize_icon.svg"
            }
        }

        function ifMaximizeDragRestore () {
            if (isMaximize == 1)
            {
                mainWindow.showNormal()
                isMaximize = 0
                btnMaxmize.btnIconSource = "../images/svg_images/maximize_icon.svg"
            }
        }

        function minimizeRestore () {
            isMaximize = 0
            btnMaxmize.btnIconSource = "../images/svg_images/maximize_icon.svg"
        }
    }

    MouseArea {
        id: resizeLeft
        width: 10
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.top: parent.top
        anchors.topMargin: 0
        cursorShape: Qt.SizeHorCursor

        DragHandler {
            target: null
            onActiveChanged: if (active) {
                                 mainWindow.startSystemResize(Qt.LeftEdge)
                                 internal.minimizeRestore()
                             }
        }
    }
    MouseArea {
        id: resizeTop
        height: 10
        anchors.right: parent.right
        anchors.rightMargin: 10
        anchors.left: parent.left
        anchors.leftMargin: 10
        anchors.top: parent.top
        anchors.topMargin: 0
        cursorShape: Qt.SizeVerCursor

        DragHandler {
            target: null
            onActiveChanged: if (active) {
                                 mainWindow.startSystemResize(Qt.TopEdge)
                                 internal.minimizeRestore()
                             }
        }
    }

    MouseArea {
        id: resizeRight
        width: 10
        anchors.right: parent.right
        anchors.rightMargin: 0
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.top: parent.top
        anchors.topMargin: 0
        cursorShape: Qt.SizeHorCursor

        DragHandler {
            target: null
            onActiveChanged: if (active) {
                                 mainWindow.startSystemResize(Qt.RightEdge)
                                 internal.minimizeRestore()
                             }
        }
    }

    MouseArea {
        id: resizeBottom
        height: 10
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.right: parent.right
        anchors.rightMargin: 10
        anchors.left: parent.left
        anchors.leftMargin: 10
        cursorShape: Qt.SizeVerCursor

        DragHandler {
            target: null
            onActiveChanged: if (active) {
                                 mainWindow.startSystemResize(Qt.BottomEdge)
                                 internal.minimizeRestore()
                             }
        }
    }

    Rectangle {
        id: bg
        color: "#2c313c"
        anchors.rightMargin: 10
        anchors.leftMargin: 10
        anchors.bottomMargin: 10
        anchors.topMargin: 10
        anchors.fill: parent

        Rectangle {
            id: appContainer
            color: "#00000000"
            anchors.rightMargin: 1
            anchors.leftMargin: 1
            anchors.bottomMargin: 1
            anchors.topMargin: 1
            anchors.fill: parent

            Rectangle {
                id: topBar
                height: 60
                color: "#1c1d20"
                anchors.right: parent.right
                anchors.rightMargin: 0
                anchors.left: parent.left
                anchors.leftMargin: 0
                anchors.top: parent.top
                anchors.topMargin: 0

                ToggleBtn {
                    onClicked: animationMenu.running = true
                }

                Rectangle {
                    id: topBarDescription
                    y: 35
                    height: 25
                    color: "#43464d"
                    anchors.right: parent.right
                    anchors.rightMargin: 0
                    anchors.left: parent.left
                    anchors.leftMargin: 70
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 0

                    Label {
                        id: pageDescription
                        width: 100
                        color: "#7aacdf"
                        text: qsTr("| Home")
                        anchors.right: parent.right
                        anchors.bottom: parent.bottom
                        anchors.top: parent.top
                        font.bold: true
                        font.pointSize: 11
                        anchors.rightMargin: 5
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignRight
                    }
                }

                Rectangle {
                    id: title
                    height: 35
                    color: "#00000000"
                    anchors.right: parent.right
                    anchors.rightMargin: 105
                    anchors.left: parent.left
                    anchors.leftMargin: 70
                    anchors.top: parent.top
                    anchors.topMargin: 0

                    DragHandler {
                        onActiveChanged: if (active) {
                                            mainWindow.startSystemMove()
                                            internal.ifMaximizeDragRestore()
                                         }
                    }

                    Label {
                        id: applicationName
                        width: 750
                        color: "#ffffff"
                        text: qsTr("ToDo")
                        anchors.fill: parent
                        font.italic: true
                        font.underline: false
                        font.bold: true
                        font.family: "Times New Roman"
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        font.pointSize: 18
                    }
                }

                Row {
                    id: rowBtns
                    width: 105
                    anchors.right: parent.right
                    anchors.rightMargin: 0
                    anchors.left: title.right
                    anchors.leftMargin: 0
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 25
                    anchors.top: parent.top
                    anchors.topMargin: 0

                    TopBarButton {
                        id: btnMinimize
                        onClicked: {
                            mainWindow.showMinimized()
                            internal.minimizeRestore()
                        }
                    }

                    TopBarButton {
                        id: btnMaxmize
                        btnIconSource: "../images/svg_images/maximize_icon.svg"
                        onClicked: internal.maximizeRestore ()
                    }

                    TopBarButton {
                        id: btnClose
                        btnColorClicked: "#ff4b4b"
                        btnIconSource: "../images/svg_images/close_icon.svg"
                        onClicked: mainWindow.close()
                    }
                }
            }

            Rectangle {
                id: content
                color: "#00000000"
                anchors.top: topBar.bottom
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                anchors.left: parent.left
                anchors.topMargin: 0

                Rectangle {
                    id: leftMenu
                    width: 70
                    color: "#1c1d20"
                    clip: true
                    anchors.left: parent.left
                    anchors.leftMargin: 0
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 0
                    anchors.top: parent.top
                    anchors.topMargin: 0

                    PropertyAnimation {
                        id: animationMenu
                        target: leftMenu
                        property: "width"
                        to: if (leftMenu.width == 70) return 200; else return 70
                        duration: 500
                        easing.type: Easing.InOutQuint
                    }

                    Column {
                        id: columnMenus
                        anchors.bottomMargin: 90
                        anchors.fill: parent

                        LeftMenuBtn {
                            id: btnHome
                            width: leftMenu.width
                            text: qsTr("Home")
                            isActiveMenu: true
                            onClicked: {
                                btnHome.isActiveMenu = true
                                btnSettings.isActiveMenu = false
                                btnPomodoro.isActiveMenu = false
                                stackView.clear ()
                                stackView.push(Qt.resolvedUrl("./pages/homePage.qml"))
                            }
                        }

                        LeftMenuBtn {
                            id: btnPomodoro
                            width: leftMenu.width
                            text: qsTr("Pomodoro")
                            btnIconSource: "../images/svg_images/clock.svg"
                            onClicked: {
                                btnPomodoro.isActiveMenu = true
                                btnSettings.isActiveMenu = false
                                btnHome.isActiveMenu = false
                                stackView.clear ()
                                stackView.push(Qt.resolvedUrl("./pages/clockPage.qml"), {clockend: clock})
                            }
                        }

                        LeftMenuBtn {
                            id: btnAnalyse
                            width: leftMenu.width
                            text: qsTr("Analyse")
                            btnIconSource: "../images/svg_images/analyse.svg"
                        }
                    }

                    LeftMenuBtn {
                        id: btnSettings
                        x: 0
                        y: 180
                        width: leftMenu.width
                        text: qsTr("Settings")
                        btnIconSource: "../images/svg_images/settings.svg"
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 0
                        isActiveMenu: false

                        onClicked: {
                            btnHome.isActiveMenu = false
                            btnPomodoro.isActiveMenu = false
                            btnSettings.isActiveMenu = true
                            stackView.pop ()
                            stackView.push(Qt.resolvedUrl("./pages/settingsPage.qml"))
                        }
                    }
                }

                Rectangle {
                    id: contentPages
                    color: "#2c313c"
                    clip: true
                    anchors.right: parent.right
                    anchors.rightMargin: 0
                    anchors.left: leftMenu.right
                    anchors.leftMargin: 0
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 0
                    anchors.top: parent.top
                    anchors.topMargin: 0

                    StackView {
                        id: stackView
                        anchors.fill: parent
                        property var boxModel: myModel
                        property var taskModel: tasks 
                        property var back: backend
                    }
                }
            }

        }
    }
}



/*##^##
Designer {
    D{i:2;anchors_height:100}D{i:4;anchors_width:10}D{i:32;anchors_height:200;anchors_width:200;anchors_x:319;anchors_y:171}
}
##^##*/
