import QtQuick 2.0
import QtQuick.Controls 2.12
import "../controls"

Item {
    id: root
    property var text: "value"
    property var clockend
    
    Rectangle {
        id: bg
        color: "#58a2d6"
        anchors.rightMargin: 0
        anchors.bottomMargin: 0
        anchors.leftMargin: 0
        anchors.topMargin: 0
        anchors.fill: parent

        Label {
            id: english
            color: "#ffffff"
            text: qsTr("English")
            anchors.top: parent.top
            anchors.topMargin: 46
            font.pointSize: 20
            font.italic: false
            font.weight: Font.DemiBold
            horizontalAlignment: Text.AlignHCenter
            anchors.left: parent.left
            anchors.leftMargin: 20
            anchors.right: parent.right
            anchors.rightMargin: 20
        }

        Label {
            id: chinese
            x: 0
            color: "#ffffff"
            text: qsTr("Chinese")
            anchors.top: english.bottom
            anchors.topMargin: 0
            font.pointSize: 20
            font.weight: Font.DemiBold
            anchors.leftMargin: 20
            anchors.right: parent.right
            horizontalAlignment: Text.AlignHCenter
            font.italic: false
            anchors.left: parent.left
            anchors.rightMargin: 20
        }


        Clock {
            id: clock
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            minText: clockSlider.value
            isRunning: false
            // isRunning: false
            onStartClock: {
                clockend.setClock (minText, secondText)
                if (isRunning == true)
                {
                    clockend.start ()
                }
                else
                {
                    clockend.pause ()
                }
            }
            Component.onCompleted: {
                clockend.getState ()
            }
        }

        ClockSlider {
            id: clockSlider
            height: 24
            anchors.top: clock.bottom
            anchors.topMargin: 40
            value: 25
            to: 100
            anchors.right: parent.right
            anchors.rightMargin: 100
            anchors.left: parent.left
            anchors.leftMargin: 100
            visible: !clock.isRunning
            onMoved: {
                clock.minText = value
                clock.secondText = "00"
            }
        }
    }
    Component.onCompleted: {
        clockend.getSentence ()
    }
    Connections {
        target: clockend
        function onPrintClock (minStr, secondStr) {
            clock.minText = minStr
            clock.secondText = secondStr
        }
        function onSetState (r) {
            if (r == 0)
                clock.isRunning = false
            else
                clock.isRunning = true
        }
        function onSetSentence (eng, ch) {
            english.text = eng
            chinese.text = ch
        }
    }

}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}D{i:2;anchors_x:285;anchors_y:46}D{i:3;anchors_x:285;anchors_y:92}
D{i:5;anchors_width:434;anchors_x:103;anchors_y:376}
}
##^##*/
