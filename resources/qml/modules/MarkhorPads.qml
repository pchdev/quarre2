import QtQuick 2.0
import "items"

Rectangle
{
    property int num_pads: 12
    property var pads_status: Array.new(num_pads);
    property var pushed_pads: []

    id: markhor_pads
    color: "transparent"

    function pressed(i,b)
    {
        pads_status[i] = b;

        if ( b )
        {
            for ( var j = 0; j < pushed_pads.length; ++j )
                pad_repeater.itemAt(pushed_pads[j]).release();

            pushed_pads.push(i);
            ossia_modules.markhor_pads_index = i;
            pad_repeater.itemAt(i).push();
        }

        else
        {
            // remove pad from array
            for ( var k = 0; k < pushed_pads.length; ++j )
                if ( i === pushed_pads[k] )
                    pushed_pads.splice(k);

            // release pad in gui
            pad_repeater.itemAt(i).release();

            // light the last pressed pad if any
            if ( pushed_pads.length > 0 )
            {
                pad_repeater.itemAt(pushed_pads[pushed_pads.length-1]).push();
                ossia_modules.markhor_pads_index = pushed_pads[pushed_pads.length-1];
            }

            else ossia_modules.markhor_pads_index = 0;
        }
    }

    Grid
    {
        columns: 4
        rows: 3
        spacing: 20
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter

        Repeater
        {
            id: pad_repeater
            model: num_pads

            QuarrePad
            {
                id:         target
                width:      module.width/6
                height:     module.width/6
                index:      index
            }
        }
    }
}
