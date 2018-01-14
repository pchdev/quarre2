import QtQuick 2.0
import QtSensors 5.3
import Ossia 1.0 as Ossia

Item {

    Timer {
        id: sensors_poll;
        running: false
        repeat: true
        interval: 50
        onTriggered: {
            if(sensors_accelerometer.active)
                sensors_accelerometer_data.value = Qt.vector3d(
                            sensors_accelerometer.reading.x,
                            sensors_accelerometer.reading.y,
                            sensors_accelerometer.reading.z);
            if(sensors_rotation.active)
                sensors_rotation_data.value = Qt.vector3d(
                            sensors_rotation.reading.x,
                            sensors_rotation.reading.y,
                            sensors_rotation.reading.z);
        }
    }

    Accelerometer {
        id: sensors_accelerometer
        active: false
    }

    Ossia.Parameter {
        id: sensors_accelerometer_available
        node: "/sensors/accelerometer/available"
        valueType: Ossia.Type.Bool
        value: sensors_accelerometer.connectedToBackend
    }

    Ossia.Parameter {
        id: sensors_accelerometer_active
        node: "/sensors/accelerometer/active"
        valueType: Ossia.Type.Bool
        critical: true
        onValueChanged: {
            sensors_accelerometer.active = value;
            if(!sensors_poll.running)
                sensors_poll.running = true;
        }
    }

    Ossia.Parameter {
        id: sensors_accelerometer_data
        node: "/sensors/accelerometer/data"
        valueType: Ossia.Type.Vec3f
    }

    RotationSensor {
        id: sensors_rotation
        active: false
    }

    Ossia.Parameter {
        id: sensors_rotation_available
        node: "/sensors/rotation/available"
        valueType: Ossia.Type.Bool
        value: sensors_rotation.connectedToBackend
    }

    Ossia.Parameter {
        id: sensors_rotation_active
        node: "/sensors/rotation/active"
        critical: true
        valueType: Ossia.Type.Bool
        onValueChanged: {
            sensors_rotation.active = value;
            if(!sensors_poll.running)
                sensors_poll.running = true;
        }
    }

    Ossia.Parameter {
        id: sensors_rotation_data
        node: "/sensors/rotation/data"
        valueType: Ossia.Type.Vec3f
    }
}
