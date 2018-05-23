import QtQuick 2.0
import Ossia 1.0 as Ossia
import "items"

Rectangle
{
    id:         root
    color:      "#232426"
    opacity:    0.8

    property vector2d rtouchpoints: Qt.vector2d(0, 0)

    SpatializationSphere {}

    MouseArea
    {
        anchors.fill: parent

        onPressed:
        {
            rtouchpoints = Qt.vector2d  ( mouseX, mouseY );
            ossia_modules.touch_xy_points = Qt.vector2d ( mouseX/width, 1-mouseY/height );

            if ( touch_animation.running )
                touch_animation.running = false;

            touch_animation.running = true;
            ossia_net.oshdl.vibrate(50);
        }

        Rectangle
        {
            id: touch_animation_circle
            color: "transparent"
            border.color: "white"
            border.width: 5
            x: rtouchpoints.x - width/2
            y: rtouchpoints.y - height/2
        }

        ParallelAnimation
        {
            id: touch_animation
            NumberAnimation
            {
                target: touch_animation_circle
                property: "width"
                from: 0
                to: root.width*0.25
                duration: 1500
            }
            NumberAnimation
            {
                target: touch_animation_circle
                property: "height"
                from: 0
                to: root.width*0.25
                duration: 1500
            }
            NumberAnimation
            {
                target: touch_animation_circle
                property: "radius"
                from: 0
                to: root.width*0.125
                duration: 1500
            }
            SequentialAnimation
            {
                NumberAnimation
                {
                    target: touch_animation_circle
                    property: "opacity"
                    from: 0
                    to: 0.8
                    duration: 750
                }
                NumberAnimation
                {
                    target: touch_animation_circle
                    property: "opacity"
                    from: 0.8
                    to: 0
                    duration: 750
                }
            }
        }
    }
}
