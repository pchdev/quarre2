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
    property real sensors_rotation_x_angle:         0.0
    property real sensors_rotation_y_angle:         0.0
    property real sensors_rotation_z_angle:         0.0
    property vector3d sensors_rotation_xyz_data:    Qt.vector3d(0, 0, 0)
    property vector2d touch_xy_points:              Qt.vector2d(0, 0)
    property bool sensors_proximity_close:          false

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

    Ossia.Binding //-------------------------------------------------------- ROTATION_X
    {
        device:     ossia_net.client
        node:       ossia_net.format_user_parameter("/modules/sensors/rotation/x/angle")
        on:         sensors_rotation_x_angle
    }

    Ossia.Binding //-------------------------------------------------------- ROTATION_Y
    {
        device:     ossia_net.client
        node:       ossia_net.format_user_parameter("/modules/sensors/rotation/y/angle")
        on:         sensors_rotation_y_angle
    }

    Ossia.Binding //-------------------------------------------------------- ROTATION_Z
    {
        device:     ossia_net.client
        node:       ossia_net.format_user_parameter("/modules/sensors/rotation/z/angle")
        on:         sensors_rotation_z_angle
    }

    Ossia.Binding //-------------------------------------------------------- ROTATION_XYZ
    {
        device:     ossia_net.client
        node:       ossia_net.format_user_parameter("/modules/sensors/rotation/xyz/data")
        on:         sensors_rotation_xyz_data
    }

    Ossia.Binding //-------------------------------------------------------- TOUCH_XY
    {
        device:     ossia_net.client
        node:       ossia_net.format_user_parameter('/modules/xytouch/trigger')
        on:         touch_xy_points
    }

    Ossia.Binding //-------------------------------------------------------- PROXIMITY
    {
        device:     ossia_net.client
        node:       ossia_net.format_user_parameter('/modules/sensors/proximity/close')
        on:         sensors_proximity_close
    }

    property real vare_resonator_brightness: 0.0
    property real vare_resonator_inpos: 1.0
    property real vare_resonator_pitch: 440.0

    Ossia.Binding //-------------------------------------------------------- VARE_RESONATOR
    {
        device:     ossia_net.client
        node:       ossia_net.format_user_parameter('/modules/vare/resonator/brightness')
        on:         vare_resonator_brightness
    }

    Ossia.Binding
    {
        device:     ossia_net.client
        node:       ossia_net.format_user_parameter('/modules/vare/resonator/inpos')
        on:         vare_resonator_inpos
    }

    Ossia.Binding
    {
        device:     ossia_net.client
        node:       ossia_net.format_user_parameter('/modules/vare/resonator/pitch')
        on:         vare_resonator_pitch
    }

    property real vare_body_tone: 0.0
    property real vare_body_pitch: 0.46
    property vector2d vare_body_xy: Qt.vector2d(0.5, 0.5)

    Ossia.Binding //-------------------------------------------------------- VARE_BODY
    {
        device:     ossia_net.client
        node:       ossia_net.format_user_parameter('/modules/vare/body/tone')
        on:         vare_body_tone
    }

    Ossia.Binding
    {
        device:     ossia_net.client
        node:       ossia_net.format_user_parameter('/modules/vare/body/pitch')
        on:         vare_body_pitch
    }

    Ossia.Binding
    {
        device:     ossia_net.client
        node:       ossia_net.format_user_parameter('/modules/vare/body/xy')
        on:         vare_body_xy
    }

    property real vare_granular_pitch: 2.0
    property real vare_granular_pitch_env: 0.0
    property real vare_granular_overlap: 0.125
    property int vare_granular_sample: 0

    Ossia.Binding //-------------------------------------------------------- VARE_GRANULAR
    {
        device:     ossia_net.client
        node:       ossia_net.format_user_parameter('/modules/vare/granular/pitch_env')
        on:         vare_granular_pitch_env
    }

    Ossia.Binding
    {
        device:     ossia_net.client
        node:       ossia_net.format_user_parameter('/modules/vare/granular/pitch')
        on:         vare_granular_pitch
    }

    Ossia.Binding
    {
        device:     ossia_net.client
        node:       ossia_net.format_user_parameter('/modules/vare/granular/sample')
        on:         vare_granular_sample
    }

    Ossia.Binding
    {
        device:     ossia_net.client
        node:       ossia_net.format_user_parameter('/modules/vare/granular/overlap')
        on:         vare_granular_overlap
    }

    property vector3d sensors_accelerometers_xyz_data: Qt.vector3d(0, 0, 0)
    property bool vare_percussions_handdrum: false
    property bool vare_percussions_shake: false

    Ossia.Binding
    {
        device:     ossia_net.client
        node:       ossia_net.format_user_parameter('/modules/sensors/accelerometers/xyz/data')
        on:         sensors_accelerometers_xyz_data
    }

    Ossia.Binding
    {
        device:     ossia_net.client
        node:       ossia_net.format_user_parameter('/modules/vare/percussions/handdrum')
        on:         vare_percussions_handdrum
    }

    Ossia.Binding
    {
        device:     ossia_net.client
        node:       ossia_net.format_user_parameter('/modules/vare/percussions/shake')
        on:         vare_percussions_shake
    }
}
