import QtQuick 2.0
import Ossia 1.0 as Ossia

Rectangle
{
    anchors.fill: parent
    color: "transparent"

    property real xdata: 0.0

    onEnabledChanged:
    {
        sensor_manager.rotation.enabled = enabled;
        polling_timer.running = enabled;
    }

    Ossia.Binding
    {
        device: ossia_net.client
        node: ossia_net.format_user_parameter("/modules/rotation/x/angle")
        on: xdata
    }

    Timer
    {
        id: polling_timer
        interval: 50
        repeat: true

        onTriggered: xdata = sensor_manager.rotation.reading.x

    }

    Image
    {
        id: arrow
        antialiasing: true
        anchors.fill: parent
        source: "modules/arrow.png"
        fillMode: Image.PreserveAspectFit

        x: parent.width/2
        y: parent.height/2

        transform: [

            Rotation
            {
                id: rotation
                axis { x: 0; y: 0; z: 1 }
                angle: xdata
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

        text:       "rotation: " + Math.floor(xdata) + " degrees"
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
}

