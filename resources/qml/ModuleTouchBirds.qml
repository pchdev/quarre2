import QtQuick 2.0
import Ossia 1.0 as Ossia

Rectangle
{
    id: touchbirds_root

    property vector2d current_position: Qt.vector2d(0, 0)
    property int current_id: 0

    property var birds: [
        "pouillot.véloce",
        "pouillot des arbres",
        "pic-vert",
        "rossignol" ]

    Ossia.Binding
    {
        id:         touchpoints_data
        device:     ossia_net.client
        node:       ossia_net.get_user_base_address() + '/controllers/birds/position'
        on:         current_position
    }

    Ossia.Binding
    {
        id:         touch_points_id
        device:     ossia_net.client
        node:       ossia_net.get_user_base_address() + '/controllers/birds/id'
        on:         current_id
    }

    SpatializationSphere
    {
        Repeater
        {
            model: birds

            QuarreBird
            {
                name: modelData
                number_id: index
                x: 0.5
                y: 0.3
            }
        }
    }
}
