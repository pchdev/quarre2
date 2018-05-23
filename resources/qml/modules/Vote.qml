import QtQuick 2.0
import Ossia 1.0 as Ossia

Rectangle
{
    id: frame
    anchors.fill: parent
    color: "transparent"

    property int choice: 0

    Ossia.Binding
    {
        device: ossia_net.client
        node:   ossia_net.format_user_parameter('/vote/choice');
        on:     choice
    }

    Rectangle
    {
        id: tree_rect
        property bool selected: false

        x:          parent.width*0.2
        y:          parent.height*0.1
        width:      parent.width*0.25
        height:     parent.height*0.4

        color: "#282a2d"
        border.width: 10
        border.color: "black"
        opacity: 0.7

        onSelectedChanged:
        {
            if ( selected )
            {
                color = "darkgray";
                mountain_rect.selected = false;
                choice = 1;
            }
            else
            {
                color = "#282a2d"
                if ( !mountain_rect.selected ) choice = 0;
            }
        }

        Image
        {
            id: tree
            antialiasing: true
            anchors.fill: parent
            fillMode: Image.PreserveAspectFit
            source: "modules/tree.png"

            transform: Scale
            {
                origin.x : tree_rect.width/2
                origin.y: tree_rect.height/2
                xScale: 0.7
                yScale: 0.7
            }
        }

        MouseArea
        {
            anchors.fill: parent
            onClicked: parent.selected = !parent.selected;
        }
    }

    Text
    {
        text:       "bois"
        color:      "#ffffff"

        width:      tree_rect.width
        x:          tree_rect.x
        y:          parent.height * 0.55

        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        font.pointSize: 16 * root.fontRatio
        textFormat: Text.PlainText
        font.family: font_lato_light.name
    }

    Rectangle
    {
        id: mountain_rect
        property bool selected: false

        x:          parent.width*0.55
        y:          parent.height*0.1
        width:      parent.width*0.25
        height:     parent.height*0.4

        color: "#282a2d"
        border.width: 10
        border.color: "black"
        opacity: 0.7

        onSelectedChanged:
        {
            if ( selected )
            {
                color = "darkgray";
                tree_rect.selected = false;
                choice = 2;
            }
            else
            {
                color = "#282a2d"
                if ( !tree_rect.selected ) choice = 0;
            }
        }

        Image
        {
            id: mountain
            antialiasing: true
            anchors.fill: parent
            fillMode: Image.PreserveAspectCrop
            source: "modules/mountain.png"

            transform: Scale
            {
                origin.x : mountain_rect.width/2
                origin.y: mountain_rect.height/2
                xScale: 0.7
                yScale: 0.7
            }
        }

        MouseArea
        {
            anchors.fill: parent
            onClicked: parent.selected = !parent.selected;
        }
    }

    Text
    {
        text:       "pierre"
        color:      "#ffffff"

        width:      mountain_rect.width
        x:          mountain_rect.x
        y:          parent.height * 0.55

        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        font.pointSize: 16 * root.fontRatio
        textFormat: Text.PlainText
        font.family: font_lato_light.name
    }


}
