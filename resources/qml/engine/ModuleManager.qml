import QtQuick 2.0
import WPN114 1.0 as WPN114
import Quarre 1.0

Item
{
    property string path: "file:///data/user/0/org.quarre.remote/files/modules/";
    function fmt(str) { return path+str }

    WPN114.OSCQueryClient
    {
        id: download_client
        zeroConfHost: "quarre-server"

        onTreeComplete: console.log("tree completed");
    }
}
