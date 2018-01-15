import QtQuick 2.0
import QtSensors 5.3
import Ossia 1.0 as Ossia
import "GesturesRoutine.js" as GesturesRoutine

Item {

    SensorGesture {
        id: sensor_gesture
        enabled: false
        gestures: []
        onDetected: {
            ossia_net.oshdl.vibrate(250);
            console.log("detected!");
            console.log(gesture);
            if(gesture === "whip")
                gestures_whip_trigger.trigger();
            else if (gesture === "cover")
                gestures_cover_trigger.trigger();
            else if (gesture === "twistLeft")
                gestures_twist_left_trigger.trigger();
            else if (gesture === "twistRight")
                gestures_twist_right_trigger.trigger();
            else if (gesture === "shakeUp")
                gestures_shake_up_trigger.trigger();
            else if (gesture === "shakeDown")
                gestures_shake_down_trigger.trigger();
            else if (gesture === "shakeLeft")
                gestures_shake_left_trigger.trigger();
            else if (gesture === "shakeRight")
                gestures_shake_right_trigger.trigger();
            else if (gesture === "pickup")
                gestures_pickup_trigger.trigger();
            else if (gesture === "turnover")
                gestures_turnover_trigger.trigger();
        }
    }

    Ossia.Parameter {
        id: gestures_whip_active
        node: "/gestures/whip/active"
        valueType: Ossia.Type.Bool
        critical: true
        onValueChanged: GesturesRoutine.update(value, "QtSensors.whip", sensor_gesture.gestures);
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
        onValueChanged: GesturesRoutine.update(value, "QtSensors.cover", sensor_gesture.gestures);
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

    // --------------- pickup

    Ossia.Parameter {
        id: gestures_pickup_active
        node: "/gestures/pickup/active"
        valueType: Ossia.Type.Bool
        critical: true
        onValueChanged: GesturesRoutine.update(value, "QtSensors.pickup", sensor_gesture.gestures);
    }

    Ossia.Parameter {
        id: gestures_pickup_available
        node: "/gestures/pickup/available"
        valueType: Ossia.Type.Bool
    }

    Ossia.Signal {
        id: gestures_pickup_trigger
        node: "/gestures/pickup/trigger"
        critical: true
    }

    // --------------- freefall

    Ossia.Parameter {
        id: gestures_freefall_active
        node: "/gestures/freefall/active"
        valueType: Ossia.Type.Bool
        critical: true
        onValueChanged: GesturesRoutine.update(value, "QtSensors.freefall", sensor_gesture.gestures);
    }

    Ossia.Parameter {
        id: gestures_freefall_available
        node: "/gestures/freefall/available"
        valueType: Ossia.Type.Bool
    }

    Ossia.Signal {
        id: gestures_freefall_trigger
        node: "/gestures/freefall/trigger"
        critical: true
    }

    // --------------- turnover

    Ossia.Parameter {
        id: gestures_turnover_active
        node: "/gestures/turnover/active"
        valueType: Ossia.Type.Bool
        critical: true
        onValueChanged: GesturesRoutine.update(value, "QtSensors.turnover", sensor_gesture.gestures);
    }

    Ossia.Parameter {
        id: gestures_turnover_available
        node: "/gestures/turnover/available"
        valueType: Ossia.Type.Bool
    }

    Ossia.Signal {
        id: gestures_turnover_trigger
        node: "/gestures/turnover/trigger"
        critical: true
    }

    // --------------- twist

    Ossia.Parameter {
        id: gestures_twist_active
        node: "/gestures/twist/active"
        valueType: Ossia.Type.Bool
        critical: true
        onValueChanged: GesturesRoutine.update(value, "QtSensors.twist", sensor_gesture.gestures);
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

    // --------------- shake

    Ossia.Parameter {
        id: gestures_shake_active
        node: "/gestures/shake/active"
        valueType: Ossia.Type.Bool
        critical: true
        onValueChanged: GesturesRoutine.update(value, "QtSensors.shake2", sensor_gesture.gestures);
    }

    Ossia.Parameter {
        id: gestures_shake_available
        node: "/gestures/shake/available"
        valueType: Ossia.Type.Bool
    }

    Ossia.Signal {
        id: gestures_shake_left_trigger
        node: "/gestures/shake/left/trigger"
        critical: true
    }

    Ossia.Signal {
        id: gestures_shake_right_trigger
        node: "/gestures/shake/right/trigger"
        critical: true
    }

    Ossia.Signal {
        id: gestures_shake_up_trigger
        node: "/gestures/shake/up/trigger"
        critical: true
    }

    Ossia.Signal {
        id: gestures_shake_down_trigger
        node: "/gestures/shake/down/trigger"
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
            else if(gestures[i] === "QtSensors.shake2")
                gestures_shake_available.value = true;
            else if (gestures[i] === "QtSensors.pickup")
                gestures_pickup_available.value = true;
            else if (gestures[i] === "QtSensors.freefall")
                gestures_freefall_available.value = true;
            else if (gestures[i] === "QtSensors.turnover")
                gestures_turnover_available.value = true;
        }
    }
}
