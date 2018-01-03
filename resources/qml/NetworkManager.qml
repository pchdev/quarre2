import QtQuick 2.0
import Ossia 1.0 as Ossia

Item {
    property int oscPort: 1234
    property int wsPort: 5678
    property string deviceName: "quarre-remote"

    Ossia.OSCQueryServer {
        id: device
        oscPort: oscPort
        wsPort: wsPort
        name: deviceName
    }

    Ossia.Parameter {
        id: scenario_start
        node: "/scenario/start"
        critical: true
        valueType: Ossia.Type.Impulse
    }

    Ossia.Parameter {
        // received whenever a problem has happened
        // argument: error code (int)
        id: scenario_stop
        node: "/scenario/stop"
        critical: true
        valueType: Ossia.Type.Integer
    }

    Ossia.Parameter {
        // argument: reason for pause (int)
        id: scenario_pause
        node: "/scenario/pause"
        critical: true
        valueType: Ossia.Type.Integer
    }

    Ossia.Parameter {
        id: scenario_end
        node: "/scenario/end"
        critical: true
        valueType: Ossia.Type.Impulse
    }

    Ossia.Parameter {
        id: interactions_next_incoming
        node: "/interactions/next/incoming"
        critical: true
        valueType: Ossia.Type.Vec3f
    }

    Ossia.Parameter {
        id: interactions_next_begin
        node: "/interactions/next/begin"
        critical: true
        valueType: Ossia.Type.Integer
    }

    Ossia.Parameter {
        id: interactions_next_cancel
        node: "/interactions/next/cancel"
        critical: true
        valueType: Ossia.Type.Integer
    }

    Ossia.Parameter {
        id: interactions_current_end
        node: "/interactions/current/end"
        critical: true
        valueType: Ossia.Type.Integer
    }

    Component.onCompleted: device.recreate(root)

}
