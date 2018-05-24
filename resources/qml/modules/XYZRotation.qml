import QtQuick 2.0

Rectangle
{
    anchors.fill: parent
    color: "transparent"

    onEnabledChanged:
    {
        sensor_manager.rotation.active = enabled;
        polling_timer.running = enabled;
    }

    Timer
    {
        id: polling_timer
        interval: 50
        repeat: true

        onTriggered:
        {
            var xyz = Qt.vector3d(sensor_manager.rotation.reading.x,
                                  sensor_manager.rotation.reading.y,
                                  sensor_manager.rotation.reading.z)

            ossia_modules.sensors_rotation_xyz_data = xyz
        }
    }
}
