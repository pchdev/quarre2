import QtQuick 2.0

Rectangle
{
    property string file: ""
    property var json_obj;

    function parse_interactions_file(path)
    {
        // no use for now
        var xhr = new XMLHttpRequest;
        xhr.open("GET", path);
        xhr.onreadystatechange = function()
        {
            if(xhr.readyState === XMLHttpRequest.DONE)
            {
                var jsonstr = xhr.responseText;
                    json_obj = JSON.parse(jsonstr);
            }
        };

        xhr.send();
    }

    Component.onCompleted:
    {
        parse_interactions_file(file);
        console.log(json_obj[0]);
    }

}
