import QtQuick 2.0
import Ossia 1.0 as Ossia

Rectangle
{
    id: pad

    property string active_color:           "white"
    property string inactive_color:         "#294a51"
    property bool pressed: false
    property int index: 0

    function push()
    {
        pad.color = active_color;
    }

    function release()
    {
        pad.color = inactive_color;
    }

    MouseArea
    {
        anchors.fill: parent
        onPressed:
        {
            pad.pressed = true;
            markhor_pads.pressed(index, false);
        }

        onReleased:
        {
            markhor_pads.pressed(index, false);
            pad.pressed = false;
        }
    }
}
