import QtQuick 2.0

Rectangle
{
    anchors.fill: parent
    color: "transparent"

    Timer
    {
        id: polling_timer
        interval: 50
        repeat: true

        onTriggered:
        {

        }
    }



}
