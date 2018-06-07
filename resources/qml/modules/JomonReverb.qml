import QtQuick 2.0
import "items"

Rectangle
{

    anchors.fill: parent
    color: "transparent"

    QuarreSlider
    {
        name: "force"
        min: 5; max: 25;
        value: ossia_modules.jomon_arp_velocity
        onValueChanged: ossia_modules.jomon_arp_velocity = value
        y: parent.height*0.2 *3
    }

    QuarreSlider
    {
        name: "legato"
        min: 2; max: 500;
        value: ossia_modules.jomon_arp_gate
        onValueChanged: ossia_modules.jomon_arp_gate = value
        y: parent.height*0.2 *4
    }

}
