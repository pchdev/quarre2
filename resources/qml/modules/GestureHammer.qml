import QtQuick 2.0
import Ossia 1.0 as Ossia

GestureViewer
{
    id: viewer

    title:          "Frappe verticale"
    gestures:       [ "QtSensors.whip" ]

    description:    "Effectuer un geste sec, peu ample, vers le bas,
 comme un marteau. L'appareil doit être à plat (et non sur la tranche)"

    anchors.fill:   parent

    Connections
    {
        target: gesture_manager.backend
        onDetected:
        {
            ossia_modules.gestures_hammer_trigger = ossia_modules.gestures_hammer_trigger;
            trigger_animation.running = true
        }
    }
}
