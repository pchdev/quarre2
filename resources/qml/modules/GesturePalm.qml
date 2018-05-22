import QtQuick 2.0
import Ossia 1.0 as Ossia

GestureViewer
{
    property bool trigger: false

    title:          "Paume flottante"
    gestures:       [ "QtSensors.cover" ]

    description:    "Placer votre main tendue au dessus de le partie haute de l'appareil.
 Celui-ci doit être tenu à plat."

    anchors.fill:   parent

    Connections
    {
        target: gesture_manager.backend
        onDetected: trigger = !trigger;
    }

    Ossia.Binding
    {
        device:     ossia_net.client
        node:       ossia_net.format_user_parameter('/modules/gestures/palm/trigger')
        on:         trigger
    }
}