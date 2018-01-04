import QtQuick 2.0

Item {

    states: [

        State {
            name: "CONNECTING"
            // application logo + connection wheel
            PropertyChanges {
                target: upper_view.header
                height: root.height
            }
        },

        State {
            name: "CONNECTION_FAILED"
            // connection wheel stops turning, button to try reconnection appears
            /*PropertyChanges {
                target:
                height: root.height
            }*/
        },

        State {
            name: "IDLE"
            // connection established
            // header takes the whole upper view
            // please wait until next event label
           /* PropertyChanges {
                when: no_info_button.pressed === true
                target: uv_header_section
                height: uv_header_section.parent.height
            }*/
        },

        State {
            name: "INCOMING_INTERACTION"
            // next section takes the upper ViewSection
            // NEXT label on top
            /*PropertyChanges {
                target: uv_header_section
                height: uv_header_section.parent.height * 0.1
            }*/
        },

        State {
            name: "ACTIVE_INTERACTION"
            /*PropertyChanges {
                target: uv_header_section
                height: uv_header_section.parent.height * 0.1
            }*/
        },

        State {
            name: "ACTIVE_AND_INCOMING_INTERACTIONS"
            /*PropertyChanges {
                target: uv_header_section
                height: uv_header_section.parent.height * 0.1
            }*/
        }
    ]
}
