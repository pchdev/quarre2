import QtQuick 2.0
import Ossia 1.0 as Ossia

Rectangle
{
    id: root

    property int recording_phase:   0;
    property int sending_phase:     0;
    property var trajectory:        []
    property bool trigger:          false
    property int trajectory_size:   0;

    property vector2d current_send_data: Qt.vector2d(0, 0);

    Timer
    {
        id: record_timer
        running: false
        repeat: true
        interval: 25

        onTriggered:
        {
            var x = trajectory_area.mouseX/trajectory_area.width;
            var y = trajectory_area.mouseY/trajectory_area.height;

            trajectory[recording_phase] = Qt.vector2d(x,y);
            recording_phase++;
            trajectory_size++;
        }
    }

    Timer
    {
        id: send_timer
        running: false
        repeat: true
        interval: 25

        onTriggered:
        {
            current_send_data = trajectory[sending_phase];
            sending_phase++;

            trajectory_canvas.requestPaint();

            if ( sending_phase >= trajectory_size )
                running = false;
        }
    }

    Ossia.Binding
    {
        id:         trajectory_trigger
        device:     ossia_net.client
        node:       ossia_net.get_user_base_address() + '/controllers/trajectories/trigger'
        on:         trigger
    }

    Ossia.Binding
    {
        id:         trajectory_data
        device:     ossia_net.client
        node:       ossia_net.get_user_base_address() + '/controllers/xy/0/data'
        on:         current_send_data
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

    MouseArea
    {
        id: trajectory_area
        anchors.fill: parent

        onPressed:
        {
            // start polling timer, poll with limited time (3 or 4 seconds max)
            trajectory.length = 0;
            record_timer.running = true;
            trajectory_canvas.getContext('2d').reset();
        }

        onReleased:
        {
            // send trigger
            // start sender timer, poll recorded data
            trigger = !trigger;
            record_timer.running = false;
            send_timer.running = true;
        }

        Canvas
        {
            id: trajectory_canvas
            anchors.fill: parent
            onPaint:
            {
                var ctx = trajectory_canvas.getContext('2d');
                var w = trajectory_canvas.width * 0.1
                var x = current_send_data.x * trajectory_canvas.width - w;
                var y = current_send_data.y * trajectory_canvas.height - w;

                ctx.strokeStyle = "#ffffff";
                ctx.ellipse(x,y,w,w);
                ctx.stroke();
            }

        }
    }
}
