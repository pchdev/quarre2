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
            PropertyChanges {
                target: upper_view
                opacity: 0.77
            }

            PropertyChanges {
                target: upper_view.header
                height: upper_view.height
                state: "FULL_VIEW"
            }

            PropertyChanges {
                target: upper_view.next
                visible: false
            }
            PropertyChanges {
                target: upper_view.current
                visible: false
            }
        },

        State {
            name: "INCOMING_INTERACTION"
            // next section takes the upper ViewSection
            PropertyChanges {
                target: upper_view.header
                height: upper_view.height * 0.1
                state: "REDUCED_VIEW"

            }

            PropertyChanges {
                target: upper_view.next
                height: upper_view.height * 0.9
                state: "FULL_VIEW"
            }

            PropertyChanges {
                target: upper_view.current
                visible: false
            }
        },

        State {
            name: "ACTIVE_INTERACTION"
            PropertyChanges {
                target: upper_view.header
                height: upper_view.height * 0.1
                state: "REDUCED_VIEW"
            }

            PropertyChanges {
                target: upper_view.current
                height: upper_view.height * 0.9
                y: upper_view.header.height
                state: "FULL_VIEW"
            }

            PropertyChanges {
                target: upper_view.next
                visible: false
            }
        },

        State {
            name: "ACTIVE_AND_INCOMING_INTERACTIONS"
            PropertyChanges {
                target: upper_view.header
                height: upper_view.height * 0.1
                state: "REDUCED_VIEW"
            }

            PropertyChanges {
                target: upper_view.next
                height: upper_view.height * 0.25
                state: "REDUCED_VIEW"
            }
            PropertyChanges {
                target: upper_view.current
                height: upper_view.height * 0.65
                y: upper_view.header.height + upper_view.next.height
                state: "REDUCED_VIEW"
            }
        }
    ]
}
