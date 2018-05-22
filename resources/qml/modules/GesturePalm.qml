import QtQuick 2.0
import Ossia 1.0 as Ossia

GestureViewer
{
    title:          "Paume flottante"
    gestures:       [ "QtSensors.cover" ]

    description:    "Placer votre main tendue au dessus de le partie haute de l'appareil.
 Celui-ci doit être tenu à plat."

    anchors.fill:   parent

    Connections
    {
        target: gesture_manager.backend
        onDetected:
        {
            ossia_modules.gestures_palm_trigger = ossia_modules.gestures_palm_trigger;
            trigger_animation.running = true
        }
    }
}
