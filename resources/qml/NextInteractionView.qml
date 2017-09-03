import QtQuick 2.0

Item  {

    y: header_bar.height
    width: parent.width
    height: parent.height/2 -25

    property alias color: niv_bgnd.color

    // STATES ------------------------------------------------------------------

    states: [ State { name: "no-next"; when: connect_button.pressed
            PropertyChanges { target: next_row; height: 0 }
            PropertyChanges { target: next_timer_label; font.pixelSize: 0 }},
        State { name: "no-current"; when: prefs_button.pressed
            PropertyChanges { target: next_row; height: parent.height * 0.625 }}
    ]

    // TRANSITIONS -----------------------------------------------------------

    transitions: [ Transition { from: ""; to: "no-next"; reversible: true
            ParallelAnimation { NumberAnimation { properties: "height";
                    duration: 1000; easing.type: Easing.InOutBack }}},
        Transition { from: ""; to: "no-current"; reversible: true
            ParallelAnimation { NumberAnimation { properties: "height";
                    duration: 1500; easing.type: Easing.OutBounce }}}
    ]

    Rectangle {

        id: niv_bgnd
        anchors.fill: parent
        color: "#33001a09"

        Text {

            id: next_label
            y: 52
            width: 106
            height: 72
            color: "#ffffff"
            text: qsTr("NEXT")
            anchors.verticalCenterOffset: 0
            font.weight: Font.ExtraBold
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 8
            textFormat: Text.PlainText
            verticalAlignment: Text.AlignVCenter
            font.pixelSize: 20
            horizontalAlignment: Text.AlignHCenter

            // STATES ------------------------------------------------------------------

           states: [ State { name: "no-next"; when: connect_button.pressed
                    PropertyChanges { target: next_label; anchors.leftMargin: -844 }},
                State { name: "no-current"; when: prefs_button.pressed
                    PropertyChanges { target: next_label; anchors.verticalCenterOffset: -50 }}
            ]

            // TRANSITIONS -----------------------------------------------------------

            transitions: [ Transition { from: ""; to: "no-next"; reversible: true
                    ParallelAnimation { NumberAnimation { properties: "anchors.leftMargin";
                            duration: 500; easing.type: Easing.InOutBack }}},
                Transition { from: ""; to: "no-current"; reversible: true
                    ParallelAnimation { NumberAnimation { properties: "anchors.verticalCenterOffset";
                            duration: 500; easing.type: Easing.InOutBack }}}
            ]
        }

        Text {

            id: next_interaction_label
            x: 0
            y: 57
            width: 288
            height: 60
            color: "#ffffff"
            text: qsTr("some interaction")
            anchors.verticalCenterOffset: 0
            textFormat: Text.PlainText
            verticalAlignment: Text.AlignVCenter
            font.pixelSize: 20
            anchors.left: parent.left
            font.weight: Font.ExtraBold
            horizontalAlignment: Text.AlignHCenter
            anchors.leftMargin: 120
            anchors.verticalCenter: parent.verticalCenter
        }

        Rectangle {

            id: next_circle
            x: 480
            y: 0
            width: 150
            height: 150
            color: "#19ffffff"
            radius: 75
            anchors.verticalCenterOffset: 0
            anchors.horizontalCenterOffset: 176
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter

            // STATES ------------------------------------------------------------------

            states: [ State { name: "no-next"; when: connect_button.pressed
                    PropertyChanges { target: next_circle; width: 0; height: 0 }},
                State { name: "no-current"; when: prefs_button.pressed
                    PropertyChanges { target: next_circle; anchors.horizontalCenter: 0 }}
            ]

            // TRANSITIONS -------------------------------------------------------------

            transitions: [ Transition { from: ""; to: "no-next"; reversible: true
                    ParallelAnimation { NumberAnimation { properties: "width, height, font.pixelSize";
                            duration: 500; easing.type: Easing.InOutBack }}},
                Transition { from: ""; to: "no-current"; reversible: true
                    ParallelAnimation { NumberAnimation { properties: "anchors.horizontalCenter";
                            duration: 1000; easing.type: Easing.InOutBack }}}
            ]

            Text {

                id: next_timer_label
                y: 52
                width: 100
                height: 100
                color: "#ffffff"
                text: qsTr("29")
                textFormat: Text.PlainText
                anchors.verticalCenterOffset: 0
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: 40
                anchors.left: parent.left
                font.weight: Font.ExtraBold
                horizontalAlignment: Text.AlignHCenter
                anchors.leftMargin: 25
                anchors.verticalCenter: parent.verticalCenter

            }
        }
    }
}
