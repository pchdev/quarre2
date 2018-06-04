import QtQuick 2.0
import QtQuick.Controls 2.3
import QtQuick.Controls.Styles 1.4

Slider
{
    id: control
    orientation: Qt.Vertical

    property real midValue: 0.5

    onPressedChanged: if ( !pressed ) value = midValue;

    background: Rectangle
    {
        anchors.fill: parent
        color: "darkgrey"
        border.color: "black"
        border.width: 1
    }

    handle: Rectangle
    {
        implicitWidth: control.width*2
        implicitHeight: implicitWidth
        radius: implicitHeight/2
        border.color: "black"
        border.width: 1
        anchors.horizontalCenter: parent.horizontalCenter
        y: control.visualPosition * ( control.height - height )
    }
}
