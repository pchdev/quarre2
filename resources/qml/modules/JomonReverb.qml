import QtQuick 2.0
import "items"

Rectangle
{

    anchors.fill: parent
    color: "transparent"

    QuarreSlider
    {
        value: ossia_modules.jomon_reverb_level
        onValueChanged: ossia_modules.jomon_reverb_level = value
        y: parent.height*0.2
    }

    QuarreSlider
    {
        min: 0.25; max: 1.0
        value: ossia_modules.jomon_lpf_freq
        onValueChanged: ossia_modules.jomon_lpf_freq = value
        y: parent.height*0.2 *2
    }


    QuarreSlider
    {
        min: 5; max: 25;
        value: ossia_modules.jomon_arp_velocity
        onValueChanged: ossia_modules.jomon_arp_velocity = value
        y: parent.height*0.2 *3
    }

    QuarreSlider
    {
        min: 2; max: 500;
        value: ossia_modules.jomon_arp_gate
        onValueChanged: ossia_modules.jomon_arp_gate = value
        y: parent.height*0.2 *4
    }

}
