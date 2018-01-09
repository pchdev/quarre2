import QtQuick 2.0
import Ossia 1.0 as Ossia

Item {
    property int oscPort: 1234
    property int wsPort: 5678
    property string deviceName: "quarre-remote"

   /* Ossia.OSCQueryServer {
        id: device
        oscPort: oscPort
        wsPort: wsPort
        name: deviceName
    }*/

    Ossia.Parameter {
        id: scenario_name
        node: "/scenario/name"
        critical: true
        valueType: Ossia.Type.String
        onValueChanged: {
            upper_view.header.scenario.text = value;
        }
    }

    Ossia.Parameter {
        id: scenario_scene_name
        node: "/scenario/scene/name"
        critical: true
        valueType: Ossia.Type.String
        onValueChanged: {
            upper_view.header.scene.text = value;
        }
    }

    Ossia.Signal {
        id: scenario_start
        node: "/scenario/start"
        critical: true
        onTriggered: upper_view.header.timer.start();
    }

    Ossia.Parameter {
        // received whenever a problem has happened
        // argument: error code (int)
        id: scenario_stop
        node: "/scenario/stop"
        critical: true
        valueType: Ossia.Type.Int
    }

    Ossia.Parameter {
        // argument: reason for pause (int)
        id: scenario_pause
        node: "/scenario/pause"
        critical: true
        valueType: Ossia.Type.Int
    }

    Ossia.Signal {
        id: scenario_end
        node: "/scenario/end"
        critical: true
        onTriggered: {
            upper_view.header.timer.stop();
        }
    }

    Ossia.Signal {
        id: scenario_reset
        node: "/scenario/reset"
        critical: true
        onTriggered: {
            upper_view.header.count = 0;
            upper_view.header.timer.stop();
        }
    }

    Ossia.Parameter {
        id: interactions_next_incoming
        node: "/interactions/next/incoming"
        critical: true
        // arguments are: x (interaction_index) y (interaction_length) z (countdown)
        valueType: Ossia.Type.Vec3f
        onValueChanged: {

            if(quarre_application.state === "IDLE")
            {
                quarre_application.state = "INCOMING_INTERACTION";

            }

            else if(quarre_application.state === "ACTIVE_INTERACTION")
            {
                quarre_application.state = "ACTIVE_AND_INCOMING_INTERACTION";
            }

            upper_view.next.count = value.z;
            upper_view.next.timer.start();
        }
    }

    Ossia.Parameter {
        id: interactions_next_begin
        node: "/interactions/next/begin"
        critical: true
        valueType: Ossia.Type.Vec2f

        onValueChanged: {

            if(     quarre_application.state === "IDLE" ||
                    quarre_application.state === "INCOMING_INTERACTION")
            {
                quarre_application.state = "ACTIVE_INTERACTION";
                upper_view.count = value.y;
                upper_view.current.timer.start();
                lower_view_stack.currentIndex = value.x;
            }
        }
    }

    Ossia.Parameter {
        id: interactions_next_cancel
        node: "/interactions/next/cancel"
        critical: true
        valueType: Ossia.Type.Int

        onValueChanged: {

            if( quarre_application.state === "INCOMING_INTERACTION")
            {
                quarre_application.state = "IDLE";
                upper_view.next.count = 0;
                upper_view.next.timer.stop;
            }
            else if ( quarre_application.state === "ACTIVE_AND_INCOMING_INTERACTION")
            {
                quarre_application.state = "ACTIVE_INTERACTION";
                upper_view.next.count = 0;
                upper_view.next.timer.stop();
            }

        }
    }

    Ossia.Parameter {
        id: interactions_current_end
        node: "/interactions/current/end"
        critical: true
        valueType: Ossia.Type.Int

        onValueChanged: {

            if(quarre_application.state === "ACTIVE_INTERACTION")
            {
                quarre_application.state = "IDLE";
                upper_view.current.count = 0;
                upper_view.current.timer.stop();
            }
            else if (quarre_application.state === "ACTIVE_AND_INCOMING_INTERACTION")
            {
                quarre_application.state = "INCOMING_INTERACTION";
                upper_view.current.count = 0;
                upper_view.current.timer.stop();
            }            
        }
    }

    Component.onCompleted: {
        Ossia.SingleDevice.openOSCQueryServer(5678, 1234);
        Ossia.SingleDevice.recreate(ossia_net);
    }

}
