import QtQuick 2.0
import Ossia 1.0 as Ossia

Rectangle
{
    Ossia.Callback
    {
        device:     ossia_net.client
        node:       '/common/transitions/name'
    }

}
