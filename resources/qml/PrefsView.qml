import QtQuick 2.0
import QtQuick.Window 2.0

Item {

    anchors.fill: parent
    property alias marea : mouse_area

    MouseArea {
        id: mouse_area
        anchors.fill: parent
    }

    FontLoader {
        id: lato_thin
        source: "lato/Lato-Light.ttf"
    }

    Rectangle {
        id: prefs_blackrect
        color: "#cc070606"
        anchors.rightMargin: 0
        anchors.bottomMargin: 0
        anchors.leftMargin: 0
        anchors.topMargin: 0
        anchors.fill: parent

        Rectangle {
            id: prefs_blackcircle
            x: 90
            y: 253
            width: 300
            height: 300
            color: "#66000000"
            radius: 150
        }

        Text {
            id: title
            color: "#ffffff"
            text: qsTr("quarrè")
            horizontalAlignment: Text.AlignHCenter
            anchors.right: parent.right
            anchors.rightMargin: 141
            anchors.left: parent.left
            anchors.leftMargin: 141
            anchors.top: parent.top
            anchors.topMargin: 70
            font.capitalization: Font.AllUppercase
            font.pixelSize: 40
            font.family: lato_thin.name
        }
    }

    Text {
        id: connection_status
        x: 114
        y: 345
        color: "#ffffff"
        text: "Awaiting \n connection..."
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        font.pointSize: 40
        font.family: lato_thin.name
    }
}

