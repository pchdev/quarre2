import QtQuick 2.0
import WPN114 1.0 as WPN114
import Quarre 1.0

Item
{
    WPN114.OSCQueryClient
    {
        id: download_client
        zeroConfHost: "quarre-server"

        onConnected:
        {
            download_manager.hostAddr = hostAddr;
            download_manager.hostPort = port;
        }
    }

    WPN114.Node
    {
        device: download_client

        path: "/modules"
        onValueReceived: download_manager.setQueue(newValue);
    }

    DownloadManager
    {
        id: download_manager
        destination: "/modules"

        // TODO: display a notification popup
        onDownloadsComplete: console.log("modules in sync with server")
    }
}
