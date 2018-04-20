import QtQuick 2.0
import Ossia 1.0 as Ossia

Rectangle
{

    Text //------------------------------------------------ GESTURE_DESCRIPTION
    {
        id:         gesture_description
        y:          parent.height/2
        text:       ""
        color:      "#ffffff"
        height:     parent.height/2
        width:      parent.width * 0.9
        wrapMode:   Text.WordWrap

        horizontalAlignment:        Text.AlignHCenter
        verticalAlignment:          Text.AlignTop
        anchors.horizontalCenter:   parent.horizontalCenter
        font.pointSize:             14 * root.fontRatio
        font.family:                font_lato_light.name
        antialiasing:               true
    }

    Text //------------------------------------------------ GESTURE_LABEL
    {
        id:         gesture_label
        y:          parent.height*0.25
        width:      parent.width
        height:     parent.height
        color:      "#ffffff"
        text:       "no gesture"

        horizontalAlignment:    Text.AlignHCenter
        font.family:            font_lato_light.name
        font.pointSize:         40 * root.fontRatio
        textFormat:             Text.PlainText

        antialiasing: true
    }

    Ossia.Callback //----------------------------------------------------------------- TITLE
    {
        id:         ossia_gesture_title
        device:     ossia_net.client
        node:       "/user/" + ossia_net.slot + "/gestures/current/title"

        onValueChanged:
        {
            gesture_label.text = value;
            ossia_net.oshdl.vibrate(100);
        }
    }

    Ossia.Callback //----------------------------------------------------------------- DESCRIPTION
    {
        id:         ossia_gesture_description
        device:     ossia_net.client
        node:       "/user/" + ossia_net.slot + "/gestures/current/description"

        onValueChanged: gesture_description.text = value
    }

}
