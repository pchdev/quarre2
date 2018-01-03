import QtQuick 2.0
import Ossia 1.0 as Ossia

Item {

    // OSSIA ----------------------------------------------------------------------------------------

    Ossia.OSCQueryServer {
        id: device
        oscPort: 1234
        wsPort: 5678
        name: "quarre-test-remote"
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
