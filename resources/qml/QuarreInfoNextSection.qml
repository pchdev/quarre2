import QtQuick 2.0

Rectangle {
    // SECOND UPPER VIEW SECTION
    // used to display next interactions
    // it is composed of 3 elements: the 'NEXT' label
    // the label of the next interaction to come
    property int count: 5
    property alias timer: next_interaction_timer
    property alias title: next_interaction_title.title

    states: [

        State {
            name: "FULL_VIEW"
            PropertyChanges {
                target: next_interaction_label
                verticalAlignment: Text.AlignTop
                horizontalAlignment: Text.AlignHCenter
                height: next.height * 0.15
                text: "NEXT INTERACTION"
                font.pointSize: 25
                y: next_interaction_label.parent.height * 0.1
                x: 0
            }

            PropertyChanges {
                target: next_interaction_circle
                height: next.height * 0.2
                width: next.height * 0.2
                radius: (next.width * 0.2)/2
                x: 0
            }

            AnchorChanges {
                target: next_interaction_circle
                anchors.horizontalCenter: next.horizontalCenter
                anchors.top: next_interaction_label.bottom
                anchors.verticalCenter: undefined
            }

            PropertyChanges {
                target: next_interaction_title
                font.pointSize: 14
                anchors.topMargin: next.height * 0.1
            }

            AnchorChanges {
                target: next_interaction_title
                anchors.top: next_interaction_circle.bottom
                anchors.verticalCenter: undefined
            }
        },

        State {
            name: "REDUCED_VIEW"
            PropertyChanges {
                target: next_interaction_label
                text: "NEXT"
                font.pointSize: 20
                verticalAlignment: Text.AlignVCenter
                x: next_interaction_label.width * 0.04
            }

            PropertyChanges {
                target: next_interaction_title
                width: next_interaction_title.parent.width * 0.47
                height: next_interaction_title.parent.height
                x: next_interaction_title.width*0.55
                font.pointSize: 12
            }

            AnchorChanges {
                target: next_interaction_title
                anchors.top: next_interaction_title.parent.top
                anchors.bottom: next_interaction_title.parent.bottom
                anchors.left: next_interaction_title.parent.left
                anchors.right: next_interaction_title.parent.right
            }

            PropertyChanges {
                target: next_interaction_circle
                width: next_interaction_circle.parent.height * 0.8
                height: next_interaction_circle.parent.height * 0.8
                radius: next_interaction_circle.width/2
                x: next_interaction_circle.parent.width * 0.8
            }

            AnchorChanges {
                target: next_interaction_circle
                anchors.verticalCenter: next_interaction_circle.parent.verticalCenter
            }
        }
    ]

    // ------------------------------------------------------------------------------------------------

    Timer {
        id: next_interaction_timer
        interval: 1000
        running: false
        repeat: true
        onTriggered: {
            if(parent.count == 0) running = false
            else parent.count -= 1;
            next_interaction_countdown_label.text = parent.count;
        }
    }

    Text {
        id: next_interaction_label
        text: "NEXT"
        color: "#ffffff"
        width: parent.width
        height: parent.height
        x: width*0.04
        verticalAlignment: Text.AlignVCenter
        font.pointSize: 20
        font.bold: true
        textFormat: Text.PlainText
    }

    Text {
        // the title of the next incoming interaction
        id: next_interaction_title
        text: "super spatialisation interaction"
        color: "#ffffff"
        width: parent.width * 0.47
        height: parent.height
        anchors.fill: parent
        x: width*0.55
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        font.family: font_lato_light.name
        antialiasing: true
        font.pointSize: 12
        font.bold: false
        textFormat: Text.PlainText
        wrapMode: Text.WordWrap
    }

    Rectangle {
        // the countdown circle element
        id: next_interaction_circle
        width: parent.height * 0.8
        height: parent.height * 0.8
        color: "#b3ffffff"
        radius: width/2
        x: parent.width * 0.8
        anchors.verticalCenter: parent.verticalCenter

        Text {
            // the countdown display
            id: next_interaction_countdown_label
            anchors.fill: parent
            text: parent.parent.count
            color: "#000000"
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            font.pointSize: 30
            textFormat: Text.PlainText
        }
    }
}
