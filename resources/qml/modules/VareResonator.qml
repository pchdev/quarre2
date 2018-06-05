import QtQuick 2.0
import "items"

Rectangle
{
    anchors.fill: parent
    color: "transparent"

    QuarreSlider
    {
        value: ossia_modules.vare_resonator_inpos
        onValueChanged: ossia_modules.vare_resonator_inpos = value
        y: parent.height*0.2*2
    }

    QuarreSlider
    {
        min: -2.0; max: 2.0;
        onValueChanged: ossia_modules.vare_resonator_pitch_p = value
        value: ossia_modules.vare_resonator_pitch_p
        y: parent.height*0.2*3;
    }

    property bool proximity_state: false

    onEnabledChanged:
    {
        sensor_manager.proximity.active = enabled;
        poll.running = enabled;
    }

    Timer
    {
        id: poll
        interval: 50
        repeat: true

        onTriggered:
        {
            if ( sensor_manager.proximity.reading.near && !proximity_state )
            {
                proximity_state = true;
                ossia_modules.jomon_palm_state = true;
            }

            else if ( !sensor_manager.proximity.reading.near && proximity_state )
            {
                proximity_state = false;
                ossia_modules.jomon_palm_state = false;
            }
        }
    }
}
