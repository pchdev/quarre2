import QtQuick 2.0
import WPN114 1.0 as WPN114

Item
{
    property bool available:    false
    property string name:       ""

    function check_availability()
    {
        var gestures    = sensor_gesture.availableGestures;
        var index       = gestures.indexOf("QtSensors." + name);

        if ( index >= 0 ) available = true;
    }

    WPN114.Node on available { path: "/gestures"+name+"/available" }
}
