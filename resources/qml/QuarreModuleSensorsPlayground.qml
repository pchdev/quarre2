import QtQuick 2.0
import QtSensors 5.3
import Ossia 1.0 as Ossia

Item {

    property bool accelerometer_available: false
    property var  accelerometer_data: Qt.vector3d(0.0, 0.0, 0.0)

    property bool rotation_available: false
    property var  rotation_data: Qt.vector3d(0.0, 0.0, 0.0)

    property bool proximity_available: false
    property bool proximity_data: false

    Timer {
        id: sensors_poll;
        running: false
        repeat: true
        interval: 50
        onTriggered: {

            if(sensors_accelerometer_active.value)
                accelerometer_data = Qt.vector3d(sensors_accelerometer.reading.x,
                                                 sensors_accelerometer.reading.y,
                                                 sensors_accelerometer.reading.z);
            if(sensors_rotation_active.value)
                rotation_data = Qt.vector3d(sensors_rotation.reading.x,
                                            sensors_rotation.reading.y,
                                            sensors_rotation.reading.z);

            if(sensors_proximity_active.value)
                proximity_data = sensors_proximity.reading.near;
        }
    }

    Accelerometer {
        id: sensors_accelerometer
        Component.onCompleted: accelerometer_available = connectedToBackend;
    }

    Ossia.Callback {
        id: sensors_accelerometer_active
        node: '/user/' + ossia_net.slot + '/sensors/accelerometer/active'
        onValueChanged: {
            sensors_accelerometer.active = value;
            if(value && !sensors_poll.running)
                sensors_poll.running = true;
        }
    }

    Ossia.Binding {
        id: sensors_accelerometer_available
        node: '/user/' + ossia_net.slot + '/sensors/accelerometer/available'
        on: accelerometer_available
    }

    Ossia.Binding {
        id: sensors_accelerometer_data
        node: '/user/' + ossia_net.slot + '/sensors/accelerometer/data'
        on: accelerometer_data;
    }

    RotationSensor {
        id: sensors_rotation
        active: false
    }

    Ossia.Callback {
        id: sensors_rotation_active
        node: '/user/' + ossia_net.slot + '/sensors/rotation/active'
        onValueChanged: {
            sensors_rotation.active = value;
            if(value && !sensors_poll.running)
                sensors_poll.running = true;
        }
    }

    Ossia.Binding {
        id: sensors_rotation_available
        node: '/user/' + ossia_net.slot + '/sensors/rotation/available'
        on: rotation_available
    }

    Ossia.Binding {
        id: sensors_rotation_data
        node: '/user/' + ossia_net.slot + '/sensors/rotation/data'
        on: rotation_data
    }

    ProximitySensor {
        id: sensors_proximity
        active: false
    }

    Ossia.Callback {
        id: sensors_proximity_active
        node: '/user/' + ossia_net.slot + '/sensors/proximity/active'
        onValueChanged: {
            sensors_proximity.active = value;
            if(value && !sensors_poll.running)
                sensors_poll.running = true;
        }
    }

    Ossia.Binding {
        id: sensors_proximity_available
        node: '/user/' + ossia_net.slot + '/sensors/proximity/available'
        on: proximity_available
    }

    Ossia.Binding {
        id: sensors_proximity_data
        node: '/user/' + ossia_net.slot + '/sensors/proximity/data'
        on: proximity_data
    }
}
