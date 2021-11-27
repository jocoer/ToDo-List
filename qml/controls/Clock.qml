import QtQuick 2.0
import QtQuick.Controls 2.12

Item {
    width: 200
    height: 200

    property bool isRunning:false
    property string minText: "100"
    property string secondText: "00"
    
    signal startClock ()

    Rectangle {
        id: bg
        radius: 100
        gradient: Gradient {
            GradientStop {
                position: 0
                color: "#5433ff"
            }

            GradientStop {
                position: 1
                color: "#a5fecb"
            }
        }
        anchors.rightMargin: 0
        anchors.bottomMargin: 0
        anchors.leftMargin: 0
        anchors.topMargin: 0
        anchors.fill: parent

        Rectangle {
            id: clock
            height: 50
            color: "#00000000"
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: 0
            anchors.left: parent.left
            anchors.leftMargin: 0

            Label {
                id: second
                x: 110
                y: 0
                text: secondText
                anchors.left: dot.right
                anchors.leftMargin: 0
                anchors.bottom: parent.bottom
                font.pointSize: 15
                anchors.topMargin: 0
                verticalAlignment: Text.AlignVCenter
                font.bold: true
                horizontalAlignment: Text.AlignHCenter
                anchors.bottomMargin: 0
                anchors.top: parent.top
                anchors.rightMargin: 0
            }

            Label {
                id: dot
                x: 90
                y: 0
                width: 20
                text: qsTr(":")
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.bottom
                font.pointSize: 15
                anchors.topMargin: 0
                verticalAlignment: Text.AlignVCenter
                font.bold: true
                horizontalAlignment: Text.AlignHCenter
                anchors.bottomMargin: 0
                anchors.top: parent.top
            }

            Label {
                id: min
                x: 55
                y: 0
                text: minText
                anchors.top: parent.top
                anchors.topMargin: 0
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 0
                anchors.right: dot.left
                anchors.rightMargin: 0
                font.bold: true
                font.pointSize: 15
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
            }


        }

        MouseArea {
            id: mouseArea
            anchors.fill: parent
            onClicked: {
                isRunning = isRunning == false ? true : false
                startClock ()
            }
        }

    }

    Rectangle {
        id: rectangle
        x: 0
        y: 0
        width: 200
        height: 200
        color: "#26282a"
        radius: 100
        opacity: isRunning == false ? 0.4 : 0
    }

}

//background: linear-gradient(to bottom, #5433FF, #20BDFF, #A5FECB);
/*##^##
Designer {
    D{i:5;anchors_height:200;anchors_width:200}D{i:9;anchors_height:100;anchors_width:100}
}
##^##*/
