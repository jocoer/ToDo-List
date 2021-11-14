import QtQuick 2.0
import QtQuick.Controls 2.15

Item {
    Rectangle {
        id: bg
        color: "#f17979"
        anchors.fill: parent

        Label {
            id: label
            x: 304
            y: 196
            text: qsTr("Settings Page")
            font.pointSize: 24
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }

}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
