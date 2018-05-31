import QtQuick 2.0
import QtQuick.Controls 2.0
import "items"

Rectangle
{
    anchors.fill: parent
    color: "transparent"

    QuarreSlider
    {
        min:    0.250
        max:    1.0
        value:  ossia_modules.ammon_reverb_level
        y:      parent.height*0.2

        onValueChanged: ossia_modules.ammon_reverb_level = value
    }

    // todo: add sensor control on reverb parameters:
    // bright and size ?
    // + reverse ?

    ComboBox
    {
        y:          parent.height*0.2*2
        height:     parent.height*0.1
        width:      parent.width*0.65
        model:      ["Model 1", "Model 2", "Model 3", "Model 4", "Model 5" ]

        anchors.horizontalCenter:   parent.horizontalCenter
        onCurrentIndexChanged:      ossia_modules.ammon_reverb_model = currentIndex;
    }

}
