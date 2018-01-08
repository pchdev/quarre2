import QtQuick 2.0

Item {

    transitions: [

        Transition {
            from: "IDLE"
            to: "INCOMING_INTERACTION"
            reversible: true

            SequentialAnimation {
                NumberAnimation {
                    target: upper_view.header
                    property: "height"
                    duration: 250
                    //easing.type: Easing.InElastic
                }

                NumberAnimation {
                    target: upper_view.next
                    property: "x"
                    duration: 250
                    //easing.type: Easing.OutBounce
                }

                NumberAnimation {
                    target: upper_view.next
                    property: "height"
                    duration: 250
                }
            }
        },

        Transition {
            from: "INCOMING_INTERACTION"
            to: "ACTIVE_INTERACTION"
            reversible: true

            ParallelAnimation {
                NumberAnimation {
                    target: upper_view.next
                    property: "height"
                    duration: 250
                }

            }


        }

    ]
}
