import QtQuick 2.0
import QtQuick.Controls 2.0
import "items"

Rectangle
{
    // pitchbend + tempo variations + mode
    anchors.fill: parent
    color: "transparent"

    QuarreWheelSlider
    {
        from: 0; to: 127;
        midValue: 64

        height: parent.height * 0.5
        width: height * 0.2
        y: parent.height * 0.15
        x: parent.width * 0.25
        value: ossia_modules.jomon_arp_bend

        onValueChanged: ossia_modules.jomon_arp_bend = value
    }

    QuarreWheelSlider
    {
        from: 45; to: 135;
        midValue: 90
        height: parent.height * 0.5
        width: height * 0.2
        y: parent.height * 0.15
        x: parent.width * 0.65
        value: ossia_modules.jomon_arp_tempo
        live: false

        onValueChanged: ossia_modules.jomon_arp_tempo = value
    }


    ComboBox
    {
        y: parent.height*0.8
        height: parent.height*0.1
        width: parent.width*0.65
        anchors.horizontalCenter: parent.horizontalCenter
        model: [ "FIFO", "Down", "Up", "Up/Down", "Random" ]
        onCurrentIndexChanged: ossia_modules.jomon_arp_mode = currentText;
    }




}
