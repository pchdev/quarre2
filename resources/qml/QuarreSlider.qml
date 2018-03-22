import QtQuick 2.0
import QtQuick.Controls 2.3
import QtQuick.Controls.Styles 1.4
import Ossia 1.0 as Ossia

Item
{
    property int slider_index;
    id: base

    Slider
    {
        id: control
        value: ossia_net.sliders.itemAt(slider_index).value

        background: Rectangle
        {
            implicitWidth: base.width
            implicitHeight: base.height*0.9
            radius: 10
            color: "gray"
            anchors.verticalCenter: parent.verticalCenter
        }

        handle: Rectangle
        {
            implicitWidth: base.height
            implicitHeight: implicitWidth
            radius: implicitHeight/2
            border.color: "black"
            border.width: 1
            x: control.leftPadding + control.visualPosition * (control.availableWidth - width)
        }

        onValueChanged:
            ossia_net.sliders.itemAt(slider_index).value = value;
    }
}
