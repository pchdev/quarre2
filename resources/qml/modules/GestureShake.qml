import QtQuick 2.0
import Ossia 1.0 as Ossia

GestureViewer
{
    property bool trigger: false

    title:          "Agiter"
    gestures:       [ "shake" ]

    description:    "Agiter votre téléphone de gauche à droite et inversement, de manière sèche et rapide"
    anchors.fill:   parent

    Connections
    {
        target: gesture_manager.backend
        onDetected: trigger = !trigger;
    }

    Ossia.Binding
    {
        device:     ossia_net.client
        node:       ossia_net.format_user_parameter('/modules/gestures/shake/trigger')
        on:         trigger
    }
}
