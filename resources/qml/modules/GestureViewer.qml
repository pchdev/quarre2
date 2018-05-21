import QtQuick 2.0
import Ossia 1.0 as Ossia

Rectangle
{
    property string target: ""
    property alias animation: trigger_animation
    color: "transparent"

    onEnabledChanged:
    {
        if ( !enabled )
        {
            gesture_label.text = "indéterminé";
            gesture_description.text = "veuillez patienter jusqu'à l'activation de l'interaction";
        }
    }

    onTargetChanged:
    {
        if  ( target == "whip" )
        {
            gesture_label.text = "Frappe verticale"
            gesture_description.text = "exécutez un geste peu ample, mais sec, vers le bas, l'appareil vibrera si le geste est reconnu.";
        }

        else if ( target == "cover" )
        {
            gesture_label.text = "Paume flottante"
            gesture_description.text = "approchez la paume de votre main à 3 ou 4 cm de l'appareil, maintenez jusqu'à ce que l'appareil vibre.";
        }

        else if ( target == "shake" )
        {
            gesture_label.text = "Agiter"
            gesture_description.text = "agitez le téléphone sèchement et fermement de gauche à droite ou de bas en haut, jusqu'à ce que l'appareil vibre.";
        }
    }

    Text //------------------------------------------------ GESTURE_LABEL
    {
        id:         gesture_label
        y:          parent.height*0.05
        width:      parent.width
        height:     parent.height
        color:      "#ffffff"
        text:       "aucun geste cible"

        horizontalAlignment:    Text.AlignHCenter
        font.family:            font_lato_light.name
        font.pointSize:         34 * root.fontRatio
        textFormat:             Text.PlainText

        antialiasing: true
    }

    Text //------------------------------------------------ GESTURE_DESCRIPTION
    {
        id:         gesture_description
        y:          parent.height * 0.2
        text:       ""
        color:      "#ffffff"
        height:     parent.height/2
        width:      parent.width * 0.9
        wrapMode:   Text.WordWrap

        horizontalAlignment:        Text.AlignHCenter
        verticalAlignment:          Text.AlignTop
        anchors.horizontalCenter:   parent.horizontalCenter
        font.pointSize:             14 * root.fontRatio
        font.family:                font_lato_light.name
        antialiasing:               true
    }

    Rectangle
    {
        id: trigger_animation_circle
        color: "transparent"
        border.color: "white"
        border.width: 5
        x: parent.width/2 - width/2
        y: parent.height/2 - height/2
    }

    ParallelAnimation
    {
        id: trigger_animation
        NumberAnimation
        {
            target: trigger_animation_circle
            property: "width"
            from: 0
            to: parent.width
            duration: 1250
        }
        NumberAnimation
        {
            target: trigger_animation_circle
            property: "height"
            from: 0
            to: parent.width
            duration: 1250
        }
        NumberAnimation
        {
            target: trigger_animation_circle
            property: "radius"
            from: 0
            to: parent.width*0.5
            duration: 1250
        }
        SequentialAnimation
        {
            NumberAnimation
            {
                target: trigger_animation_circle
                property: "opacity"
                from: 0
                to: 0.8
                duration: 625
            }
            NumberAnimation
            {
                target: trigger_animation_circle
                property: "opacity"
                from: 0.8
                to: 0
                duration: 625
            }
        }
    }
}
