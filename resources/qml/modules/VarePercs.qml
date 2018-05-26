import QtQuick 2.0
import "items"

Rectangle
{
    anchors.fill: parent
    color: "transparent"

    property bool shaking: false;

    onEnabledChanged:
    {
        polling_timer.running = enabled;
        sensor_manager.accelerometers.active = enabled;
    }

    QuarrePad
    {
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter

        width:      parent.width/4
        height:     parent.width/4

        onPressedChanged:
        {
            if ( pressed )
            {
                ossia_modules.vare_percussions_handdrum = !ossia_modules.vare_percussions_handdrum;
                ossia_net.oshdl.vibrate(50);
            }
        }
    }

    Timer
    {
        id: polling_timer
        interval: 25
        repeat: true

        onTriggered:
        {
            if ( sensor_manager.accelerometers.reading.y < -30 && !shaking )
            {
                shaking = true;
                ossia_modules.vare_percussions_shake = !ossia_modules.vare_percussions_shake
            }

            else if ( sensor_manager.accelerometers.reading.y > -20 && shaking )
                shaking = false;
        }
    }
}
