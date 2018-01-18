import QtQuick 2.0
import Ossia 1.0 as Ossia
import io.quarre.org 1.0

Item {
    property int        oscPort: 1234
    property int        wsPort: 5678
    property string     deviceName: "quarre-remote"
    property alias      oshdl: os_hdl

    PlatformHdl {
        id: os_hdl
        Component.onCompleted: {
            os_hdl.vibrate(100);
            os_hdl.register_zeroconf(deviceName, "_oscjson._tcp", wsPort);
        }

        // when quarre-server found
        onHostAddrChanged: {
            console.log("connecting...");
            Ossia.SingleDevice.openOSCQueryClient(hostAddr, 5678);
            Ossia.SingleDevice.recreate(ossia_net);
        }
    }

    Ossia.Parameter {
        id: scenario_name
        node: "/scenario/name"
        onValueChanged: {
            upper_view.header.scenario.text = value;
        }
    }            

    Ossia.Parameter {
        id: scenario_scene_name
        node: "/scenario/scene/name"
        onValueChanged: {
            upper_view.header.scene.text = value;
        }
    }

    Ossia.Signal {
        id: scenario_start
        node: "/scenario/start"
        onTriggered: upper_view.header.timer.start();
    }

    Ossia.Parameter {
        // received whenever a problem has happened
        // argument: error code (int)
        id: scenario_stop
        node: "/scenario/stop"
    }

    Ossia.Parameter {
        // argument: reason for pause (int)
        id: scenario_pause
        node: "/scenario/pause"
    }

    Ossia.Signal {
        id: scenario_end
        node: "/scenario/end"
        onTriggered: upper_view.header.timer.stop();
    }    

    Ossia.Signal {
        id: scenario_reset
        node: "/scenario/reset"
        onTriggered: {
            upper_view.header.count = 0;
            upper_view.header.timer.stop();
        }
    }

    Ossia.Parameter {
        id: interactions_next_incoming
        node: "/interactions/next/incoming"
        // arguments are: x (interaction_index) y (interaction_length) z (countdown)
        onValueChanged: interaction_manager.prepare_next(value);
    }

    Ossia.Parameter {
        id: interactions_next_begin
        node: "/interactions/next/begin"
        onValueChanged: interaction_manager.trigger_next(value);
    }

    Ossia.Parameter {
        id: interactions_next_cancel
        node: "/interactions/next/cancel"
        onValueChanged: interaction_manager.end_current();
    }

    Ossia.Parameter {
        id: interactions_current_end
        node: "/interactions/current/end"
        onValueChanged: interaction_manager.end_current();
    }

    Ossia.Parameter {
        id: interactions_current_force
        node: "/interactions/current/force"
        onValueChanged: interaction_manager.force_current(value);
    }

    Component.onCompleted: {

    }

}
