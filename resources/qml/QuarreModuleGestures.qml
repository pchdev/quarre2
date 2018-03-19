import QtQuick 2.0
import QtSensors 5.3
import Ossia 1.0 as Ossia

import "GesturesRoutine.js" as GesturesRoutine

Rectangle {

    property bool connected: false

    onConnectedChanged:
    {
        for ( var i = 0; i < gesture_list_addresses.length; ++i )
            gestures.itemAt(i).check_availability();
    }

    property var gesture_list_addresses: [
        "whip",
        "cover",
        "twist",
        "twist/left",
        "twist/right",
        "shake",
        "shake/up",
        "shake/down",
        "shake/left",
        "shake/right",
        "pickup",
        "freefall",
        "turnover",
        "swipe"
    ]

    property var gesture_list_qt: [
        "whip",
        "cover",
        "twist",
        "twistLeft",
        "twistRight",
        "shake",
        "shakeUp",
        "shakeDown",
        "shakeLeft",
        "shakeRight",
        "pickup",
        "freefall",
        "turnover",
        "swipe"
    ]

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

    SensorGesture //------------------------------------------------ SENSOR_BACKEND
    {
        id:             sensor_gesture
        enabled:        false
        gestures:       []

        onDetected:
        {
            console.log     ( "detected!" );
            console.log     ( gesture );

            for (var i = 0; i < gesture_list_qt.length; ++i)
                if ( gesture === gesture_list_qt[i] )
                    gestures.itemAt(i).recognized();

            ossia_net.oshdl.vibrate( 200 );

        }
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

    Repeater //----------------------------------------------------------------------- GESTURES
    {
        id:     gestures;
        model:  gesture_list_addresses

        QuarreGesture { name: model }
    }
}
