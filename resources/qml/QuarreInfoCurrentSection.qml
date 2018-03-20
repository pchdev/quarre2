import QtQuick 2.0

Rectangle {

    property int    count:          0
    property alias  timer:          current_interaction_timer
    property alias  title:          current_interaction_title.text
    property alias  description:    current_interaction_description.text

    states: [

        State //--------------------------------------------------- STATE_FULL_VIEW
        {
            name:           "FULL_VIEW"
            PropertyChanges
            {
                target:     current_interaction_circle
                width:      current.width * 0.38
                height:     current_interaction_circle.width
                radius:     current_interaction_circle.width/2
                y:          next.width * 0.0125
            }

            PropertyChanges //------------------------------ current_interaction_title
            {
                target: current_interaction_title
                y: current.width * 0.35
            }

            PropertyChanges //------------------------------ current_interaction_description
            {
                target: current_interaction_description
                y: current.width * 0.39
            }
        },

        State //--------------------------------------------------- STATE_REDUCED_VIEW
        {
            name: "REDUCED_VIEW"
        }
    ]

    Timer //------------------------------------------------------------- TIMER
    {
        id:         current_interaction_timer
        interval:   1000
        running:    false
        repeat:     true

        onRunningChanged: title_xfade.running = current_interaction_timer.running;

        onTriggered:
        {
            if(parent.count == 0) running = false
            else parent.count -= 1;
            current_interaction_countdown_label.text = parent.count;
        }
    }

    SequentialAnimation // ---------------------------------------------------- COUNTDOWN_ANIMATION
    {

        id: title_xfade
        loops: Animation.Infinite

        NumberAnimation
        {
            target: current_interaction_countdown_label
            property: "opacity"
            from: 1.0
            to: 0.1
            duration: 1000
        }

        NumberAnimation
        {
            target: current_interaction_countdown_label
            property: "opacity"
            from: 0.1
            to: 1.0
            duration: 1000
        }
    }

    Rectangle //----------------------------------------------------------- BACKGROUND
    {
        id:             background_color

        color:          "#3a0505"
        opacity:        0.2
        anchors.fill:   parent
    }

    Rectangle //----------------------------------------------------------- CIRCLE
    {
        id:         current_interaction_circle
        width:      parent.width*0.4
        height:     width
        radius:     width/2
        x:          (parent.width*0.5)-radius
        y:          -(radius/4)
        color:      "#80000000"

        MouseArea
        {
            anchors.fill: parent
            onClicked: current_interaction_timer.running = true;
        }

        Text
        {
            // the countdown itself
            id: current_interaction_countdown_label
            anchors.fill: parent
            text: "0"
            color: "#ffffff"
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            font.pointSize: 55 * root.fontRatio
            textFormat: Text.PlainText
            font.family: font_lato_light.name
        }
    }

    Rectangle //------------------------------------------------------------- INFO_RECT_BG
    {
        color: "black"
        opacity: 0.35
        width: parent.width
        height: parent.height *0.5
        y: current.width * 0.35
    }

    Text //---------------------------------------------------------------- CURRENT_TITLE
    {
        id: current_interaction_title
        text: "trigger interaction"
        color: "#ffffff"
        width: parent.width
        height: parent.height * 0.2
        y: parent.height * 0.55
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        font.pointSize: 22 * root.fontRatio
        textFormat: Text.PlainText
        font.family: font_lato_light.name

        MouseArea
        {
            id: no_current_button
            anchors.fill: parent
        }
    }

    Text //---------------------------------------------------------------- CURRENT_DESCRIPTION
    {
        id: current_interaction_description
        y: current_interaction_title.height + current_interaction_title.y
        text: "no description"
        anchors.horizontalCenter: parent.horizontalCenter
        color: "#ffffff"
        height: parent.height * 0.3
        width: parent.width * 0.9
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        font.pointSize: 13 * root.fontRatio
        textFormat: Text.PlainText
        wrapMode: Text.WordWrap
        font.family: font_lato_light.name
        antialiasing: true
    }
}
