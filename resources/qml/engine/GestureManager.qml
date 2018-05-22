import QtQuick 2.0
import QtSensors 5.3
import Ossia 1.0 as Ossia

Item
{
    property bool connected: false
    property var gestures: [ "whip", "cover", "turnover", "shake" ]
    property alias backend: sensor_gesture

    SensorGesture { id: sensor_gesture }
    Repeater { id: gesture_array; model: gestures; Gesture { name: modelData }}

    onConnectedChanged:
    {
        for ( var i = 0; i < gestures.length; ++ i )
            gesture_array.itemAt(i).check_availability();
    }    
}
