import QtQuick 2.0

Rectangle {
    // SECOND UPPER VIEW SECTION
    // used to display next interactions
    // it is composed of 3 elements: the 'NEXT' label
    // the label of the next interaction to come
    property int count: 5

    // NEXT_INTERACTION STATES & TRANSITIONS:
    // currently, four main states in the application:
    // 1 - DEFAULT: for introduction and when there's both next & current interactions
    // 2 - NO-NEXT: when there's no incoming interaction, hide the view
    // 3 - NO-CURRENT: when no current interaction, view extends to full view
    // 4 - NOTHING: same as no-next, not necessary to implement?
    states: [ State { name: "no-next"; when: no_next_button.pressed === true
            PropertyChanges { target: uv_next_interaction_section; x: -width }},
        State { name: "no-current"; when: no_current_button.pressed === true
            PropertyChanges { target: uv_next_interaction_section; height: parent.height *0.9 }
            PropertyChanges { target: uv_next_interaction_section; opacity: 1 }}
    ]

    transitions: [ Transition { from: ""; to: "no-next"; reversible: true
            ParallelAnimation { NumberAnimation { properties: "x";
                    duration: 750; easing.type: Easing.InOutBack }}},
        Transition { from: ""; to: "no-current"; reversible: true
            ParallelAnimation { NumberAnimation { properties: "height";
                    duration: 1500; easing.type: Easing.OutBounce }}},
        Transition { from: "no-next"; to: "no-current"; reversible: true
            ParallelAnimation { NumberAnimation { properties: "height";
                    duration: 1000; easing.type: Easing.InElastic }}}
    ]

    Timer {
        id: uv_next_interaction_timer
        interval: 1000
        running: false
        repeat: true
        onTriggered: {
            if(parent.count == 0) running = false
            else parent.count -= 1;
            uv_next_interaction_countdown_label.text = parent.count;
        }
    }

    Text {
        id: uv_next_interaction_label
        text: "NEXT"
        color: "#ffffff"
        width: parent.width
        height: parent.height
        x: width*0.04
        verticalAlignment: Text.AlignVCenter
        font.pointSize: 20
        font.bold: true
        textFormat: Text.PlainText
        MouseArea {
            id: no_next_button
            anchors.fill: parent
        }
    }

    Text {
        // the title of the next incoming interaction
        id: uv_next_interaction_title
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
        id: uv_next_interaction_circle
        width: parent.height * 0.8
        height: parent.height * 0.8
        color: "#b3ffffff"
        radius: width/2
        x: parent.width * 0.8
        anchors.verticalCenter: parent.verticalCenter

        MouseArea {
            anchors.fill: parent
            onClicked: uv_next_interaction_timer.running = true;
        }

        Text {
            // the countdown display
            id: uv_next_interaction_countdown_label
            anchors.fill: parent
            text: uv_next_interaction_section.count
            color: "#000000"
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            font.pointSize: 30
            textFormat: Text.PlainText
        }
    }
}
