import QtQuick 2.7
import QtQuick.Window 2.2
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import Ossia 1.0 as Ossia

import "application"
import "modules"
import "engine"
import "views"

ApplicationWindow
{
    id:         root
    visible:    true
    title:      qsTr("quarrè-remote")

    // --------------------------------------------------------------------------------------------------

    // note: reference is based on Samsung S7
    property real refPd: 17.067
    property real refHeight: 1848
    property real refWidth: 1080

    // for the purpose of testing on macOS:
    // MacBook Pro 9.2, late 2012 (13")
    // replace width with Screen.desktopAvailableWidth
    height: Screen.height
    width: Screen.width
    property real currPd: Screen.pixelDensity

    // refer to this when calculating font sizes
    property real ratio:        Math.min(height/refHeight, width/refWidth)
    property real fontRatio:    Math.min(height*refPd/(currPd*refHeight), width*refPd/(currPd*refWidth))

    FontLoader
    {
        id: font_lato_light
        source: "lato/Lato-Light.ttf"
    }

    onClosing:
    {
        console.log("closing");
        close.accepted = true;
    }    

    // --------------------------------------------------------------------------------------------------

    Item
    { //            QUARRE_APPLICATION_BASE

        id:         quarre_application
        height:     parent.height
        width:      parent.width
        focus:      true

        property alias network:     ossia_net
        property alias upper_view:  upper_view
        property alias lower_view:  lower_view

        // preventing back key to quit application
        Keys.onReleased:
        {
            if(event.key === Qt.Key_Back)
                event.accepted = true;
        }

        InteractionManager      { id: interaction_manager }
        GestureManager          { id: gesture_manager }
        SensorManager           { id: sensor_manager }
        NetworkManager          { id: ossia_net; deviceName: "quarre-remote" }
        OssiaModuleParameters   { id: ossia_modules }

        ApplicationStates //------------------------------------------------------ MAIN_STATES
        {
            id: quarre_states

            Component.onCompleted:
            {
                quarre_application.states   = quarre_states.states
                quarre_application.state    = "DISCONNECTED"
                ossia_net.oshdl.connect();
            }
        }

        ApplicationTransitions //------------------------------------------------ MAIN_TRANSITIONS
        {
            id: quarre_transitions

            Component.onCompleted:
                quarre_application.transitions = quarre_transitions.transitions
        }

        Image //----------------------------------------------------------------- GUI
        {
            // note that having low & high-dpi separate files would be a good idea
            id: quarre_background
            antialiasing: true
            anchors.fill: parent
            fillMode: Image.PreserveAspectCrop
            source: "background/quarre.jpg"

            UpperView //------------------------------------------------------ UPPER_VIEW
            {
                id:         upper_view

                width:      parent.width
                height:     parent.height * 0.45
                color:      "black"
                opacity:    0.9

            }

            Rectangle //------------------------------------------------------ INTERACTION_MODULES
            {
                id:         lower_view

                y:          upper_view.height
                width:      parent.width
                height:     parent.height * 0.55
                color:      "black"
                opacity:    0.75

                Loader
                {
                    id: module_loader
                    anchors.fill: parent
                    source: "modules/Default.qml"
                }

                Rectangle //------------------------------------------------ INACTIVE_RECT
                {
                    id: grey_out_stack
                    anchors.fill: parent
                    color: "#2f302f"
                    opacity: 0.0

                    Text
                    {
                        id:         inactive_text
                        text:       "inactif, en attente..."
                        color:      "#ffffff"
                        wrapMode:   Text.WordWrap
                        anchors.fill: parent

                        horizontalAlignment:  Text.AlignHCenter
                        verticalAlignment:    Text.AlignVCenter
                        font.pointSize:       18 * root.fontRatio
                        font.family:          font_lato_light.name
                        antialiasing:         true
                    }
                }

                NumberAnimation //----------------------------------------- INACTIVE_ANIMATION
                {
                    id: grey_animation_in
                    target: grey_out_stack
                    property: "opacity"
                    from: 0.0; to: 0.7;
                    duration: 1000
                }

                NumberAnimation
                {
                    id: grey_animation_out
                    target: grey_out_stack
                    property: "opacity"
                    from: 0.7; to: 0.0;
                    duration: 1000
                }
            }
        }
    }

    Rectangle
    {
        id: flash
        anchors.fill: parent
        opacity: 0
    }
}
