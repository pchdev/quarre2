import QtQuick 2.0

Item {

    anchors.fill: parent

    InfoView {
        id: info_view
    }

    Rectangle {             // when lower view empty
        id: lower_view
        y: parent.height / 2 // should return 854 / 2 = 427
        width: parent.width // should return 480
        height: parent.height / 2
        color: "#e60b0909"
        border.width: 0
        border.color: "#000000"
    }
}
