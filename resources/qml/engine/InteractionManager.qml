import QtQuick 2.0

Item
{
    property string module_on_hold: ""

    function prepare_next ( arglist )
    {
        // arg0: title
        // arg1: description
        // arg2: module
        // arg3: length
        // arg4: countdown

        if ( arglist[0] === undefined ||
             arglist[0] === "" )
             return;

        ossia_net.oshdl.vibrate ( 200 );

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

        if ( quarre_application.state === "IDLE" )
        {
            quarre_application.state    = "INCOMING_INTERACTION";
            grey_animation_in.running   = true;
            module_loader.source        = "../modules/" + arglist[2] + ".qml"
            module_loader.item.enabled  = false;
        }

        else if ( quarre_application.state === "ACTIVE_INTERACTION" )
        {
            quarre_application.state = "ACTIVE_AND_INCOMING_INTERACTIONS";
            module_on_hold = arglist[2];
        }

        if ( flash.opacity > 0 )
            flash.opacity = 0;
    }

    function trigger_next(arglist)
    {
        // arg0: title
        // arg1: description
        // arg2: module
        // arg3: length

        if ( arglist[0] === undefined ||
             arglist[0] === "" )
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
        upper_view.current.timer.start      ( );

        upper_view.next.title = ""
        upper_view.next.count = 0;
        upper_view.next.timer.stop();

        if ( grey_out_stack.opacity == 0.7 )
            grey_animation_out.running = true;

        module_loader.item.enabled = true

        if ( quarre_application.state === "IDLE" ||
           quarre_application.state === "INCOMING_INTERACTION" )
           quarre_application.state = "ACTIVE_INTERACTION";

        module_on_hold = "" ;
        ossia_net.oshdl.vibrate(300);
    }

    function end_current()
    {
        upper_view.current.title            = "";
        upper_view.current.description      = "";
        upper_view.current.count            = 0;
        upper_view.current.timer.stop       ( );

        if ( quarre_application.state === "ACTIVE_INTERACTION" )
        {
            quarre_application.state    = "IDLE";
            module_loader.item.enabled  = false;
            module_loader.source        = "../modules/Idle.qml"
        }

        else if ( quarre_application.state === "ACTIVE_AND_INCOMING_INTERACTIONS" )
        {
            quarre_application.state = "INCOMING_INTERACTION";
            if ( module_on_hold != "" )
            {
                module_loader.item.enabled = false;
                module_loader.source = "../modules/" + module_on_hold + ".qml"
                module_loader.item.enabled = false;
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
        upper_view.current.timer.stop       ( );

        upper_view.next.title            = "";
        upper_view.next.description      = "";
        upper_view.next.count            = 0;
        upper_view.next.timer.stop      ( );

        quarre_application.state        = "IDLE";
    }

    function force_current ( module_name )
    {
        if ( module_name === "" ||
             module_name === undefined )
             return;

        quarre_application.state        = "IDLE";
        upper_view.header.scene.text    = "playground";
        module_loader.source            = "../modules/" + module_name + ".qml"

        ossia_net.oshdl.vibrate(50);
    }

    function cancel_incoming ( )
    {

        quarre_application.state = "IDLE";
        module_loader.source = "../modules/Idle.qml"

        grey_animation_out.running = true;

        upper_view.next.title            = "";
        upper_view.next.description      = "";
        upper_view.next.count            = 0;
        upper_view.next.timer.stop      ( );

        ossia_net.oshdl.vibrate(50);
    }
}
