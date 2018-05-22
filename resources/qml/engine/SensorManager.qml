import QtQuick 2.0
import QtSensors 5.3
import Ossia 1.0 as Ossia
import Quarre 1.0 as Quarre

Rectangle {

    property bool connected:                    false
    property bool accelerometer_available:      false
    property bool rotation_available:           false
    property bool proximity_available:          false
    property bool microphone_available:         false

    property alias accelerometers: sensors_accelerometer
    property alias rotation: sensors_rotation
    property alias microphone: sensors_microphone
    property alias proximity: sensors_proximity

    onConnectedChanged:
    {
        accelerometer_available     = sensors_accelerometer.connectedToBackend
        rotation_available          = sensors_rotation.connectedToBackend
        proximity_available         = sensors_proximity.connectedToBackend
        microphone_available        = true;
    }

    Quarre.AudioHdl //-------------------------------------------------------------- MICROPHONE
    {
        id:         sensors_microphone
        active:     false
    }

    Ossia.Binding
    {
        id:         sensors_microphone_available
        device:     ossia_net.client
        node:       ossia_net.format_user_parameter('/sensors/microphone/available')

        on:         microphone_available
    }

    Accelerometer //---------------------------------------------------------------- ACCELEROMETER
    {
        id:         sensors_accelerometer
        active:     false
    }

    Ossia.Binding
    {
        id:         sensors_accelerometer_available
        device:     ossia_net.client
        node:       ossia_net.format_user_parameter('/sensors/accelerometers/available')
        on:         accelerometer_available
    }


    RotationSensor //---------------------------------------------------------------- ROTATION
    {
        id:         sensors_rotation
        active:     false
    }

    Ossia.Binding
    {
        id:         sensors_rotation_available
        device:     ossia_net.client
        node:       ossia_net.format_user_parameter('/sensors/rotation/available')
        on:         rotation_available
    }

    ProximitySensor //---------------------------------------------------------------- PROXIMITY
    {
        id:         sensors_proximity
        active:     false
    }

    Ossia.Binding
    {
        id:         sensors_proximity_available
        device:     ossia_net.client
        node:       ossia_net.format_user_parameter('/sensors/proximity/available')

        on:         proximity_available
    }
}
