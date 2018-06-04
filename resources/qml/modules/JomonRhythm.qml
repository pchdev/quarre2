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
        x: parent.width * 0.15
        value: ossia_modules.jomon_arp_bend

        onValueChanged: ossia_modules.jomon_arp_bend = value
    }

    Rectangle
    {
        id: pads_manager
        color: "transparent"

        property var lookup: [
            180, 240, 360,
            80, 90, 135,
            20, 40, 60 ]

        width: parent.width * 0.45
        height: width
        y: parent.height * 0.15
        x: parent.width * 0.45

        function pressed(i,b)
        {
            if ( b )
            {
                pad_repeater.itemAt(i).push();
                ossia_modules.jomon_arp_tempo = lookup[i];

                for ( var j = 0; j < 9; j++ )
                {
                    if ( j === i ) continue;
                    pad_repeater.itemAt(j).release();
                }
            }
            else
            {
                pad_repeater.itemAt(4).push();
                ossia_modules.jomon_arp_tempo = lookup[4];

                for ( var k = 0; k < 9; k++ )
                {
                    if ( k === 4 ) continue;
                    pad_repeater.itemAt(k).release();
                }
            }
        }

        Grid
        {
            columns: 3
            rows: 3
            spacing: 20
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter

            Repeater
            {
                id: pad_repeater
                model: pads_manager.lookup

                QuarrePad
                {
                    id:         target
                    width:      pads_manager.width*0.3
                    height:     pads_manager.width*0.3
                    pad_index:  index
                }
            }
        }
    }

    ComboBox
    {
        y: parent.height*0.7
        height: parent.height*0.1
        width: parent.width*0.65
        anchors.horizontalCenter: parent.horizontalCenter
        model: [ "FIFO", "Down", "Up", "Up/Down", "Random" ]

        onActivated:
            ossia_modules.jomon_arp_mode = textAt(index);


    }




}
