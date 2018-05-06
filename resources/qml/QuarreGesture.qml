import QtQuick 2.0
import Ossia 1.0 as Ossia
import "GesturesRoutine.js" as GesturesRoutine

Item
{
    property bool available:    false
    property bool active:       false
    property bool trigger:      false
    property string name:       ""

    function check_availability()
    {
        var gestures    = sensor_gesture.availableGestures;
        var index       = gestures.indexOf("QtSensors." + name);

        if ( index >= 0 ) available = true;
    }

    function recognized()
    {
        trigger = !trigger;
    }

    Ossia.Callback // -------------------------------------------------------------------- ACTIVE
    {
        id:         parameter_active
        device:     ossia_net.client
        node:       ossia_net.get_user_base_address() +"/gestures/"+name+"/poll"

        onValueChanged:
        {
            GesturesRoutine.update(value, "QtSensors." + name, sensor_gesture.gestures);
            if ( value ) module_gesture.target = name;
        }
    }

    Ossia.Binding // -------------------------------------------------------------------- AVAILABLE
    {
        id:         parameter_available
        device:     ossia_net.client
        node:       ossia_net.get_user_base_address() + "/gestures/"+name+"/available"

        on:         available
    }

    Ossia.Binding // -------------------------------------------------------------------- TRIGGER
    {
        id:         parameter_trigger
        device:     ossia_net.client
        node:       ossia_net.get_user_base_address() + "/gestures/"+name+"/trigger"

        on:         trigger
    }


}
