import QtQuick 2.7
import QtQuick.Window 2.2
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import Ossia 1.0 as Ossia

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

    FontLoader {
        id: font_lato_light
        source: "lato/Lato-Light.ttf"
    }

    /*FontLoader {
        id: font_lato_medium
        source: "lato/Lato-Medium.ttf"
    }*/

    // --------------------------------------------------------------------------------------------------

    Item
    { //            QUARRE APPLICATION BASE

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

        InteractionManager
        {
            id: interaction_manager
        }

        NetworkManager
        {
            id:             ossia_net
            deviceName:     "quarre-remote"
        }

        ApplicationStates
        {
            id: quarre_states

            Component.onCompleted:
            {
                quarre_application.states = quarre_states.states
                quarre_application.state = "IDLE"
            }
        }

        ApplicationTransitions
        {
            id: quarre_transitions

            Component.onCompleted:
            {
                quarre_application.transitions = quarre_transitions.transitions
            }
        }

        //---------------------------------------------------------------------------------------------
        Image
        {
            // note that having low & high-dpi separate files would be a good idea
            id: quarre_background
            antialiasing: true
            anchors.fill: parent
            fillMode: Image.PreserveAspectCrop
            source: "background/quarre.jpg"

            QuarreInfoView //------------------------------------------------- UPPER_VIEW
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

                StackLayout
                {
                    id: lower_view_stack
                    currentIndex: 0
                    anchors.fill: parent

                    QuarreReaperControl
                    {
                        id:         rcontrol
                        color:      "transparent"
                    }

                    QuarreModuleTextViewer
                    {
                        id:         textviewer
                        color:      "transparent"
                    }
                }
            }

            Rectangle //-------------------------------------------------------------- AI_GODMODE
            {

                id:         ai_godmode

                property bool godmode: false;

                width:      parent.width*0.3
                height:     parent.width*0.3
                radius:     width/2
                color:      "white"
                y:          upper_view.height - width/2
                opacity:    0.5

                anchors.horizontalCenter: parent.horizontalCenter

                Text
                {
                    id: ai_godmode_txt
                    anchors.fill: parent
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    text: "AI"
                    color: "black"
                    font.pointSize: 30 * root.fontRatio
                }

                Ossia.Binding
                {
                    device: ossia_net.client
                    node: "/user/" + ossia_net.slot + "/godmode"
                    on: ai_godmode.godmode
                }

                MouseArea
                {
                    anchors.fill: parent
                    onPressed:
                    {
                        ai_godmode.godmode = !ai_godmode.godmode;
                        ossia_net.oshdl.vibrate(100);
                    }
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
