import QtQuick 2.0

Rectangle {
    // FIRST UPPER VIEW SECTION
    // used to display time elapsed since the beginning of scenario
    property int count: 0

    function int_to_time(value) {

        var min = Math.floor(value/60), sec = value % 60;
        var min_str, sec_str;

        if(min < 10)
                min_str = "0" + min.toString();
        else    min_str = min.toString();

        if(sec < 10)
                sec_str = "0" + sec.toString();
        else    sec_str = sec.toString();

        return min_str + ":" + sec_str;
    }

    Timer {
        id: header_timer
        interval: 1000
        running: true
        repeat: true
        onTriggered: {
            parent.count += 1;
            header_timer_label.text = parent.int_to_time(parent.count);
        }
    }

    Text {
        // NAME OF THE CURRENT SCENARIO
        id: header_scenario_label
        text: "quarrè"
        color: "#ffffff"
        font.pixelSize: 40
        textFormat: Text.PlainText
        font.family: font_lato_light.name
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignLeft
        anchors.fill: parent
        anchors.leftMargin: parent.width * 0.05
        anchors.topMargin: 0
        anchors.bottomMargin: 0
        antialiasing: true
    }

    Text {
        // THE TIMER
        // gets started whenever the device receives
        // a critical 'scenario start' message
        // and stopped at 'scenario end' message
        id: header_timer_label
        text: "02:55"
        color: "#ffffff"
        font.pixelSize: 40
        anchors.fill: parent
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        textFormat: Text.PlainText
        font.family: font_lato_light.name
        antialiasing: true

        MouseArea {
            id: no_info_button
            anchors.fill: parent
        }
    }

    Text {
        // NAME OF THE CURRENT SCENE
        id: header_scene_label
        text: "registration"
        color: "#ffffff"
        font.pixelSize: 40
        textFormat: Text.PlainText
        font.family: font_lato_light.name
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignRight
        anchors.fill: parent
        anchors.rightMargin: parent.width *0.05
        antialiasing: true
    }

}
