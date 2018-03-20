import QtQuick 2.0

Item {

    function prepare_next(arglist)
    {
        // arg0: module_id
        // arg1: interaction length
        // arg2: countdown length
        // arg3: title
        // arg4: description

        if ( arglist[0] === undefined )
            return;

        upper_view.next.title = arglist[3];
        upper_view.next.count = arglist[2];
        upper_view.next.timer.start();

        if(quarre_application.state === "IDLE")
        {
            quarre_application.state        = "INCOMING_INTERACTION";
            lower_view_stack.currentIndex   = arglist[0];
            //! TODO: gray it out to show that module is inactive
        }

        else if(quarre_application.state === "ACTIVE_INTERACTION")
            quarre_application.state = "ACTIVE_AND_INCOMING_INTERACTION";
    }

    function trigger_next(arglist)
    {
        // arg0: module id
        // arg1: interaction length
        // arg2: title
        // arg3: description

        if ( arglist[0] === undefined )
            return;

        upper_view.current.title            = arglist[2];
        upper_view.current.count            = arglist[1]
        upper_view.current.description      = arglist[3];
        upper_view.current.timer.start();

        upper_view.next.title = ""
        upper_view.next.count = 0;
        upper_view.next.timer.stop();

        if(quarre_application.state === "IDLE" ||
           quarre_application.state === "INCOMING_INTERACTION")
           quarre_application.state = "ACTIVE_INTERACTION";
    }

    function end_current()
    {
        upper_view.current.title            = "";
        upper_view.current.description      = "";
        upper_view.current.count            = 0;
        upper_view.current.timer.stop();

        if(quarre_application.state === "ACTIVE_INTERACTION")
            quarre_application.state = "IDLE";

        else if (quarre_application.state === "ACTIVE_AND_INCOMING_INTERACTION")
            quarre_application.state = "INCOMING_INTERACTION";
    }

    function force_current(module_index)
    {
        quarre_application.state        = "IDLE";
        upper_view.header.scene.text    = "playground";
        lower_view_stack.currentIndex   = module_index;
    }

    function parse_interactions_file()
    {
        // no use for now
        var xhr = new XMLHttpRequest;
        xhr.open("GET", path);
        xhr.onreadystatechange = function()
        {
            if(xhr.readyState === XMLHttpRequest.DONE)
            {
                var jsonstr = xhr.responseText;
                jsonobj = JSON.parse(jsonstr);
            }
        };

        xhr.send();
    }
}
