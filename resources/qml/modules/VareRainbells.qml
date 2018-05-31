import QtQuick 2.0

Rectangle
{
    color: "transparent"
    anchors.fill: parent

    property bool close_triggered: false

    onEnabledChanged:
    {
        rotation.enabled = enabled;
        proximity_poll.running = enabled;
        sensor_manager.proximity.active = enabled;
    }

    Timer
    {
        id: proximity_poll
        interval: 50
        repeat: true

        onTriggered:
        {
            if ( sensor_manager.proximity.reading.near && !close_triggered )
            ossia_modules.sensors_proximity_close = !ossia_modules.sensors_proximity_close

            close_triggered = sensor_manager.proximity.reading.near;
        }
    }

    XYZRotation { id: rotation }

}
