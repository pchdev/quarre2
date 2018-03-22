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

        Repeater
        {
            model: 16

            Loader
            {
                active: SwipeView.isCurrentItem || SwipeView.isNextItem || SwipeView.isPreviousItem
                sourceComponent: QuarreTrackControl
                {
                    width:          base.width
                    height:         base.height
                    track_index:    index

                    Component.onCompleted:
                    {
                        console.log("created: " + index)
                    }
                    Component.onDestruction:
                    {
                        console.log("destroyed: " + index)
                    }
                }
            }
        }
    }
}
