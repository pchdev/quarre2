import QtQuick 2.0
import Ossia 1.0 as Ossia

GestureViewer
{

    property bool trigger: false

    title:          "Frappe verticale"
    gestures:       [ "whip" ]

    description:    "Effectuer un geste sec, peu ample, vers le bas,
 comme un marteau. L'appareil doit être à plat (et non sur la tranche)"

    anchors.fill:   parent

    Connections
    {
        target: gesture_manager.backend
        onDetected: trigger = !trigger;
    }

    Ossia.Binding
    {
        device:     ossia_net.client
        node:       ossia_net.format_user_parameter('/modules/gestures/hammer/trigger')
        on:         trigger
    }
}
