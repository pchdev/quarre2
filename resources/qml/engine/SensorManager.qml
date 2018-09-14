import QtQuick 2.0
import QtSensors 5.3
import Quarre 1.0 as Quarre
import WPN114 1.0 as WPN114

Rectangle
{
    property bool connected:                    false
    property bool accelerometers_available:      false
    property bool rotation_available:           false
    property bool proximity_available:          false
    property bool microphone_available:         false

    property alias accelerometers: sensors_accelerometers
    property alias rotation: sensors_rotation
    property alias microphone: sensors_microphone
    property alias proximity: sensors_proximity

    WPN114.Node on accelerometers_available { path: "/sensors/accelerometers/available" }
    WPN114.Node on rotation_available { path: "/sensors/rotation/available" }
    WPN114.Node on proximity_available { path: "/sensors/proximity/available" }
    WPN114.Node on microphone { path: "/sensors/microphone/available" }

    onConnectedChanged:
    {
        accelerometers_available     = sensors_accelerometers.connectedToBackend
        rotation_available          = sensors_rotation.connectedToBackend
        proximity_available         = sensors_proximity.connectedToBackend
        microphone_available        = true;
    }

    Quarre.AudioHdl //-------------------------------------------------------------- MICROPHONE
    {
        id:         sensors_microphone
        active:     false
    }    

    Accelerometer //---------------------------------------------------------------- ACCELEROMETER
    {
        id:         sensors_accelerometers
        active:     false
    }

    RotationSensor //---------------------------------------------------------------- ROTATION
    {
        id:         sensors_rotation
        active:     false
    }

    ProximitySensor //---------------------------------------------------------------- PROXIMITY
    {
        id:         sensors_proximity
        active:     false
    }
}
