import QtQuick 2.0
import QtSensors 5.3
import Ossia 1.0 as Ossia
import "GesturesRoutine.js" as GesturesRoutine

Rectangle {

    property bool connected: false

    property bool whip_available: false
    property bool cover_available: false
    property bool twist_available: false
    property bool shake_available: false
    property bool pickup_available: false
    property bool freefall_available: false
    property bool turnover_available: false

    property bool whip_trigger: false
    property bool cover_trigger: false
    property bool twist_left_trigger: false
    property bool twist_right_trigger: false
    property bool shake_left_trigger: false
    property bool shake_right_trigger: false
    property bool shake_up_trigger: false
    property bool shake_down_trigger: false
    property bool pickup_trigger: false
    property bool freefall_trigger: false
    property bool turnover_trigger: false

    Text {
        id: gesture_label
        width: parent.width
        height: parent.height
        horizontalAlignment: Text.AlignHCenter
        y: parent.height*0.25
        font.family: font_lato_light.name
        font.pointSize: 50 * root.fontRatio
        textFormat: Text.PlainText
        color: "#ffffff"
        text: "no gesture"
        antialiasing: true
    }

    Text {
        id: gesture_description
        y: parent.height/2
        text: ""
        anchors.horizontalCenter: parent.horizontalCenter
        color: "#ffffff"
        height: parent.height/2
        width: parent.width * 0.9
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignTop
        font.pointSize: 14 * root.fontRatio
        textFormat: Text.PlainText
        wrapMode: Text.WordWrap
        font.family: font_lato_light.name
        antialiasing: true
    }

    SensorGesture {
        id: sensor_gesture
        enabled: false
        gestures: []
        onDetected: {

            ossia_net.oshdl.vibrate(200);
            console.log("detected!");
            console.log(gesture);

            if(gesture === "whip") whip_trigger = !whip_trigger;
            else if (gesture === "cover") cover_trigger = !cover_trigger;
            else if (gesture === "twistLeft") twist_left_trigger = !twist_left_trigger;
            else if (gesture === "twistRight") twist_right_trigger = !twist_right_trigger;
            else if (gesture === "shakeUp") shake_up_trigger = !shake_up_trigger;
            else if (gesture === "shakeDown") shake_down_trigger = !shake_down_trigger;
            else if (gesture === "shakeLeft") shake_left_trigger = !shake_left_trigger;
            else if (gesture === "shakeRight") shake_right_trigger = !shake_right_trigger;
            else if (gesture === "pickup") pickup_trigger = !pickup_trigger;
            else if (gesture === "turnover") turnover_trigger = !turnover_trigger;
            else if (gesture === "freefall") freefall_trigger = !freefall_trigger;
        }
    }

    // whip

    Ossia.Callback {
        id: gestures_whip_active
        node: "/user/" + ossia_net.slot + "/gestures/whip/active"
        onValueChanged: {
            GesturesRoutine.update(value, "QtSensors.whip", sensor_gesture.gestures);
            gesture_label.text = "whip"
            gesture_description.text = "raise your phone, and make a quick move downward"
        }
    }

    Ossia.Binding {
        id: gestures_whip_available
        node: "/user/" + ossia_net.slot + "/gestures/whip/available"
        on: whip_available
    }

    Ossia.Binding {
        id: gestures_whip_trigger
        node: "/user/" + ossia_net.slot + "/gestures/whip/trigger"
        on: whip_trigger
    }

    // ------------- cover

    Ossia.Callback {
        id: gestures_cover_active
        node: "/user/" + ossia_net.slot + "/gestures/cover/active"
        onValueChanged: {
            GesturesRoutine.update(value, "QtSensors.cover", sensor_gesture.gestures);
            gesture_label.text = "cover"
            gesture_description.text = "cover the screen of your phone with the palm of your hand"
        }
    }

    Ossia.Binding {
        id: gestures_cover_available
        node: "/user/" + ossia_net.slot + "/gestures/cover/available"
        on: cover_available
    }

    Ossia.Binding {
        id: gestures_cover_trigger
        node: "/user/" + ossia_net.slot + "/gestures/cover/trigger"
        on: cover_trigger
    }


    // --------------- pickup

    Ossia.Callback {
        id: gestures_pickup_active
        node: "/user/" + ossia_net.slot + "/gestures/pickup/active"
        onValueChanged: {
            GesturesRoutine.update(value, "QtSensors.pickup", sensor_gesture.gestures);
            gesture_label.text = "pickup"
            gesture_description.text = "put your phone flat on your hand or on a surface, raise it towards you"
        }
    }

    Ossia.Binding {
        id: gestures_pickup_available
        node: "/user/" + ossia_net.slot + "/gestures/pickup/available"
        on: pickup_available
    }

    Ossia.Binding {
        id: gestures_pickup_trigger
        node: "/user/" + ossia_net.slot + "/gestures/pickup/trigger"
        on: pickup_trigger
    }

    // --------------- freefall

    Ossia.Callback {
        id: gestures_freefall_active
        node: "/user/" + ossia_net.slot + "/gestures/freefall/active"
        onValueChanged: {
            GesturesRoutine.update(value, "QtSensors.freefall", sensor_gesture.gestures);
            gesture_label.text = "freefall"
            gesture_description.text = "let your phone drop from one hand to another, like you were juggling"
        }
    }

    Ossia.Binding {
        id: gestures_freefall_available
        node: "/user/" + ossia_net.slot + "/gestures/freefall/available"
        on: freefall_available
    }

    Ossia.Binding {
        id: gestures_freefall_trigger
        node: "/user/" + ossia_net.slot + "/gestures/freefall/trigger"
        on: freefall_trigger
    }

    // --------------- turnover

    Ossia.Callback {
        id: gestures_turnover_active
        node: "/user/" + ossia_net.slot + "/gestures/turnover/active"
        onValueChanged: {
            GesturesRoutine.update(value, "QtSensors.turnover", sensor_gesture.gestures);
            gesture_label.text = "turnover"
            gesture_description.text = "turn your phone flat downward, close to the palm of your hand"
        }
    }

    Ossia.Binding {
        id: gestures_turnover_available
        node: "/user/" + ossia_net.slot + "/gestures/turnover/available"
        on: turnover_available
    }

    Ossia.Binding {
        id: gestures_turnover_trigger
        node: "/user/" + ossia_net.slot + "/gestures/turnover/trigger"
        on: turnover_trigger
    }

    // --------------- twist

    Ossia.Callback {
        id: gestures_twist_active
        node: "/user/" + ossia_net.slot + "/gestures/twist/active"
        onValueChanged: {
            GesturesRoutine.update(value, "QtSensors.twist", sensor_gesture.gestures);
            gesture_label.text = "twist"
            gesture_description.text = "twist your phone on the left or on the right, then immediately get it back on flat position"
        }
    }

    Ossia.Binding {
        id: gestures_twist_available
        node: "/user/" + ossia_net.slot + "/gestures/twist/available"
        on: twist_available
    }

    Ossia.Binding {
        id: gestures_twist_left_trigger
        node: "/user/" + ossia_net.slot + "/gestures/twist/left/trigger"
        on: twist_left_trigger
    }

    Ossia.Binding {
        id: gestures_twist_right_trigger
        node: "/user/" + ossia_net.slot + "/gestures/twist/right/trigger"
        on: twist_right_trigger
    }

    // --------------- shake

    Ossia.Callback {
        id: gestures_shake_active
        node: "/user/" + ossia_net.slot + "/gestures/shake/active"
        onValueChanged: {
            GesturesRoutine.update(value, "QtSensors.shake", sensor_gesture.gestures);
            gesture_label.text = "shake"
            gesture_description.text = "shake your phone very firmly and quickly"
        }
    }

    Ossia.Binding {
        id: gestures_shake_available
        node: "/user/" + ossia_net.slot + "/gestures/shake/available"
        on: shake_available
    }

    Ossia.Binding {
        id: gestures_shake_left_trigger
        node: "/user/" + ossia_net.slot + "/gestures/shake/left/trigger"
        on: shake_left_trigger
    }

    Ossia.Binding {
        id: gestures_shake_right_trigger
        node: "/user/" + ossia_net.slot + "/gestures/shake/right/trigger"
        on: shake_right_trigger
    }
    Ossia.Binding {
        id: gestures_shake_up_trigger
        node: "/user/" + ossia_net.slot + "/gestures/shake/up/trigger"
        on: shake_up_trigger
    }
    Ossia.Binding {
        id: gestures_shake_down_trigger
        node: "/user/" + ossia_net.slot + "/gestures/shake/down/trigger"
        on: shake_down_trigger
    }

    onConnectedChanged: {
        var gestures = sensor_gesture.availableGestures
        for(var i = 0; i < gestures.length; ++i)
        {
            if(gestures[i]  === "QtSensors.whip") whip_available = true;
            else if(gestures[i] === "QtSensors.cover") cover_available = true;
            else if(gestures[i] === "QtSensors.twist") twist_available = true;
            else if(gestures[i] === "QtSensors.shake2") shake_available = true;
            else if (gestures[i] === "QtSensors.pickup") pickup_available = true;
            else if (gestures[i] === "QtSensors.freefall") freefall_available = true;
            else if (gestures[i] === "QtSensors.turnover") turnover_available = true;
        }
    }
}
