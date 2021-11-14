//import QtQuick 2.12
//import QtQuick.Controls 2.12

//CheckBox {
//    id: circleCheckBox

//}

import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.2


Rectangle {

    property string str:""
    property int langrageSize:25
    property alias gl_checked: ll.checked
    property alias gl_exclusiveGroup: ll.exclusiveGroup
    property alias gl_checkedState:ll.checkedState//0未选中，2选中
    signal gl_clicked;


    width: (ll.width + str.length)
    height: langrageSize

    CheckBox
    {
        id:ll
        style:CheckBoxStyle{
            indicator:Rectangle{
                id:functChose
                implicitWidth: langrageSize
                implicitHeight: langrageSize
                radius: langrageSize
                border.color: control.activeFocus ? "darkblue" : "gray"
                border.width: 2
                Rectangle {
                    visible: control.checked
                    color: "#555"
                    border.color: "#333"
                    radius: langrageSize
                    anchors.margins: 4
                    anchors.fill: parent
                }
            }
            label: Label{
                id:string
                text:str
                font.pixelSize: langrageSize-5
            }
        }
    }
}
/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
