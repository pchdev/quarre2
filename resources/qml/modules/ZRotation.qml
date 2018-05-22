import QtQuick 2.0

Rectangle
{
    anchors.fill: parent
    color: "transparent"

    Image
    {
        id: arrow
        antialiasing: true
        anchors.fill: parent
        source: "modules/arrow.png"
        fillMode: Image.PreserveAspectFit

        x: parent.width/2
        y: parent.height/2

        MouseArea
        {
            anchors.fill: parent
            onPressed: sensor_manager.calibrate_north();
        }

        transform: [

            Rotation
            {
                id: rotation
                origin.x: parent.width/2
                origin.y: parent.height/2
                angle: sensor_manager.rotation.reading.z
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

        text:       "rotation: " + Math.floor(sensor_manager.rotation.reading.z) + " degrees"
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

