import QtQuick 2.0
import QtSensors 5.3
import Ossia 1.0 as Ossia

Item {

    Timer {
        // sensor polling timer
        id: sensor_poller
        running: true
        interval: 50
        onTriggered: {
            console.log(accel_sensor.reading.x);
           // ossia_net.accelerometer_x.value = accel_sensor.reading.x;
            //ossia_net.accelerometer_y.value = accel_sensor.reading.y;
            //ossia_net.accelerometer_z.value = accel_sensor.reading.z;
        }
    }

    Accelerometer {
        id: accel_sensor
        active: true
    }


    ProximitySensor {
        active: false

    }

    IRProximitySensor {
        active: false

    }

    LightSensor {
        active: false

    }

    SensorGesture {
        id: sensor_gesture
        enabled: false
        gestures: []
        onDetected: {
            console.log(gesture);
        }
    }
}
