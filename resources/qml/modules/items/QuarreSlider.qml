import QtQuick 2.0
import QtQuick.Controls 2.3
import QtQuick.Controls.Styles 1.4
import Ossia 1.0 as Ossia

Item
{
    property int slider_index;
    property real min: 0.0
    property real max: 1.0
    property var target
    property string name: ""
    property real value: 0.0
    property alias ctl: control

    id: base
    width: parent.width * 0.65
    height: parent.height * 0.1
    anchors.horizontalCenter: parent.horizontalCenter

    Slider
    {
        id: control
        from: min; to: max;
        value: base.value

        background: Rectangle
        {
            implicitWidth: base.width
            implicitHeight: base.height*0.8
            radius: 10
            color: "gray"
            anchors.verticalCenter: parent.verticalCenter
            opacity: 0.8
        }

        handle: Rectangle
        {
            implicitWidth: base.height*1.1
            implicitHeight: implicitWidth
            radius: implicitHeight/2
            border.color: "black"
            border.width: 1
            x: control.leftPadding + control.visualPosition * (control.availableWidth - width)
        }

        onValueChanged: base.value = value;
    }
}
