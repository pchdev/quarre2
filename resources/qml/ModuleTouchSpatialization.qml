import QtQuick 2.0
import Ossia 1.0 as Ossia

Rectangle
{
    id: root

    property vector2d touchpoints: Qt.vector2d(0, 0)
    property vector2d rtouchpoints: Qt.vector2d(0, 0)

    Ossia.Binding
    {
        id:         touchpoints_data
        device:     ossia_net.client
        node:       ossia_net.get_user_base_address() + '/controllers/xy/0/data'
        on:         touchpoints
    }

    Image
    {
        id: rose_bg
        antialiasing: true
        anchors.fill: parent
        fillMode: Image.PreserveAspectFit
        source: "modules/rose2.png"

        transform: Scale
        {
            id: scale
            origin.x: width/2
            origin.y: height/2
        }
    }

    SequentialAnimation
    {
        running: true
        loops: Animation.Infinite

        ParallelAnimation
        {
            NumberAnimation
            {
                target: scale
                property: "xScale"
                from: 1.0; to: 0.9
                duration: 10000
            }

            NumberAnimation
            {
                target: scale
                property: "yScale"
                from: 1.0; to: 0.9
                duration: 10000
            }
        }

        ParallelAnimation
        {
            NumberAnimation
            {
                target: scale
                property: "xScale"
                from: 0.9; to: 1.0
                duration: 10000
            }
            NumberAnimation
            {
                target: scale
                property: "yScale"
                from: 0.9; to: 1.0
                duration: 10000
            }
        }
    }

    MultiPointTouchArea
    {
        property var selected_sources: []
        maximumTouchPoints: nsources
        anchors.fill: parent

        onPressed:
        {
            for ( var i = 0; i < touchPoints.length; ++i )
            {
                rtouchpoints = Qt.vector2d(touchPoints[i].x, touchPoints[i].y);
                touchpoints = Qt.vector2d(
                            touchPoints[i].x/width,
                            1-touchPoints[i].y/height );

                if ( touch_animation.running )
                    touch_animation.running = false;

                touch_animation.running = true;
                ossia_net.oshdl.vibrate(50);
            }
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
