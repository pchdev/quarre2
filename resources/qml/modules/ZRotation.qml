import QtQuick 2.0
import Ossia 1.0 as Ossia

Rectangle
{
    property real offset: 0.0

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
            var offseted = sensor_manager.rotation.reading.z + offset;
            if ( offseted > 180 ) offseted -=360;
            else if ( offseted < -180 ) offseted += 360;

            ossia_modules.sensors_rotation_z_angle = -offseted;
        }

    }

    Image
    {
        id: arrow
        antialiasing: true
        anchors.fill: parent
        source: "qrc:/modules/arrow.png"
        fillMode: Image.PreserveAspectFit

        x: parent.width/2
        y: parent.height/2

        MouseArea
        {
            anchors.fill: parent
            onPressed: offset = -sensor_manager.rotation.reading.z;
        }

        transform: [

            Rotation
            {
                id: rotation
                origin.x: parent.width/2
                origin.y: parent.height/2
                angle: ossia_modules.sensors_rotation_z_angle
            },

            Scale
            {
                id: scale
                origin.x : width/2
                origin.y: height/2
                xScale: 0.2
                yScale: 0.2
            }
        ]
    }

    Text //---------------------------------------------------------------- ROTATION_PRINT
    {
        id:         rotation_print

        text:       "rotation: " + Math.floor(ossia_modules.sensors_rotation_z_angle) + " degrees"
        color:      "#ffffff"
        width:      parent.width
        height:     parent.height * 0.2
        y:          parent.height * 0.2

        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        font.pointSize: 16 * root.fontRatio
        textFormat: Text.PlainText
        font.family: font_lato_light.name
    }

    Text //---------------------------------------------------------------- ROTATION_PRINT
    {
        id:         calibration_label

        text:       "appuyez sur la flèche pour calibrer le nord"
        color:      "#ffffff"
        width:      parent.width
        height:     parent.height * 0.2
        y:          parent.height * 0.6

        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        font.pointSize: 16 * root.fontRatio
        textFormat: Text.PlainText
        font.family: font_lato_light.name
    }
}

