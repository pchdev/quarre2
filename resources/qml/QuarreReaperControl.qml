import QtQuick 2.0
import QtQuick.Controls 2.2


Rectangle
{
    id: base
    anchors.fill: parent

    SwipeView
    {
        anchors.fill: parent
        currentIndex: 0

        QuarreTrackControl { track_index: 0 }
        //QuarreTrackControl { track_index: 1 }
        //QuarreTrackControl { track_index: 2 }
    }
}
