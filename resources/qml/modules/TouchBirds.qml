import QtQuick 2.0
import Ossia 1.0 as Ossia
import "items"

Rectangle
{
    id: touchbirds_root
    color: "#232426"; opacity: 0.8

    property vector3d trigger: Qt.vector3d(0, 0, 0)

    property var birds: [
        "fauvette",
        "pic-vert",
        "loriot",
        "rossignol" ]

    Ossia.Binding
    {
        id:         touch_points_trigger
        device:     ossia_net.client
        node:       ossia_net.get_user_base_address() + '/controllers/birds/trigger'
        on:         trigger
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
