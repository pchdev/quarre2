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

    property bool       connected:      false
    property bool       discovering:    false

    function format_user_parameter(str)
    {
        return '/user/' + slot + str
    }

    Ossia.OSCQueryClient //---------------------------------------------------------QUERY_CLIENT
    {
        id:         ossia_client

        onClientConnected:
        {
            console.log     ( ip )
            connected       = true;

            upper_view.header.scene.color   = "white";
            upper_view.header.scene.text    = "connected";
            quarre_application.state        = "IDLE";

            ossia_client.remap      ( ossia_net );
            os_hdl.vibrate          ( 100 );

            if ( discovering )
            {
                os_hdl.stop_discovery ( )
                discovering = false;
            }
        }

        onClientDisconnected:
        {
            upper_view.header.scene.text    = "disconnected";
            upper_view.header.scene.color   = "red";
            quarre_application.state        = "DISCONNECTED"

            connected           = false;
            os_hdl.vibrate      ( 500 );
            os_hdl.hostAddr     = "";

            os_hdl.start_discovery ( )
            discovering = true;
        }
    }

    Timer //----------------------------------------------------------------TIMEOUT_TIMER
    {
        id:         timeout;
        interval:   5000
        running:    false
        repeat:     false

        onTriggered:
        {
            if ( !connected )
            {
                os_hdl.hostAddr = "";
                os_hdl.start_discovery();
                discovering = true;
            }
        }
    }

    PlatformHdl //---------------------------------------------------------ZCONF+VIBRATOR
    {
        id: os_hdl

        function connect()
        {            
            os_hdl.register_zeroconf("bla", "bla", 3243);
            deviceAddress = os_hdl.device_address();
            var lksa = read_last_known_server_address();

            if ( lksa !== "" )
            {
                hostAddr = lksa;
                // try 5s, or else activate zeroconf;
                timeout.running = true;
            }

            else
            {
                start_discovery ( );
                discovering = true;
            }
        }

        // when quarre-server found -------------------------------------------------------
        onHostAddrChanged:
        {
            if ( hostAddr === "" ) return;
            ossia_client.openOSCQueryClient ( hostAddr, ossia_client.localPort )
            write_last_known_server_address ( hostAddr );
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
                     value[i].startsWith( deviceAddress ) )
                {
                    slot = value [ i+1 ];
                    ossia_client.remap  ( ossia_net )
                    console.log         ( "attributed slot: ", slot );

                    gesture_manager.connected   = true;
                    sensor_manager.connected    = true;
                    return;
                }
            }
        }
    }

    Ossia.Callback //---------------------------------------------------------SCENARIO_NAME
    {
        id:         scenario_name
        device:     ossia_client
        node:       "/common/scenario/name"

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
        node:       "/common/scenario/scene/name"

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
        node:       "/common/scenario/start"

        onSetValue_sig:
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
        node:       "/common/scenario/stop"

        onSetValue_sig:
        {
            upper_view.header.timer.stop();
        }
    }

    Ossia.Callback //---------------------------------------------------------SCENARIO_PAUSE
    {
        //          argument: reason for pause (int)
        id:         scenario_pause
        device:     ossia_client
        node:       "/common/scenario/pause"
    }

    Ossia.Callback //---------------------------------------------------------SCENARIO_END
    {
        id:         scenario_end
        device:     ossia_client
        node:       "/common/scenario/end"

        onSetValue_sig: upper_view.header.timer.stop();
    }    

    Ossia.Callback //---------------------------------------------------------SCENARIO_RESET
    {
        id:         scenario_reset
        device:     ossia_client
        node:       "/common/scenario/reset"

        onSetValue_sig:
        {
            upper_view.header.count = 0;
            upper_view.header.timer.stop();
        }
    }

    Ossia.Callback //---------------------------------------------------------INTERACTION_INCOMING
    {
        id:         interactions_next_incoming
        device:     ossia_client
        node:       get_user_base_address() + '/interactions/next/incoming'

        onValueChanged:
        {
            interaction_manager.prepare_next(value);
        }
    }

    Ossia.Callback //---------------------------------------------------------INTERACTION_BEGIN
    {
        id:         interactions_next_begin
        device:     ossia_client
        node:       get_user_base_address() + '/interactions/next/begin'

        onValueChanged:
        {
            console.log(value)
            interaction_manager.trigger_next(value);
        }
    }

    Ossia.Callback //---------------------------------------------------------INTERACTION_CANCEL
    {
        id:         interactions_next_cancel
        device:     ossia_client
        node:       get_user_base_address() + '/interactions/next/cancel'

        onSetValue_sig: interaction_manager.cancel_incoming();
    }

    Ossia.Binding //---------------------------------------------------------NEXT_COUNTDOWN
    {
        id:         interactions_next_countdown
        device:     ossia_client
        node:       get_user_base_address() + '/interactions/next/countdown'
        on:         upper_view.next.count
    }

    Ossia.Binding //---------------------------------------------------------CURRENT_COUNTDOWN
    {
        id:         interactions_current_countdown
        device:     ossia_client
        node:       get_user_base_address() + '/interactions/current/countdown'
        on:         upper_view.current.count
    }

    Ossia.Callback //---------------------------------------------------------INTERACTION_END
    {
        id:         interactions_current_end
        device:     ossia_client
        node:       get_user_base_address() + '/interactions/current/end'

        onSetValue_sig:
        {
            if ( quarre_application.status === "INCOMING")
                interaction_manager.cancel_incoming();

            interaction_manager.end_current();
        }
    }

    Ossia.Callback //---------------------------------------------------------INTERACTION_FORCE
    {
        id:         interactions_current_force
        device:     ossia_client
        node:       get_user_base_address() + '/interactions/current/force'

        onValueChanged: interaction_manager.force_current(value);
    }

    Ossia.Callback //---------------------------------------------------------INTERACTION_FORCE
    {
        id:         interactions_reset
        device:     ossia_client
        node:       get_user_base_address() + '/interactions/reset'

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
            node:       get_user_base_address() + "/pads/" + index + "/active"
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
            node: get_user_base_address() + "/sliders/" + index + "/value"
            on: value
        }
    }

}
