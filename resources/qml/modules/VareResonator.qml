import QtQuick 2.0
import "items"

Rectangle
{
    anchors.fill: parent
    color: "transparent"

    QuarreSlider
    {
        value: ossia_modules.vare_resonator_brightness
        onValueChanged: ossia_modules.vare_resonator_brightness = value
        y: parent.height * 0.2
    }

    QuarreSlider
    {
        value: ossia_modules.vare_resonator_inpos
        onValueChanged: ossia_modules.vare_resonator_inpos = value
        y: parent.height*0.2*2
    }

    QuarreSlider
    {
        min: 55.0; max: 3520.0;
        onValueChanged: ossia_modules.vare_resonator_pitch = value
        value: ossia_modules.vare_resonator_pitch
        y: parent.height*0.2*3;
    }
}
