import QtQuick 2.7
import QtQuick.Window 2.2
import QtQuick.Controls 2.0
import Ossia 1.0 as Ossia

ApplicationWindow {

    id:         root
    visible:    true
    title:      qsTr("quarrè-remote")

    // --------------------------------------------------------------------------------------------------
    // note: reference is based on Samsung S7
    property real refDPI: 576
    property real refHeight: 2560
    property real refWidth: 1440

    // for the purpose of testing on macOS:
    // MacBook Pro 9.2, late 2012 (13")
    // replace width with Screen.desktopAvailableWidth
    height: Screen.desktopAvailableHeight
    width: Screen.desktopAvailableWidth
    property real currDPI: 576

    // refer to this when calculating font sizes
    property real ratio: Math.min(height/refHeight, width/refWidth)
    property real fontRatio: Math.min(height*refDPI/(currDPI*refHeight, width*refDPI/(currDPI*refWidth)))

    // --------------------------------------------------------------------------------------------------

    FontLoader {
        id: font_lato_thin
        source: "lato/Lato-Thin.ttf"
    }

    FontLoader {
        id: font_lato_light
        source: "lato/Lato-Light.ttf"
    }

    // --------------------------------------------------------------------------------------------------

    Ossia.OSCQueryServer {
        id: device
        name: "quarre-test-remote"
    }

    Ossia.Parameter {
        id: scenario_start
        node: "/scenario/start"
        critical: true
        valueType: Ossia.Type.Impulse
    }

    Ossia.Parameter {
        // received whenever a problem has happened
        // argument: error code (int)
        id: scenario_stop
        node: "/scenario/stop"
        critical: true
        valueType: Ossia.Type.Integer
    }

    Ossia.Parameter {
        // argument: reason for pause (int)
        id: scenario_pause
        node: "/scenario/pause"
        critical: true
        valueType: Ossia.Type.Integer
    }

    Ossia.Parameter {
        id: scenario_end
        node: "/scenario/end"
        critical: true
        valueType: Ossia.Type.Impulse
    }

    Ossia.Parameter {
        id: interactions_next_incoming
        node: "/interactions/next/incoming"
        critical: true
        valueType: Ossia.Type.Vec3f
    }

    Ossia.Parameter {
        id: interactions_next_begin
        node: "/interactions/next/begin"
        critical: true
        valueType: Ossia.Type.Integer
    }

    Ossia.Parameter {
        id: interactions_next_cancel
        node: "/interactions/next/cancel"
        critical: true
        valueType: Ossia.Type.Integer
    }

    Ossia.Parameter {
        id: interactions_current_end
        node: "/interactions/current/end"
        critical: true
        valueType: Ossia.Type.Integer
    }
    // --------------------------------------------------------------------------------------------------

    Image {
        // note that having low & high-dpi separate files would be a good idea
        id: quarre_background
        antialiasing: true
        anchors.fill: parent
        fillMode: Image.PreserveAspectCrop
        source: "background/quarre.jpg"

        Rectangle {
            // UPPER VIEW
            // consists in 3 separate sections:
            // 1- the timer, which is about 2/10th maybe of the upper view
            // 2- the next_interaction section, maybe 3/10th of the upper view
            // 3- the current_interaction section, 5/10th of the upper_view
            // note that: the different sections should appear and disappear whenever
            // they're useful or not, or need to draw attention from the user
            id: upper_view
            width: parent.width
            height: parent.height/2
            color: "#000000"
            opacity: 0.7

            Rectangle {
                // FIRST UPPER VIEW SECTION
                // used to display time elapsed since the beginning of scenario
                id: uv_header_section

                property int count: 0
                width: parent.width
                height: parent.height*0.1
                color: "#000000"
                opacity: 0.9

                states: [ State { name: "no-info"; when: no_info_button.pressed === true
                        PropertyChanges { target: uv_header_section; height: parent.height }}
                ]

                transitions: [ Transition { from: ""; to: "no-info"; reversible: true
                        ParallelAnimation { NumberAnimation { properties: "height";
                                duration: 750; easing.type: Easing.InOutBack }}}
                ]

                function int_to_time(value) {

                    var min = Math.floor(value/60);
                    var sec = value % 60;
                    var min_str, sec_str;

                    if(min < 10) min_str = "0" + min.toString();
                    else min_str = min.toString();

                    if(sec < 10) sec_str = "0" + sec.toString();
                    else sec_str = sec.toString();

                    return min_str + ":" + sec_str;
                }

                Timer {
                    id: uv_header_timer
                    interval: 1000
                    running: true
                    repeat: true
                    onTriggered: {
                        uv_header_section.count += 1;
                        uv_header_timer_label.text = parent.int_to_time(parent.count);
                    }
                }

                Text {
                    // THE TIMER
                    // gets started whenever the device receives
                    // a critical 'scenario start' message
                    // and stopped at 'scenario end' message
                    id: uv_header_timer_label
                    text: "02:55"
                    color: "#ffffff"
                    font.pixelSize: 40
                    anchors.fill: parent
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    textFormat: Text.PlainText
                    font.family: font_lato_thin.name

                    MouseArea {
                        id: no_info_button
                        anchors.fill: parent
                    }
                }
            }

            Rectangle {
                // SECOND UPPER VIEW SECTION
                // used to display next interactions
                // it is composed of 3 elements: the 'NEXT' label
                // the label of the next interaction to come
                property int count: 5
                id: uv_next_interaction_section
                width: parent.width
                height: parent.height*0.2
                y: uv_header_section.height
                color: "#141f1e"

                // NEXT_INTERACTION STATES & TRANSITIONS:
                // currently, four main states in the application:
                // 1 - DEFAULT: for introduction and when there's both next & current interactions
                // 2 - NO-NEXT: when there's no incoming interaction, hide the view
                // 3 - NO-CURRENT: when no current interaction, view extends to full view
                // 4 - NOTHING: same as no-next, not necessary to implement?
                states: [ State { name: "no-next"; when: no_next_button.pressed === true
                        PropertyChanges { target: uv_next_interaction_section; x: -width }},
                    State { name: "no-current"; when: no_current_button.pressed === true
                        PropertyChanges { target: uv_next_interaction_section; height: parent.height *0.8 }
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
                    font.pointSize: 30
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
                    x: width*0.52
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    font.pointSize: 20
                    textFormat: Text.PlainText
                    wrapMode: Text.WordWrap
                }

                Rectangle {
                    // the countdown circle element
                    id: uv_next_interaction_circle
                    width: parent.width*0.25
                    height: width
                    color: "#b3ffffff"
                    radius: width/2
                    x: parent.width * 0.725
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
                        font.pointSize: 35
                        textFormat: Text.PlainText
                    }
                }
            }

            Rectangle {
                // THIRD UPPER VIEW SECTION
                id: uv_current_interaction_section
                property int count: 47
                width: parent.width
                height: parent.height*0.5
                y: height
                color: "#e60d0000"

                states: [ State { name: "no-next"; when: no_next_button.pressed == true
                        PropertyChanges { target: uv_current_interaction_section; height: parent.height *0.8 }
                        PropertyChanges { target: uv_current_interaction_section; y: parent.height * 0.2 }},
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
                    font.pointSize: 27
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
                    font.pointSize: 20
                    textFormat: Text.PlainText
                    wrapMode: Text.WordWrap
                    //font.family: font_lato_light.name
                    antialiasing: true
                }
            }
        }

        Rectangle {
            // the lower view, for hmi interaction modules
            // modules should be put in separate files, and instantiated as children
            // of the Rectangle
            id: lower_view
            width: parent.width
            height: parent.height/2
            y: parent.height/2
            color: "#000000"
            opacity: 0.9

            Image {
                id: teaser_claw
                antialiasing: true
                fillMode: Image.PreserveAspectCrop
                source: "teaser/white.png"
                x: parent.width/1.5
                y: parent.height *0.1
                opacity: 0.2
            }

            Text {
                id: quarre_log
                width: parent.width
                height: parent.height
                horizontalAlignment: Text.AlignHCenter
                y: parent.height*0.25
                font.family: font_lato_thin.name
                font.pointSize: 50
                textFormat: Text.PlainText
                color: "#ffffff"
                text: "quarrè"
            }
        }
    }
  }
