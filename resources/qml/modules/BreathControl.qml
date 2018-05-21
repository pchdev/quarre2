import QtQuick 2.0
import Quarre 1.0 as Quarre
import Ossia 1.0 as Ossia

Rectangle
{
    color: "transparent"

    property bool trigger: false
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
        onTriggered:    rms = sensor_manager.microphone.rms;
    }

    Ossia.Binding //--------------------------------------------------------------------- TRIGGER
    {
        device:     ossia_net.client
        node:       ossia_net.format_user_parameter ("/modules/breathcontrol/trigger")
        on:         rms > 0.5
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
