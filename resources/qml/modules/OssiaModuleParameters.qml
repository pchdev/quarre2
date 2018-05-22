import QtQuick 2.0
import Ossia 1.0 as Ossia

Item
{
    property bool gestures_blow_trigger:            false
    property bool gestures_hammer_trigger:          false
    property bool gestures_palm_trigger:            false
    property bool gestures_shake_trigger:           false
    property vector3d touch_birds_trigger:          Qt.vector3d(0, 0, 0)
    property bool touch_trajectories_trigger:       false
    property vector2d touch_trajectories_position:  Qt.vector2d(0, 0)
    property real sensors_rotation_z_angle:         0.0
    property real sensors_rotation_x_angle:         0.0
    property vector2d touch_xy_points:  Qt.vector2d(0, 0)

    Ossia.Binding //-------------------------------------------------------- BLOW_GESTURE
    {
        device:     ossia_net.client
        node:       ossia_net.format_user_parameter("/modules/gestures/blow/trigger")
        on:         gestures_blow_trigger
    }

    Ossia.Binding //-------------------------------------------------------- HAMMER_GESTURE
    {
        device:     ossia_net.client
        node:       ossia_net.format_user_parameter('/modules/gestures/hammer/trigger')
        on:         gestures_hammer_trigger
    }

    Ossia.Binding //-------------------------------------------------------- PALM_GESTURE
    {
        device:     ossia_net.client
        node:       ossia_net.format_user_parameter('/modules/gestures/palm/trigger')
        on:         gestures_palm_trigger
    }

    Ossia.Binding //-------------------------------------------------------- SHAKE_GESTURE
    {
        device:     ossia_net.client
        node:       ossia_net.format_user_parameter('/modules/gestures/shake/trigger')
        on:         gestures_shake_trigger
    }

    Ossia.Binding //-------------------------------------------------------- BIRDS_TRIGGER
    {
        device:     ossia_net.client
        node:       ossia_net.format_user_parameter('/modules/birds/trigger')
        on:         touch_birds_trigger
    }

    Ossia.Binding //-------------------------------------------------------- TRAJECTORIES
    {
        device:     ossia_net.client
        node:       ossia_net.format_user_parameter('/modules/trajectories/trigger')
        on:         touch_trajectories_trigger
    }

    Ossia.Binding
    {
        device:     ossia_net.client
        node:       ossia_net.format_user_parameter('/modules/trajectories/position')
        on:         touch_trajectories_position
    }

    Ossia.Binding //-------------------------------------------------------- ROTATION_Z
    {
        device:     ossia_net.client
        node:       ossia_net.format_user_parameter("/modules/sensors/rotation/z/angle")
        on:         sensors_rotation_z_angle
    }

    Ossia.Binding //-------------------------------------------------------- ROTATION_X
    {
        device:     ossia_net.client
        node:       ossia_net.format_user_parameter("/modules/rotation/x/angle")
        on:         sensors_rotation_x_angle
    }

    Ossia.Binding //-------------------------------------------------------- TOUCH_XY
    {
        device:     ossia_net.client
        node:       ossia_net.get_user_base_address() + '/modules/xytouch/trigger'
        on:         touch_xy_points
    }
}
