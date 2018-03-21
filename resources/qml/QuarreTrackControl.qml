import QtQuick 2.0

Item
{
    property int track_index
    id: base

    width:  parent.width
    height: parent.height

    Column
    {
        spacing: 10
        anchors.horizontalCenter: parent.horizontalCenter

        QuarrePad { pad_index: track_index; width: base.width; height: base.height }
        //QuarreSlider { slider_index: track_index; width: base.width; height: base.height }
    }
}
