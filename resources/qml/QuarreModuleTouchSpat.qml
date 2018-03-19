import QtQuick 2.0
import "Maths.js" as SpatMaths
import Ossia 1.0 as Ossia

Rectangle {

    property int interaction_id: 0
    property int nspeakers: 8
    property int nsources: 1
    property var touchpoints: Qt.vector2d(0, 0)

    Ossia.Binding
    {
        id: touchpoints_data
        node: '/user/' + ossia_net.slot + '/touch/positions'
        on: touchpoints
    }

    MultiPointTouchArea {
        property var selected_sources: []
        maximumTouchPoints: nsources
        anchors.fill: parent

        onPressed:
        {
            for(var i = 0; i < touchPoints.length; ++i)
                touchpoints = Qt.vector2d(touchPoints[i].x/width, 1 - touchPoints[i].y/height);
        }

        onUpdated:
        {

        }

        Rectangle {
            id: octo_circle            
            height: parent.height *0.9
            width: height
            radius: width/2
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            border.width: 0.5
            border.color: "white"
            color: "transparent"
            antialiasing: true

            Repeater {
                model: nspeakers
                Rectangle {
                    width: parent.width*0.05
                    height: width
                    radius: width/2
                    color: "gray"
                    x: SpatMaths.speakerpos_x(index, nspeakers)*octo_circle.width - radius
                    y: SpatMaths.speakerpos_y(index, nspeakers)*octo_circle.width - radius
                }
            }

            Repeater {
                model: nsources
                Rectangle {
                    width: parent.width*0.075
                    height: width
                    radius: width/2
                    color: "darkred"
                    x: parent.width/2 - radius
                    y: parent.height/2 - radius
                }
            }
        }
    }
}
