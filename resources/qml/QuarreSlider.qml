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

        background: Rectangle
        {
            implicitWidth: base.width*0.6
            implicitHeight: base.width*0.05
            radius: 10
            color: "gray"
            anchors.verticalCenter: parent.verticalCenter

        }

        handle: Rectangle
        {
            implicitWidth: base.width*0.1
            implicitHeight: implicitWidth
            radius: implicitHeight/2
            border.color: "black"
            border.width: 1
            x: control.leftPadding + control.visualPosition * (control.availableWidth - width)

            Text
            {
                id: slidertxt
                anchors.fill: parent
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                text: "" + slider_index
                font.pointSize: 30*root.fontRatio
                color: "black"
            }
        }
    }

    Ossia.Binding
    {
        device: ossia_net.client
        node: "/user/" + ossia_net.slot + "/sliders/" + slider_index + "/value"
        on: control.value
    }
}
