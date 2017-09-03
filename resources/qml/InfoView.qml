import QtQuick 2.0
import QtQuick.Controls 2.1

Item {

    id: upper_view
    width: parent.width
    height: parent.height / 2

    Rectangle {
        color: "#b3000000"
        border.color: "#66000000"

        HeaderView {
            id: header_bar
        }

        NextInteractionView {
            id: next_interaction_view
        }

        CurrentInteractionView {
            id: current_interaction_view
        }
    }
}

