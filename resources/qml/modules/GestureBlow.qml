import QtQuick 2.0
import Quarre 1.0 as Quarre
import Ossia 1.0 as Ossia

Rectangle
{
    id: module
    color: "transparent"

    property real rms: 0.0

    onEnabledChanged:
    {
        sensor_manager.microphone.active    = enabled;
        polling_timer.running               = enabled;        
    }

    Timer //-----------------------------------------------------------------------------
    {
        id:             polling_timer
        interval:       50
        repeat:         true
        onTriggered:
        {
            rms = sensor_manager.microphone.rms;
            if ( rms > 0.4 && !ossia_modules.gestures_blow_trigger)
            {
                ossia_modules.gestures_blow_trigger = true;
                ossia_net.oshdl.vibrate(50);
            }
            else if ( rms < 0.4 && ossia_modules.gestures_blow_trigger )
                 ossia_modules.gestures_blow_trigger = false;
        }
    }

    // -------------------------------------------------------------------------------------------

    Rectangle
    {
        anchors.verticalCenter:     parent.verticalCenter
        anchors.horizontalCenter:   parent.horizontalCenter

        width:  parent.width*0.2
        height: parent.height*0.75

        color: "white"
        border.width: 15
        border.color: "white"

        Rectangle
        {
            color: "black"
            anchors.fill: parent
            height: parent.height * (1-rms);
        }
    }
}
