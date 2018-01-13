import QtQuick 2.0
import QtSensors 5.3
import Ossia 1.0 as Ossia

Item {

    property var used_gestures: ["whip", "cover"]

    SensorGesture {
        id: sensor_gesture
        enabled: false
        gestures: []
        onDetected: {
            console.log("detected");
            console.log(gesture);
            if(gesture === "whip")
                gestures_whip_trigger.trigger();
            else if (gesture === "cover")
                gestures_cover_trigger.trigger();
            else if (gesture === "twistLeft")
                gestures_twist_left_trigger.trigger();
            else if (gesture === "twistRight")
                gestures_twist_right_trigger.trigger();
        }
    }

    Ossia.Parameter {
        id: gestures_whip_active
        node: "/gestures/whip/active"
        valueType: Ossia.Type.Bool
        critical: true
        onValueChanged: {

            var idx = -1;
            for(var i=0; i < sensor_gesture.gestures.length; ++i)
            {
                if(sensor_gesture.gestures[i] === "QtSensors.whip");
                idx = i;
            }

            if(value && idx === -1)
            {
                sensor_gesture.gestures.push("QtSensors.whip");
                sensor_gesture.enabled = true;
            }

            else if(!value && idx >= 0)
                sensor_gesture.gestures.splice(idx, 1);

        }
    }

    Ossia.Parameter {
        id: gestures_whip_available
        node: "/gestures/whip/available"
        valueType: Ossia.Type.Bool
    }

    Ossia.Signal {
        id: gestures_whip_trigger
        node: "/gestures/whip/trigger"
        critical: true
    }

    // -------------

    Ossia.Parameter {
        id: gestures_cover_active
        node: "/gestures/cover/active"
        valueType: Ossia.Type.Bool
        critical: true
        onValueChanged: {

            var idx = -1;
            for(var i=0; i < sensor_gesture.gestures.length; ++i)
            {
                if(sensor_gesture.gestures[i] === "QtSensors.cover");
                idx = i;
            }

            if(value && idx === -1)
            {
                sensor_gesture.gestures.push("QtSensors.cover");
                sensor_gesture.enabled = true;
            }

            else if(!value && idx >= 0)
                sensor_gesture.gestures.splice(idx, 1);
        }
    }

    Ossia.Parameter {
        id: gestures_cover_available
        node: "/gestures/cover/available"
        valueType: Ossia.Type.Bool
    }

    Ossia.Signal {
        id: gestures_cover_trigger
        node: "/gestures/cover/trigger"
        critical: true
    }

    // --------------- twist

    Ossia.Parameter {
        id: gestures_twist_active
        node: "/gestures/twist/active"
        valueType: Ossia.Type.Bool
        critical: true
        onValueChanged: {

            var idx = -1;
            for(var i=0; i < sensor_gesture.gestures.length; ++i)
            {
                if(sensor_gesture.gestures[i] === "QtSensors.twist");
                idx = i;
            }

            if(value && idx === -1)
            {
                sensor_gesture.gestures.push("QtSensors.twist");
                sensor_gesture.enabled = true;
            }

            else if(!value && idx >= 0)
                sensor_gesture.gestures.splice(idx, 1);
        }
    }

    Ossia.Parameter {
        id: gestures_twist_available
        node: "/gestures/twist/available"
        valueType: Ossia.Type.Bool
    }

    Ossia.Signal {
        id: gestures_twist_left_trigger
        node: "/gestures/twist/left/trigger"
        critical: true
    }

    Ossia.Signal {
        id: gestures_twist_right_trigger
        node: "/gestures/twist/right/trigger"
        critical: true
    }

    Component.onCompleted: {
        var gestures = sensor_gesture.availableGestures
        for(var i = 0; i < gestures.length; ++i)
        {
            console.log(gestures[i])
            if(gestures[i] === "QtSensors.whip")
                gestures_whip_available.value = true;
            else if(gestures[i] === "QtSensors.cover")
                gestures_cover_available.value = true;
            else if(gestures[i] === "QtSensors.twist")
                gestures_twist_available.value = true;
        }
    }
}
