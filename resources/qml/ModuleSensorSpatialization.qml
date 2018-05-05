import QtQuick 2.0

Rectangle
{
    height:     parent.height*0.8
    width:      height
    radius:     width/2

    anchors.horizontalCenter:   parent.horizontalCenter
    anchors.verticalCenter:     parent.verticalCenter

    border.width:   0.5
    border.color:   "white"

    antialiasing: true

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
                origin.x: parent.width/2
                origin.y: parent.height/2
                angle: sensor_manager.rotation_z_data
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
}

