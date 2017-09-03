import QtQuick 2.7
import QtQuick.Window 2.2
import QtQuick.Controls 2.0
import Ossia 1.0 as Ossia

ApplicationWindow {

    id:         root
    visible:    true
    title:      qsTr("quarrè-remote")

    // note: reference is based on Samsung S7
    property real refDPI: 576
    property real refHeight: 2560
    property real refWidth: 1440

    // for the purpose of testing on macOS:
    // MacBook Pro 9.2, late 2012 (13")
    // replace width with Screen.desktopAvailableWidth
    height: Screen.desktopAvailableHeight
    width: 450
    property real currDPI: 113

    // refer to this when calculating font sizes
    property real ratio: Math.min(height/refHeight, width/refWidth)
    property real fontRatio: Math.min(height*refDPI/(currDPI*refHeight, width*refDPI/(currDPI*refWidth)))

    FontLoader {
        id: font_lato_thin
        source: "lato/Lato-Thin.ttf"
    }

    FontLoader {
        id: font_lato_light
        source: "lato/Lato-Light.ttf"
    }

    Image {

        // note that having low & high-dpi separate files would be a good idea
        id: quarre_background
        antialiasing: true
        anchors.fill: parent
        fillMode: Image.PreserveAspectCrop
        source: "background/quarre.jpg"

        Rectangle {

            // UPPER VIEW consists in 3 separate sections:
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
                width: parent.width
                height: parent.height*0.2
                color: "#000000"
                opacity: 0.9

                Text {

                    // THE TIMER
                    // gets started whenever the device receives
                    // a critical 'scenario start' message
                    // and stopped at 'scenario end' message
                    id: uv_header_timer
                    text: "02:55"
                    color: "#ffffff"
                    font.pointSize: 40
                    anchors.fill: parent
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    textFormat: Text.PlainText
                    font.family: font_lato_thin.name
                }
            }

            Rectangle {

                // SECOND UPPER VIEW SECTION
                // used to display next interactions
                // it is composed of 3 elements: the 'NEXT' label
                // the label of the next interaction to come
                id: uv_next_interaction_section
                width: parent.width
                height: parent.height*0.3
                y: uv_header_section.height
                color: "#99001307"

                Text {
                    id: uv_next_label
                    text: "NEXT"
                    color: "#ffffff"
                    width: parent.width
                    height: parent.height
                    x: width*0.04
                    verticalAlignment: Text.AlignVCenter
                    font.pointSize: 30
                    font.bold: true
                    textFormat: Text.PlainText
                }

                Text {

                    // the title of the next incoming interaction
                    id: uv_next_title
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
                    id: uv_next_circle
                    width: parent.width*0.25
                    height: width
                    color: "#b3ffffff"
                    radius: width/2
                    x: parent.width * 0.725

                    Text {

                        // the countdown itself
                        id: uv_next_countdown
                        anchors.fill: parent
                        text: "31"
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
                width: parent.width
                height: parent.height*0.5
                y: height
                color: "#e60d0000"

                Rectangle {

                    // current interaction countdown circle
                    id: uv_current_interaction_circle
                    width: parent.width*0.4
                    height: width
                    radius: width/2
                    x: (parent.width*0.5)-radius
                    y: -(radius/4)
                    color: "#80000000"

                    Text {

                        // the countdown itself
                        id: uv_current_interaction_countdown
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
                    height: parent.height
                    y: height * 0.57
                    horizontalAlignment: Text.AlignHCenter
                    font.pointSize: 27
                    //font.bold: true
                    textFormat: Text.PlainText
                }

                Text {
                    id: uv_current_interaction_description
                    text: "smash your phone against the floor..."
                    color: "#ffffff"
                    width: parent.width
                    height: parent.height
                    y: height * 0.75
                    horizontalAlignment: Text.AlignHCenter
                    font.pointSize: 20
                    textFormat: Text.PlainText
                    //font.family: font_lato_light.name
                    antialiasing: true
                }
            }
        }

        Rectangle {
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
                text: "QUARRE"
            }
        }
    }
  }
