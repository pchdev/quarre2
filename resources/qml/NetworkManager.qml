import QtQuick 2.0
import Ossia 1.0 as Ossia
import Quarre 1.0

import QtQuick.Controls 1.2
import QtQuick.Dialogs 1.3

Item {

    property int        oscPort: 1234
    property int        wsPort: 5678
    property string     deviceName: "quarre-remote"
    property alias      oshdl: os_hdl
    property alias      client: ossia_client
    property int        slot: 0
    property bool       connected: false

    Ossia.OSCQueryClient //---------------------------------------------------------QUERY_CLIENT
    {
        id: ossia_client

        onClientConnected:
        {
            if(available_slot.value >= 0)
            {
                slot = available_slot.value;
                connected = true;
                upper_view.header.scene.text = "connected, id: " + slot;

                ossia_client.remap(sensors_playground);
                ossia_client.remap(gestures_playground);
                ossia_client.remap(touchspat);

                sensors_playground.connected    = true;
                gestures_playground.connected   = true;

                os_hdl.register_user_id(slot);
            }

            else upper_view.header.scene.text = "max users reached";

            os_hdl.vibrate(100);
        }

        onClientDisconnected:
        {
            connected           = false;
            os_hdl.hostAddr     = "ws://";
        }

    }

    PlatformHdl //---------------------------------------------------------ZCONF+VIBRATOR
    {
        id: os_hdl

        Component.onCompleted:
            os_hdl.register_zeroconf(deviceName, "_oscjson._tcp", wsPort);

        // when quarre-server found
        onHostAddrChanged: {

            if(hostAddr === "ws://") return;

            console.log("connecting...");
            console.log(hostAddr);

            ossia_client.openOSCQueryClient(hostAddr, oscPort);
            ossia_client.remap(ossia_net);
        }
    }

    Ossia.Binding //---------------------------------------------------------CLIENT_CONNECTED
    {

        id:         connected_binding
        device:     ossia_client

        node:       '/user/' + ossia_net.slot + '/connected'
        on:         ossia_net.connected
    }

    Ossia.Callback //---------------------------------------------------------AVAILABLE_SLOT
    {
        id:         available_slot
        device:     ossia_client
        node:       '/slots/available'
    }

    Ossia.Callback //---------------------------------------------------------SCENARIO_NAME
    {
        id:         scenario_name
        device:     ossia_client
        node:       "/scenario/name"

        onValueChanged: upper_view.header.scenario.text = value;
    }            

    Ossia.Callback //---------------------------------------------------------SCENE_NAME
    {
        id:         scenario_scene_name
        device:     ossia_client
        node:       "/scenario/scene/name"

        onValueChanged: upper_view.header.scene.text = value;
    }    

    Ossia.Callback //---------------------------------------------------------SCENARIO_START
    {
        id:         scenario_start
        device:     ossia_client
        node:       "/scenario/start"

        onValueChanged: upper_view.header.timer.start();
    }

    Ossia.Callback //---------------------------------------------------------SCENARIO_STOP
    {
        // received whenever a problem has happened
        // argument: error code (int)
        id:         scenario_stop
        device:     ossia_client
        node:       "/scenario/stop"
    }

    Ossia.Callback //---------------------------------------------------------SCENARIO_PAUSE
    {
        //          argument: reason for pause (int)
        id:         scenario_pause
        device:     ossia_client
        node:       "/scenario/pause"
    }

    Ossia.Callback //---------------------------------------------------------SCENARIO_END
    {
        id:         scenario_end
        device:     ossia_client
        node:       "/scenario/end"

        onValueChanged: upper_view.header.timer.stop();
    }    

    Ossia.Callback //---------------------------------------------------------SCENARIO_RESET
    {
        id:         scenario_reset
        device:     ossia_client
        node:       "/scenario/reset"

        onValueChanged: {
            upper_view.header.count = 0;
            upper_view.header.timer.stop();
        }
    }

    Ossia.Callback //---------------------------------------------------------INTERACTION_INCOMING
    {
        id:         interactions_next_incoming
        device:     ossia_client
        node:       '/user/' + ossia_net.slot + '/interactions/next/incoming'

        onValueChanged: interaction_manager.prepare_next(value);
    }

    Ossia.Callback //---------------------------------------------------------INTERACTION_BEGIN
    {
        id:         interactions_next_begin
        device:     ossia_client
        node:       '/user/' + ossia_net.slot + '/interactions/next/begin'

        onValueChanged: interaction_manager.trigger_next(value);
    }

    Ossia.Callback //---------------------------------------------------------INTERACTION_CANCEL
    {
        id:         interactions_next_cancel
        device:     ossia_client
        node:       '/user/' + ossia_net.slot + '/interactions/next/cancel'

        onValueChanged: interaction_manager.end_current();
    }

    Ossia.Callback //---------------------------------------------------------INTERACTION_END
    {
        id:         interactions_current_end
        device:     ossia_client
        node:       '/user/' + ossia_net.slot + '/interactions/current/end'

        onValueChanged: interaction_manager.end_current();
    }

    Ossia.Callback //---------------------------------------------------------INTERACTION_FORCE
    {
        id:         interactions_current_force
        device:     ossia_client
        node:       '/user/' + ossia_net.slot + '/interactions/force'

        onValueChanged: interaction_manager.force_current(value);
    }

}
