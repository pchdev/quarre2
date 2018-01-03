import QtQuick 2.0

Rectangle {
    // THIRD UPPER VIEW SECTION
    property int count: 47

    states: [ State { name: "no-next"; when: no_next_button.pressed == true
            PropertyChanges { target: uv_current_interaction_section; height: parent.height *0.9 }
            PropertyChanges { target: uv_current_interaction_section; y: parent.height * 0.1 }},
        State { name: "no-current"; when: no_current_button.pressed == true
            PropertyChanges { target: uv_current_interaction_section; opacity: 0 }}
    ]

    transitions: [ Transition { from: ""; to: "no-next"; reversible: true
            ParallelAnimation { NumberAnimation { properties: "height, y";
                    duration: 750; easing.type: Easing.InOutBack }}},
        Transition { from: ""; to: "no-current"; reversible: true
            ParallelAnimation { NumberAnimation { properties: "opacity";
                    duration: 500; easing.type: Easing.InOutSine }}},
        Transition { from: "no-next"; to: "no-current"; reversible: true
            ParallelAnimation { NumberAnimation { properties: "opacity";
                    duration: 1000; easing.type: Easing.InElastic }}}
    ]

    Timer {
        id: uv_current_interaction_timer
        interval: 1000
        running: false
        repeat: true
        onTriggered: {
            if(parent.count == 0) running = false
            else parent.count -= 1;
            uv_current_interaction_countdown_label.text = parent.count;
        }
    }

    Rectangle {
        // current interaction countdown circle
        id: uv_current_interaction_circle
        width: parent.width*0.4
        height: width
        radius: width/2
        x: (parent.width*0.5)-radius
        y: -(radius/4)
        color: "#80000000"

        MouseArea {
            anchors.fill: parent
            onClicked: uv_current_interaction_timer.running = true;
        }

        Text {
            // the countdown itself
            id: uv_current_interaction_countdown_label
            anchors.fill: parent
            text: "47"
            color: "#ffffff"
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            font.pointSize: 55
            textFormat: Text.PlainText
            font.family: font_lato_light.name
        }
    }

    Text {
        id: uv_current_interaction_title
        text: "trigger interaction"
        color: "#ffffff"
        width: parent.width
        height: parent.height * 0.2
        y: parent.height * 0.48
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        font.pointSize: 22
        //font.bold: true
        textFormat: Text.PlainText

        MouseArea {
            id: no_current_button
            anchors.fill: parent
        }
    }

    Text {
        id: uv_current_interaction_description
        y: uv_current_interaction_title.height + uv_current_interaction_title.y
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
