import QtQuick 2.0
import Ossia 1.0 as Ossia

Rectangle
{
    id: pad

    property string active_color:           "white"
    property string inactive_color:         "#294a51"
    property bool pressed: false

    MouseArea
    {
        anchors.fill: parent
        onPressed:
        {
            pad.color = active_color;
            pad.pressed = true;
        }

        onReleased:
        {
            pad.color = inactive_color;
            pad.pressed = false;
        }
    }
}
