import QtQuick 2.0
import QtSensors 5.3
import Ossia 1.0 as Ossia

import "GesturesRoutine.js" as GesturesRoutine

Item {

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

    SensorGesture //------------------------------------------------ SENSOR_BACKEND
    {
        id:             sensor_gesture
        enabled:        false
        gestures:       []

        onDetected:
        {
            console.log ( "gesture detected:", gesture );

            for (var i = 0; i < gesture_list_qt.length; ++i)
                if ( gesture === gesture_list_qt[i] )
                    gestures.itemAt(i).recognized();

            ossia_net.oshdl.vibrate( 200 );
        }
    }

    Repeater //----------------------------------------------------------------------- GESTURES
    {
        id:     gestures;
        model:  gesture_list_addresses

        QuarreGesture { name: modelData }
    }
}
