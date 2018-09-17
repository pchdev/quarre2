import QtQuick 2.0
import WPN114 1.0 as WPN114
import Quarre 1.0

Item
{
    WPN114.Node
    {
        path: "/modules"

        onValueReceived:
        {
            // should parse a stringlist
            // and send it to the download manager
            // then request each file
            download_manager.setQueue(newValue);
        }
    }

    DownloadManager
    {
        id: download_manager
        hostAddr: client.hostAddr
        hostPort: client.port
        destination: "/modules"
    }
}
