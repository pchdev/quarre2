import QtQuick 2.0
import Ossia 1.0 as Ossia

GestureViewer
{
    title:          "Agiter"
    gestures:       [ "QtSensors.shake" ]

    description:    "Agiter fermement votre téléphone de gauche à droite et inversement,
 de manière sèche et rapide"

    anchors.fill:   parent

    Connections
    {
        target: gesture_manager.backend
        onDetected:
        {
            ossia_modules.gestures_shake_trigger = !ossia_modules.gestures_shake_trigger;
            trigger_animation.running = true
        }
    }
}
