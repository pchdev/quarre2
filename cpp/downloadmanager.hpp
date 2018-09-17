#ifndef DOWNLOADMANAGER_HPP
#define DOWNLOADMANAGER_HPP

#include <QObject>
#include <QNetworkAccessManager>
#include <QFile>
#include <QQueue>
#include <QNetworkReply>

class DownloadManager : public QObject
{
    Q_OBJECT

    Q_PROPERTY ( QString hostAddr READ hostAddr WRITE setHostAddr )
    Q_PROPERTY ( int hostPort READ hostPort WRITE setHostPort )
    Q_PROPERTY ( QString destination READ destination WRITE setDestination )

    public:
    DownloadManager();

    Q_INVOKABLE void setQueue(QStringList list);

    QString hostAddr() const { return m_host_addr; }
    quint16 hostPort() const { return m_host_port; }
    QString destination() const { return m_destination; }

    void setHostAddr(QString addr) { m_host_addr = addr; }
    void setHostPort(quint16 port) { m_host_port = port; }
    void setDestination(QString dest) { m_destination = dest; }

    protected slots:
    QUrl toUrl(QString file);
    void next();

    void onReadyRead();
    void onComplete();


    signals:
    void downloadsComplete();

    private:
    QStringList m_downloads;
    QString m_host_addr;
    quint16 m_host_port;
    QString m_destination;

    QNetworkAccessManager m_netaccess;
    QQueue<QUrl> m_queue;
    QFile m_output;
    QNetworkReply* m_current_download;


};

#endif // DOWNLOADMANAGER_HPP
