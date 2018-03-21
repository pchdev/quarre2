import QtQuick 2.0
import QtQuick.Controls 2.0

Item
{
    property int num_sliders: 4

    Column
    {
        spacing: 10
        anchors.verticalCenter:     parent.verticalCenter
        anchors.horizontalCenter:   parent.horizontalCenter

        Repeater
        {
            model: num_sliders

            QuarreSlider
            {
                slider_index: index
            }
        }
    }
}
