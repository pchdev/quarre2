import QtQuick 2.0
import Ossia 1.0 as Ossia
import "items"

Rectangle
{
    id:         root
    color:      "#232426"
    opacity:    0.8

    property int recording_phase:   0;
    property int sending_phase:     0;
    property var trajectory:        []
    property int trajectory_size:   0;

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
            ossia_modules.touch_trajectories_position = trajectory[sending_phase];
            sending_phase++;

            trajectory_canvas.requestPaint();

            if ( sending_phase >= trajectory_size )
                running = false;
        }
    }

    SpatializationSphere { }

    MouseArea
    {
        id: trajectory_area
        anchors.fill: parent

        onPressed:
        {
            // start polling timer, poll with limited time (3 or 4 seconds max)
            trajectory.length = 0;
            recording_phase = 0;
            sending_phase = 0;
            trajectory_size = 0;
            record_timer.running = true;
            trajectory_canvas.getContext('2d').reset();
        }

        onReleased:
        {
            // send trigger
            // start sender timer, poll recorded data
            ossia_modules.touch_trajectories_trigger = !ossia_modules.touch_trajectories_trigger;
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
                var x = ossia_modules.touch_trajectories_position.x * trajectory_canvas.width - w;
                var y = ossia_modules.touch_trajectories_position.y * trajectory_canvas.height - w;

                ctx.strokeStyle = "#ffffff";
                ctx.ellipse(x,y,w,w);
                ctx.stroke();
            }
        }
    }
}
