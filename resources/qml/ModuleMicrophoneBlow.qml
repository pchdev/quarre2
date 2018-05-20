import QtQuick 2.0
import Quarre 1.0 as Quarre

Rectangle
{

    Timer
    {
        id: rms_polling_timer
        running: false
        repeat: true

        onTriggered:
        {
            var rms = audio_hdl.rms;
        }
    }

    Quarre.AudioHdl { id: audio_hdl }

    Component.onCompleted:
    {
        audio_hdl.activate_input();
        rms_polling_timer.start();
    }
}
