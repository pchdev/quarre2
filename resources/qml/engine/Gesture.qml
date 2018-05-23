import QtQuick 2.0
import Ossia 1.0 as Ossia

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

    Ossia.Binding // -------------------------------------------------------------------- AVAILABLE
    {
        id:         parameter_available
        device:     ossia_net.client
        node:       ossia_net.format_user_parameter("/gestures/"+name+"/available")
        on:         available
    }


}
