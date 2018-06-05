import QtQuick 2.0
import QtQuick.Controls 2.0
import "items"

Rectangle
{
    anchors.fill: parent
    color: "transparent"

    QuarreSlider
    {
        min: -3; max: 3;
        value: ossia_modules.vare_granular_pitch
        onValueChanged: ossia_modules.vare_granular_pitch = Math.floor(value)
        y: parent.height*0.05
    }

    QuarreSlider
    {
        min: 0.5; max: 4.0
        value: ossia_modules.vare_granular_overlap
        onValueChanged: ossia_modules.vare_granular_overlap= value
        y: parent.height*0.2
    }

    QuarreSlider
    {
        min: 2.0; max: 110.0
        value: ossia_modules.vare_granular_rate
        onValueChanged: ossia_modules.vare_granular_rate = value
        y: parent.height*0.35
    }

    QuarreSlider
    {
        value: ossia_modules.vare_granular_x
        onValueChanged: ossia_modules.vare_granular_x= value
        y: parent.height*0.5
    }

    QuarreSlider
    {
        min: -1.0; max: 1.0
        value: ossia_modules.vare_granular_x_p
        onValueChanged: ossia_modules.vare_granular_x_p = value
        y: parent.height*0.65
    }

}
