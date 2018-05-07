import QtQuick 2.0

Item
{
    property int module_on_hold: -1

    function prepare_next ( arglist )
    {
        // arg0: title
        // arg1: description
        // arg2: module
        // arg3: length
        // arg4: countdown

        if ( arglist[0] === undefined || arglist[0] === "" )
            return;

        ossia_net.oshdl.vibrate(200);

        if  ( arglist[4] === "inf" )
        {
            upper_view.next.count = -1;
            upper_view.next.countdown = "inf";
        }

        else
        {
            upper_view.next.countdown  = arglist[4];
            upper_view.next.count      = arglist[4];
        }

        upper_view.next.title           = arglist[0];
        upper_view.next.description     = arglist[1];
        upper_view.next.timer.start     ( );

        var new_stack_index = -1;

        switch ( arglist[2] )
        {
        case "Default": new_stack_index = 0; break;
        case "Transition": new_stack_index = 2; break;
        case "Vote" : new_stack_index = 3; break;
        case "Gesture": new_stack_index = 4; break;
        case "Pads": new_stack_index = 5; break;
        case "Sliders": new_stack_index = 6; break;
        case "Strings": new_stack_index = 7; break;
        case "TouchSpatialization": new_stack_index = 8; break;
        case "SensorSpatialization": new_stack_index = 9; break;
        }

        if ( quarre_application.state === "IDLE" )
        {
            quarre_application.state        = "INCOMING_INTERACTION";
            lower_view_stack.enabled        = false;
            grey_animation_in.running       = true;
            lower_view_stack.currentIndex   = new_stack_index;
        }

        else if(quarre_application.state === "ACTIVE_INTERACTION")
        {
            quarre_application.state = "ACTIVE_AND_INCOMING_INTERACTIONS";
            module_on_hold = new_stack_index;
        }
    }

    function trigger_next(arglist)
    {
        // arg0: title
        // arg1: description
        // arg2: module
        // arg3: length

        if ( arglist[0] === undefined || arglist[0] === "" )
            return;

        if  ( arglist[3] === -1 )
        {
            upper_view.current.count = -1;
            upper_view.current.countdown = "inf";
        }

        else
        {
            upper_view.current.count        = arglist[3];
            upper_view.current.countdown    = arglist[3];
        }

        upper_view.current.title            = arglist[0];
        upper_view.current.description      = arglist[1];
        upper_view.current.timer.start();

        upper_view.next.title = ""
        upper_view.next.count = 0;
        upper_view.next.timer.stop();

        switch ( arglist[2] )
        {
        case "Default": lower_view_stack.currentIndex = 0; break;
        case "Transition": lower_view_stack.currentIndex = 2; break;
        case "Vote" : lower_view_stack.currentIndex = 3; break;
        case "Gesture": lower_view_stack.currentIndex = 4; break;
        case "Pads": lower_view_stack.currentIndex = 5; break;
        case "Sliders": lower_view_stack.currentIndex = 6; break;
        case "Strings": lower_view_stack.currentIndex = 7; break;
        case "TouchSpatialization": lower_view_stack.currentIndex = 8; break;
        case "SensorSpatialization": lower_view_stack.currentIndex = 9; break;
        }

        if ( grey_out_stack.opacity == 0.7 )
            grey_animation_out.running = true;

        lower_view_stack.enabled = true;

        if ( quarre_application.state === "IDLE" ||
           quarre_application.state === "INCOMING_INTERACTION" )
           quarre_application.state = "ACTIVE_INTERACTION";

        module_on_hold = -1;
        ossia_net.oshdl.vibrate(300);
    }

    function end_current()
    {
        upper_view.current.title            = "";
        upper_view.current.description      = "";
        upper_view.current.count            = 0;
        upper_view.current.timer.stop();

        if ( quarre_application.state === "ACTIVE_INTERACTION" )
        {
            quarre_application.state = "IDLE";
            lower_view_stack.currentIndex = 1;
        }

        else if ( quarre_application.state === "ACTIVE_AND_INCOMING_INTERACTIONS" )
        {
            quarre_application.state = "INCOMING_INTERACTION";
            if ( module_on_hold > 0 )
            {
                lower_view_stack.currentIndex = module_on_hold;
                grey_animation_in.running = true;
            }
        }

        ossia_net.oshdl.vibrate(100);
    }

    function reset ( )
    {
        upper_view.current.title            = "";
        upper_view.current.description      = "";
        upper_view.current.count            = 0;
        upper_view.current.timer.stop();

        upper_view.next.title            = "";
        upper_view.next.description      = "";
        upper_view.next.count            = 0;
        upper_view.next.timer.stop();

        quarre_application.state        = "IDLE";
    }

    function force_current ( module_index )
    {
        quarre_application.state        = "IDLE";
        upper_view.header.scene.text    = "playground";
        lower_view_stack.currentIndex   = module_index;
    }
}
