import QtQuick 2.0

Rectangle {
    // SECOND UPPER VIEW SECTION
    // used to display next interactions
    // it is composed of 3 elements: the 'NEXT' label
    // the label of the next interaction to come
    property int count: 5

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
        MouseArea {
            id: no_next_button
            anchors.fill: parent
        }
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

        MouseArea {
            anchors.fill: parent
            onClicked: next_interaction_timer.running = true;
        }

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
