import QtQuick 2.0
import QtSensors 5.3
import Ossia 1.0 as Ossia

Rectangle {

    property bool       connected: false

    property bool       accelerometer_available: false
    property vector3d   accelerometer_xyz_data: Qt.vector3d(0.0, 0.0, 0.0)
    property real       accelerometer_x_data : 0.0
    property real       accelerometer_y_data : 0.0
    property real       accelerometer_z_data : 0.0

    property bool       rotation_available: false
    property vector3d   rotation_xyz_data: Qt.vector3d(0.0, 0.0, 0.0)
    property real       rotation_x_data : 0.0
    property real       rotation_y_data : 0.0
    property real       rotation_z_data : 0.0

    property bool       proximity_available: false
    property bool       proximity_close_data: false


    Timer //------------------------------------------------------------------------- SENSOR_POLL
    {
        id:         sensors_poll;
        running:    true
        repeat:     true
        interval:   50

        onTriggered:
        {
            // TO BE IMPROVED..
            if ( sensors_accelerometer_xyz_poll.value )
            {
                accelerometer_xyz_data = Qt.vector3d(
                            sensors_accelerometer.reading.x,
                            sensors_accelerometer.reading.y,
                            sensors_accelerometer.reading.z );
            }
            else if ( sensors_accelerometer_x_poll.value )
               accelerometer_x_data = sensors_accelerometer.reading.x;

            else if ( sensors_accelerometer_y_poll.value )
                accelerometer_y_data = sensors_accelerometer.reading.y;

            else if ( sensors_accelerometer_z_poll.value )
                accelerometer_z_data = sensors_accelerometer.reading.z;

            if ( sensors_rotation_xyz_poll.value )
            {
                rotation_xyz_data = Qt.vector3d(
                            sensors_rotation.reading.x,
                            sensors_rotation.reading.y,
                            sensors_rotation.reading.z );
            }
            else if ( sensors_rotation_x_poll.value )
                rotation_x_data = sensors_rotation.reading.x;

            else if ( sensors_rotation_y_poll.value )
                rotation_y_data = sensors_rotation.reading.y;

            else if ( sensors_rotation_z_poll.value )
                rotation_z_data = sensors_rotation.reading.z;

            if ( sensors_proximity_close_poll.value )
                proximity_close_data = sensors_proximity.reading.near;

            if ( !sensors_accelerometer.active &&
                    !sensors_rotation.active &&
                    !sensors_proximity.active )
                running = false;
        }
    }

    onConnectedChanged:
    {
        accelerometer_available     = sensors_accelerometer.connectedToBackend
        rotation_available          = sensors_rotation.connectedToBackend
        proximity_available         = sensors_proximity.connectedToBackend
    }

    Accelerometer //---------------------------------------------------------------- ACCELEROMETER
    {
        id: sensors_accelerometer
    }

    Ossia.Binding
    {
        id:         sensors_accelerometer_available
        device:     ossia_net.client
        node:       ossia_net.get_user_base_address() + '/sensors/accelerometers/available'
        on:         accelerometer_available
    }

    Ossia.Callback
    {
        id:         sensors_accelerometer_xyz_poll
        device:     ossia_net.client
        node:       ossia_net.get_user_base_address() + '/sensors/accelerometers/xyz/poll'

        onValueChanged:
        {
            // there can only be one data polling at the same time
            // meaning if you want to poll several axis simultaneously, you have to poll this one
            sensors_accelerometer.active = value;

            if ( value )
            {
                sensors_accelerometer_x_poll.value = false;
                sensors_accelerometer_y_poll.value = false;
                sensors_accelerometer_z_poll.value = false;

                if ( !sensors_poll.running )
                    sensors_poll.running = true;
            }
        }
    }

    Ossia.Callback
    {
        id:         sensors_accelerometer_x_poll
        device:     ossia_net.client
        node:       ossia_net.get_user_base_address() + '/sensors/accelerometers/x/poll'

        onValueChanged:
        {
            sensors_accelerometer.active = value;

            if ( value )
            {
                sensors_accelerometer_xyz_poll.value = false;
                sensors_accelerometer_y_poll.value = false;
                sensors_accelerometer_z_poll.value = false;

                if ( !sensors_poll.running )
                    sensors_poll.running = true;
            }
        }
    }

    Ossia.Callback
    {
        id:         sensors_accelerometer_y_poll
        device:     ossia_net.client
        node:       ossia_net.get_user_base_address() + '/sensors/accelerometers/y/poll'

        onValueChanged:
        {
            sensors_accelerometer.active = value;

            if ( value )
            {
                sensors_accelerometer_x_poll.value = false;
                sensors_accelerometer_xyz_poll.value = false;
                sensors_accelerometer_z_poll.value = false;

                if ( !sensors_poll.running )
                    sensors_poll.running = true;
            }
        }
    }

    Ossia.Callback
    {
        id:         sensors_accelerometer_z_poll
        device:     ossia_net.client
        node:       ossia_net.get_user_base_address() + '/sensors/accelerometers/z/poll'

        onValueChanged:
        {
            sensors_accelerometer.active = value;

            if ( value )
            {
                sensors_accelerometer_x_poll.value = false;
                sensors_accelerometer_y_poll.value = false;
                sensors_accelerometer_xyz_poll.value = false;

                if ( !sensors_poll.running )
                    sensors_poll.running = true;
            }
        }
    }

    Ossia.Binding
    {
        id:         sensors_accelerometer_xyz_data
        device:     ossia_net.client
        node:       ossia_net.get_user_base_address()+ '/sensors/accelerometers/xyz/data'

        on:         accelerometer_xyz_data;
    }

    Ossia.Binding
    {
        id:         sensors_accelerometer_x_data
        device:     ossia_net.client
        node:       ossia_net.get_user_base_address()+ '/sensors/accelerometers/x/data'

        on:         accelerometer_x_data;
    }

    Ossia.Binding
    {
        id:         sensors_accelerometer_y_data
        device:     ossia_net.client
        node:       ossia_net.get_user_base_address()+ '/sensors/accelerometers/y/data'

        on:         accelerometer_y_data;
    }

    Ossia.Binding
    {
        id:         sensors_accelerometer_z_data
        device:     ossia_net.client
        node:       ossia_net.get_user_base_address()+ '/sensors/accelerometers/z/data'

        on:         accelerometer_z_data;
    }

    RotationSensor //---------------------------------------------------------------- ROTATION
    {
        id:         sensors_rotation
        active:     true
    }

    Ossia.Binding
    {
        id:         sensors_rotation_available
        device:     ossia_net.client
        node:       ossia_net.get_user_base_address() + '/sensors/rotation/available'
        on:         rotation_available
    }

    Ossia.Callback
    {
        id:         sensors_rotation_xyz_poll
        device:     ossia_net.client
        node:       ossia_net.get_user_base_address() + '/sensors/rotation/xyz/poll'

        onValueChanged:
        {
            sensors_rotation.active = value;

            if ( value )
            {
                sensors_rotation_x_poll.value = false;
                sensors_rotation_y_poll.value = false;
                sensors_rotation_z_poll.value = false;

                if ( !sensors_poll.running )
                    sensors_poll.running = true;
            }
        }
    }

    Ossia.Callback
    {
        id:         sensors_rotation_x_poll
        device:     ossia_net.client
        node:       ossia_net.get_user_base_address() + '/sensors/rotation/x/poll'

        onValueChanged:
        {
            sensors_rotation.active = value;

            if ( value )
            {
                sensors_rotation_xyz_poll.value = false;
                sensors_rotation_y_poll.value = false;
                sensors_rotation_z_poll.value = false;

                if ( !sensors_poll.running )
                    sensors_poll.running = true;
            }
        }
    }

    Ossia.Callback
    {
        id:         sensors_rotation_y_poll
        device:     ossia_net.client
        node:       ossia_net.get_user_base_address() + '/sensors/rotation/y/poll'

        onValueChanged:
        {
            sensors_rotation.active = value;

            if ( value )
            {
                sensors_rotation_x_poll.value = false;
                sensors_rotation_xyz_poll.value = false;
                sensors_rotation_z_poll.value = false;

                if ( !sensors_poll.running )
                    sensors_poll.running = true;
            }
        }
    }

    Ossia.Callback
    {
        id:         sensors_rotation_z_poll
        device:     ossia_net.client
        node:       ossia_net.get_user_base_address() + '/sensors/rotation/z/poll'
        value:      true

        onValueChanged:
        {
            sensors_rotation.active = value;

            if ( value )
            {
                sensors_rotation_x_poll.value = false;
                sensors_rotation_y_poll.value = false;
                sensors_rotation_xyz_poll.value = false;

                if ( !sensors_poll.running )
                    sensors_poll.running = true;
            }
        }
    }

    Ossia.Binding
    {
        id:         sensors_rotation_xyz_data
        device:     ossia_net.client
        node:       ossia_net.get_user_base_address()+ '/sensors/rotation/xyz/data'

        on:         rotation_xyz_data;
    }

    Ossia.Binding
    {
        id:         sensors_rotation_x_data
        device:     ossia_net.client
        node:       ossia_net.get_user_base_address()+ '/sensors/rotation/x/data'

        on:         rotation_x_data;
    }

    Ossia.Binding
    {
        id:         sensors_rotation_y_data
        device:     ossia_net.client
        node:       ossia_net.get_user_base_address()+ '/sensors/rotation/y/data'

        on:         rotation_y_data;
    }

    Ossia.Binding
    {
        id:         sensors_rotation_z_data
        device:     ossia_net.client
        node:       ossia_net.get_user_base_address()+ '/sensors/rotation/z/data'

        on:         rotation_z_data;
    }

    ProximitySensor //---------------------------------------------------------------- PROXIMITY
    {
        id:         sensors_proximity
        active:     false
    }

    Ossia.Callback
    {
        id:         sensors_proximity_close_poll
        device:     ossia_net.client
        node:       ossia_net.get_user_base_address() + '/sensors/proximity/close/poll'

        onValueChanged:
        {
            sensors_proximity.active = value;
            if(value && !sensors_poll.running)
                sensors_poll.running = true;
        }
    }

    Ossia.Binding
    {
        id:         sensors_proximity_available
        device:     ossia_net.client
        node:       ossia_net.get_user_base_address() + '/sensors/proximity/available'

        on:         proximity_available
    }

    Ossia.Binding
    {
        id:         sensors_proximity_close_data
        device:     ossia_net.client
        node:       ossia_net.get_user_base_address() + '/sensors/proximity/close/data'

        on:         proximity_data
    }
}
