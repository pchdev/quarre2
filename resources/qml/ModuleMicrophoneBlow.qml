import QtQuick 2.0
import Quarre 1.0 as Quarre
import Ossia 1.0 as Ossia

Rectangle
{

    property bool trigger: false

    Ossia.Binding
    {
        device: ossia_net.client
        node: ossia_net.get_user_base_address() + "/controllers/breath/trigger"
        on: sensor_manager.microphone_rms_data > 0.5
    }

    Rectangle
    {
        width: parent.width*0.2
        height: parent.height*0.75
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        color: "white"
        border.width: 15
        border.color: "white"

        Rectangle
        {
            color: "black"
            anchors.fill: parent
            height: parent.height * (1-sensor_manager.microphone_rms_data);
        }
    }
}
