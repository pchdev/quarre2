import QtQuick 2.0
import Ossia 1.0 as Ossia
import io.quarre.org 1.0

Item {
    property int        oscPort: 1234
    property int        wsPort: 5678
    property string     deviceName: "quarre-remote"
    property alias      oshdl: os_hdl
    property int        slot: 0
    property bool       connected: false

    PlatformHdl {

        id: os_hdl

        Component.onCompleted: {
            os_hdl.vibrate(100);
            os_hdl.register_zeroconf(deviceName, "_oscjson._tcp", wsPort);
        }

        // when quarre-server found
        onHostAddrChanged: {

            if(hostAddr === "ws://") return;

            console.log("connecting...");
            console.log(hostAddr);

            Ossia.SingleDevice.openOSCQueryClient(hostAddr, oscPort);
            Ossia.SingleDevice.remap(ossia_net);

            // note: this should be handled by oscquery server
            if(available_slot.value >= 0)
            {
                console.log("attributing slot");
                slot = available_slot.value;
                connected = true;
                upper_view.header.scene.text = "connected, id: " + slot;
                Ossia.SingleDevice.remap(sensors_playground);
                Ossia.SingleDevice.remap(gestures_playground);
                sensors_playground.connected = true;
                gestures_playground.connected = true;
            }

            else
            {
                upper_view.header.scene.text = "max users reached";
            }

            os_hdl.vibrate(100);
        }
    }    

    Ossia.Binding {
        id: connected_binding
        node: '/user/' + ossia_net.slot + '/connected'
        on: ossia_net.connected
    }

    Ossia.Callback {
        id: server_quit
        node: '/server/quit'
        onValueChanged: {
            if(value !== 0)
            {
                console.log("server has quit");
                upper_view.header.scene.text = "disconnected";
                os_hdl.hostAddr = "ws://"
            }
        }
    }

    Ossia.Callback {
        id: users_max
        node: '/slots/max'
    }

    Ossia.Callback {
        id: available_slot
        node: '/slots/available'
    }

    Ossia.Binding {
        id: available_slot_send_back
        node: '/slots/available'
        on: slot_plus_one
    }

    Ossia.Callback {
        id: scenario_name
        node: "/scenario/name"
        onValueChanged: upper_view.header.scenario.text = value;
    }            

    Ossia.Callback {
        id: scenario_scene_name
        node: "/scenario/scene/name"
        onValueChanged: upper_view.header.scene.text = value;
    }    

    Ossia.Callback {
        id: scenario_start
        node: "/scenario/start"
        onValueChanged: upper_view.header.timer.start();
    }

    Ossia.Callback {
        // received whenever a problem has happened
        // argument: error code (int)
        id: scenario_stop
        node: "/scenario/stop"
    }

    Ossia.Callback {
        // argument: reason for pause (int)
        id: scenario_pause
        node: "/scenario/pause"
    }

    Ossia.Callback {
        id: scenario_end
        node: "/scenario/end"
        onValueChanged: upper_view.header.timer.stop();
    }    

    Ossia.Callback {
        id: scenario_reset
        node: "/scenario/reset"
        onValueChanged: {
            upper_view.header.count = 0;
            upper_view.header.timer.stop();
        }
    }

    Ossia.Callback {
        id: interactions_next_incoming
        node: '/user/' + ossia_net.slot + '/interactions/next/incoming'
        // arguments are: x (interaction_index) y (interaction_length) z (countdown)
        onValueChanged: interaction_manager.prepare_next(value);
    }

    Ossia.Callback {
        id: interactions_next_begin
        node: '/user/' + ossia_net.slot + '/interactions/next/begin'
        onValueChanged: interaction_manager.trigger_next(value);
    }

    Ossia.Callback {
        id: interactions_next_cancel
        node: '/user/' + ossia_net.slot + '/interactions/next/cancel'
        onValueChanged: interaction_manager.end_current();
    }

    Ossia.Callback {
        id: interactions_current_end
        node: '/user/' + ossia_net.slot + '/interactions/current/end'
        onValueChanged: interaction_manager.end_current();
    }

    Ossia.Callback {
        id: interactions_current_force
        node: '/user/' + ossia_net.slot + '/interactions/current/force'
        onValueChanged: interaction_manager.force_current(value);
    }

}
