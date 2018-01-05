import QtQuick 2.0

Rectangle {

    property int count: 0
    property alias timer: current_interaction_timer

    states: [

        State {
            name: "FULL_VIEW"
            PropertyChanges {
                target: current_interaction_circle
                width: current.width * 0.38
                height: current_interaction_circle.width
                radius: current_interaction_circle.width/2
                y: next.width * 0.0125
            }

            PropertyChanges {
                target: current_interaction_title
                y: current.width * 0.27
            }

            PropertyChanges {
                target: current_interaction_description
                y: current.width * 0.35
            }
        },

        State {
            name: "REDUCED_VIEW"
        }
    ]

    Timer {
        id: current_interaction_timer
        interval: 1000
        running: false
        repeat: true
        onTriggered: {
            if(parent.count == 0) running = false
            else parent.count -= 1;
            current_interaction_countdown_label.text = parent.count;
        }
    }

    Rectangle {
        // current interaction countdown circle
        id: current_interaction_circle
        width: parent.width*0.4
        height: width
        radius: width/2
        x: (parent.width*0.5)-radius
        y: -(radius/4)
        color: "#80000000"

        MouseArea {
            anchors.fill: parent
            onClicked: current_interaction_timer.running = true;
        }

        Text {
            // the countdown itself
            id: current_interaction_countdown_label
            anchors.fill: parent
            text: "0"
            color: "#ffffff"
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            font.pointSize: 55
            textFormat: Text.PlainText
            font.family: font_lato_light.name
        }
    }

    Text {
        id: current_interaction_title
        text: "trigger interaction"
        color: "#ffffff"
        width: parent.width
        height: parent.height * 0.2
        y: parent.height * 0.48
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        font.pointSize: 22
        textFormat: Text.PlainText

        MouseArea {
            id: no_current_button
            anchors.fill: parent
        }
    }

    Text {
        id: current_interaction_description
        y: current_interaction_title.height + current_interaction_title.y
        text: "make a whip-like move with the phone in order to trigger the next note..."
        anchors.horizontalCenter: parent.horizontalCenter
        color: "#ffffff"
        height: parent.height * 0.3
        width: parent.width * 0.9
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        font.pointSize: 13
        textFormat: Text.PlainText
        wrapMode: Text.WordWrap
        font.family: font_lato_light.name
        antialiasing: true
    }
}
