import QtQuick 2.0

Item {

    y: header_bar.height + next_interaction_view.height
    width: parent.width
    height: parent.height/2 - 25

    Rectangle {

        anchors.fill: parent
        color: "#4c953434"

        states: [ State { name: "no-next"; when: connect_button.pressed
                PropertyChanges { target: current_row;
                    y: parent.height * 0.1875; height: parent.height * 0.625 }},
            State { name: "no-current"; when: prefs_button.pressed
                PropertyChanges { target: current_row; y: parent.height; height: 0 }}
        ]


        transitions: [ Transition {
                from: ""; to: "no-next"; reversible: true
                ParallelAnimation { NumberAnimation { properties: "y, height";
                        duration: 1250; easing.type: Easing.InOutBack }}},
            Transition { from: ""; to: "no-current"; reversible: true
                ParallelAnimation { NumberAnimation { properties: "y, height";
                        duration: 1000; easing.type: Easing.InOutBack }}}
        ]

        Rectangle {
            id: current_circle
            x: 480
            y: 0
            width: 200
            height: 200
            color: "#99070606"
            radius: 100
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter

            Text {
                id: current_timer_label
                y: 52
                width: 200
                height: 200
                color: "#ffffff"
                text: qsTr("60")
                anchors.verticalCenterOffset: 2
                textFormat: Text.PlainText
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: 50
                anchors.left: parent.left
                font.weight: Font.ExtraBold
                horizontalAlignment: Text.AlignHCenter
                anchors.leftMargin: 0
                anchors.verticalCenter: parent.verticalCenter
            }
        }

        Rectangle {
            id: current_info
            y: parent.height * 0.8125
            width: parent.width
            height: parent.height * 0.1875
            color: "#4c713232"

            Text {
                id: current_interaction_label
                x: 8
                y: 57
                width: 170
                height: 38
                color: "#ffffff"
                text: qsTr("some interaction")
                textFormat: Text.PlainText
                anchors.verticalCenterOffset: 0
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: 20
                //anchors.left: next_label.right
                font.weight: Font.ExtraBold
                horizontalAlignment: Text.AlignHCenter
                anchors.leftMargin: 150
                anchors.verticalCenter: parent.verticalCenter
            }

            Text {
                id: current_descr_label
                x: 240
                y: 61
                width: 300
                height: 50
                color: "#ffffff"
                text: qsTr("description")
                font.family: "Arial"
                textFormat: Text.AutoText
                anchors.verticalCenterOffset: 0
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: 20
                //anchors.left: next_label.right
                font.weight: Font.Normal
                horizontalAlignment: Text.AlignHCenter
                anchors.leftMargin: 150
                anchors.verticalCenter: parent.verticalCenter
            }
        }
    }
}
