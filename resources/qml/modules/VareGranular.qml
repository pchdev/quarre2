import QtQuick 2.0
import "items"

Rectangle
{
    anchors.fill: parent
    color: "transparent"

    QuarreSlider
    {
        min: -2.0; max: 2.0;
        value: ossia_modules.vare_granular_pitch_env
        onValueChanged: ossia_modules.vare_granular_pitch_env = value
        y: parent.height*0.2
    }

    QuarreSlider
    {
        value: ossia_modules.vare_granular_pitch
        onValueChanged: ossia_modules.vare_granular_pitch = value
        y: parent.height*0.2*2
    }

    QuarreSlider
    {
        min: 0.125; max: 0.5
        value: ossia_modules.vare_granular_overlap
        onValueChanged: ossia_modules.vare_granular_overlap= value
        y: parent.height*0.2*3
    }

    QuarreSlider
    {
        value: ossia_modules.vare_granular_sample
        onValueChanged: ossia_modules.vare_granular_sample = value
        y: parent.height*0.2*4
    }
}
