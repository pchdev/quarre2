import QtQuick 2.0

Item
{
    property int track_index
    id: base

    width:  parent.width
    height: parent.height

    QuarrePad
    {
        pad_index:  track_index
        width:      base.width*0.25
        height:     base.height*0.25
        y:          base.height*0.2

        anchors.horizontalCenter: parent.horizontalCenter
    }

    QuarreSlider
    {
        slider_index: track_index
        width: base.width*0.6
        height: base.height*0.1

        y: base.height*0.6

        anchors.horizontalCenter: parent.horizontalCenter

    }
}
