import QtQuick 2.0

Item {

    width: parent.width
    height: 50

    Rectangle {
        color: "#4c000000"
        border.color: "#66000000"
        anchors.fill: parent

        FontLoader {
            id: lato_thin
            source: "lato/Lato-Light.ttf"
        }

        Text {
            id: scenario_timer
            width: parent.width
            height: parent.height
            color: "#ffffff"
            text: qsTr("00:00")
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            textFormat: Text.PlainText
            font.pixelSize: 40
            font.family: lato_thin.name
        }
    }
}
