import QtQuick 2.0
import WPN114 1.0 as WPN114
import Quarre 1.0

Item
{
    property string module_path: "file:///data/user/0/org.quarre.remote/files/modules/";

    WPN114.OSCQueryClient
    {
        id: download_client
        zeroConfHost: "quarre-server"

        onTreeComplete:
        {
            module_loader.source = module_path+"basics/GestureHammer.qml"
        }
    }
}
