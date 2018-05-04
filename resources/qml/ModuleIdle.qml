import QtQuick 2.0

Rectangle
{

    Text
    {
        id:     quarre_idle_text
        color:  "#ffffff"
        text:   "veuillez patienter jusqu'à la prochaine interaction"

        y:      parent.height*0.25
        width:  parent.width
        height: parent.height
        horizontalAlignment: Text.AlignHCenter

        font.family:    font_lato_light.name
        font.pointSize: root.fontRatio * 50
        textFormat:     Text.PlainText
        antialiasing:   true
        wrapMode:       Text.WordWrap
    }

    SequentialAnimation // ---------------------------------------------------- COUNTDOWN_ANIMATION
    {
        id:     title_xfade
        loops:  Animation.Infinite

        NumberAnimation
        {
            target: quarre_idle_text
            property: "opacity"
            from: 1.0
            to: 0.1
            duration: 1000
        }

        NumberAnimation
        {
            target: quarre_idle_text
            property: "opacity"
            from: 0.1
            to: 1.0
            duration: 1000
        }
    }

}
