import QtQuick 2.0
import Ossia 1.0 as Ossia

Rectangle
{
    id: pad

    property int pad_index;
    property bool active: false

    property string active_color:           "white"
    property string inactive_color:         "#294a51"

    property string active_txt_color:       "black"
    property string inactive_txt_color:     "white"

    color: inactive_color

    Text
    {
        id: padtxt
        anchors.fill: parent
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        text: "" + pad_index
        font.pointSize: 30*root.fontRatio
        color: inactive_txt_color

        MouseArea
        {
            anchors.fill: parent
            onClicked:
            {
                if ( pad.active )
                {
                    padtxt.color    = inactive_txt_color;
                    pad.color       = inactive_color;
                    pad.active      = false;
                }
                else
                {
                    padtxt.color    = active_txt_color;
                    pad.color       = active_color;
                    pad.active      = true;
                }

                ossia_net.pads.itemAt(pad_index).active = pad.active;
            }
        }
    }
}
