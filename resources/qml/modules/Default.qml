import QtQuick 2.0
import Ossia 1.0 as Ossia

Rectangle
{
    color: "transparent"
    anchors.fill: parent

    Image
    {
        id: teaser_claw
        antialiasing: true
        fillMode: Image.PreserveAspectCrop
        source: "qrc:/teaser/white.png"
        x: parent.width/1.5
        y: parent.height *0.1
        opacity: 0.2
    }

    Text
    {
        id: quarre_log
        width: parent.width
        height: parent.height
        horizontalAlignment: Text.AlignHCenter
        y: parent.height*0.25
        font.family: font_lato_light.name
        font.pointSize: 50 * root.fontRatio
        textFormat: Text.PlainText
        color: "#ffffff"
        text: "quarrè"
        antialiasing: true
    }

    SequentialAnimation // ---------------------------------------------------- COUNTDOWN_ANIMATION
    {
        id:     title_xfade
        loops:  Animation.Infinite
        running: true

        NumberAnimation
        {
            target: quarre_log
            property: "opacity"
            from: 1.0
            to: 0.1
            duration: 5000
        }

        NumberAnimation
        {
            target: quarre_log
            property: "opacity"
            from: 0.1
            to: 1.0
            duration: 5000
        }
    }
}
