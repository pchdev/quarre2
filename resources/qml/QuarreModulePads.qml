import QtQuick 2.0

Item
{
    property int num_pads: 16
    id: module

    Grid
    {
        columns: 4
        rows: 4
        spacing: 20
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter

        Repeater
        {
            model: num_pads

            QuarrePad
            {
                width:      module.width/6
                height:     module.width/6
                pad_index:  index
            }
        }
    }
}
