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
        from: -1; to: 1;
        midValue: 0.0

        height: parent.height * 0.5
        width: height * 0.2
        y: parent.height * 0.15
        x: cb.x
        value: ossia_modules.jomon_arp_bend
        live: true

        onValueChanged: ossia_modules.jomon_arp_bend = value
    }

    Rectangle
    {
        color: "transparent"
        width: parent.width * 0.6
        height: width
        y: parent.height * 0.15
        x: parent.width * 0.35

        QuarreSlider
        {
            name: "réverbération"
            value: ossia_modules.jomon_reverb_level
            onValueChanged: ossia_modules.jomon_reverb_level = value
            y: parent.height*0.1
        }

        QuarreSlider
        {
            name: "filtrage"
            min: 0.25; max: 1.0
            value: ossia_modules.jomon_lpf_freq
            onValueChanged: ossia_modules.jomon_lpf_freq = value
            y: parent.height*0.3
        }

        QuarrePad
        {
            id: tempo_pad
            y: parent.height * 0.5
            height: parent.height * 0.25
            width: height
            anchors.horizontalCenter: parent.horizontalCenter
            onPressedChanged:
            {
                if ( pressed ) tempo_pad.push();
                else tempo_pad.release();

                ossia_modules.jomon_arp_tempo = (!pressed)*90;
            }
        }
    }

    ComboBox
    {
        id: cb
        y: parent.height*0.7
        height: parent.height*0.1
        width: parent.width*0.65
        anchors.horizontalCenter: parent.horizontalCenter
        model: [ "FIFO", "Down", "Up", "Up/Down", "Random" ]

        onActivated:
            ossia_modules.jomon_arp_mode = textAt(index);

    }
}
