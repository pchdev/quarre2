import QtQuick 2.0
import Ossia 1.0 as Ossia
import Quarre 1.0

import QtQuick.Controls 1.2
import QtQuick.Dialogs 1.3

Item {

    property string     deviceName: "quarre-remote"
    property string     deviceAddress: ""

    property alias      oshdl:      os_hdl
    property alias      client:     ossia_client
    property alias      pads:       pads
    property alias      sliders:    sliders
    property int        slot: 0
    property bool       connected: false

    Ossia.OSCQueryClient //---------------------------------------------------------QUERY_CLIENT
    {
        id:         ossia_client

        onClientConnected:
        {
            console.log     ( ip )

            slot            = 0;
            connected       = true;

            upper_view.header.scene.color   = "white";
            upper_view.header.scene.text    = "registered";

            //sensors_playground.connected    = true;
            //gestures_playground.connected   = true;
            //ossia_client.recreate(ossia_net);
            ossia_client.remap(ossia_net);
            os_hdl.vibrate(100);
        }

        onClientDisconnected:
        {
            console.log         ( "client disconnected: ", ip );

            upper_view.header.scene.text    = "disconnected";
            upper_view.header.scene.color   = "red";

            connected           = false;
            os_hdl.hostAddr     = "ws://";
            os_hdl.vibrate      ( 500 );
        }
    }

    PlatformHdl //---------------------------------------------------------ZCONF+VIBRATOR
    {
        id: os_hdl

        Component.onCompleted:
        {
            os_hdl.register_zeroconf(deviceName, "_oscjson._tcp", ossia_client.localPort);
            deviceAddress = os_hdl.device_address();
        }

        // when quarre-server found
        onHostAddrChanged:
        {
            if(hostAddr === "ws://") return;
            console.log("connecting...");
            ossia_client.openOSCQueryClient(hostAddr, ossia_client.localPort)
        }
    }

    Ossia.Callback //---------------------------------------------------------AVAILABLE_SLOT
    {
        id:         user_ids
        device:     ossia_client
        value:      0
        node:       '/connections/ids'

        onValueChanged:
        {
            for ( var i = 0; i < value.length; ++i )
            {
                if ( typeof value[i] === "string" &&
                     value[i].startsWith(deviceAddress) )
                {
                    slot = value[i+1];
                    console.log(slot);
                    return;
                }
            }
        }
    }

    Ossia.Callback //---------------------------------------------------------SCENARIO_NAME
    {
        id:         scenario_name
        device:     ossia_client
        node:       "/scenario/name"

        onValueChanged:
        {
            if ( value == undefined || value == "" ) return;
            upper_view.header.scenario.text = value;
        }
    }            

    Ossia.Callback //---------------------------------------------------------SCENE_NAME
    {
        id:         scenario_scene_name
        device:     ossia_client
        node:       "/scenario/scene/name"

        onValueChanged:
        {
            if ( value == undefined || value == "" ) return;
            upper_view.header.scene.text = value;
        }
    }


    Ossia.Callback //---------------------------------------------------------SCENARIO_START
    {
        id:         scenario_start
        device:     ossia_client
        node:       "/scenario/start"

        onValueChanged:
        {
            if  ( value != 0 )
                upper_view.header.timer.start();
        }
    }

    Ossia.Callback //---------------------------------------------------------SCENARIO_STOP
    {
        // received whenever a problem has happened
        // argument: error code (int)
        id:         scenario_stop
        device:     ossia_client
        node:       "/scenario/stop"

        onValueChanged:
        {
            upper_view.header.timer.stop();
        }
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

        onValueChanged:
        {
            if ( value == 0 ) return;
            upper_view.header.count = 0;
            upper_view.header.timer.stop();
        }
    }

    Ossia.Callback //---------------------------------------------------------INTERACTION_INCOMING
    {
        id:         interactions_next_incoming
        device:     ossia_client
        node:       '/user/' + ossia_net.slot + '/interactions/next/incoming'

        onValueChanged:
        {
            console.log(value);
            interaction_manager.prepare_next(value);
        }
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

    Ossia.Callback //---------------------------------------------------------INTERACTION_FORCE
    {
        id:         interactions_reset
        device:     ossia_client
        node:       '/user/' + ossia_net.slot + '/interactions/reset'

        onValueChanged:
        {
            if ( value != 0 )
                interaction_manager.reset();
        }
    }

    Repeater //--------------------------------------------------------- PADS
    {
        id: pads
        model: 16

        Ossia.Binding
        {
            property bool active: false

            device:     ossia_client
            node:       "/user/" + ossia_net.slot + "/pads/" + index + "/active"
            on:         active
        }
    }

    Repeater //--------------------------------------------------------- SLIDERS
    {
        id: sliders
        model: 16

        Ossia.Binding
        {
            property real value: 0.5
            device: ossia_client
            node: "/user/" + ossia_net.slot + "/sliders/" + index + "/value"
            on: value
        }
    }

}
