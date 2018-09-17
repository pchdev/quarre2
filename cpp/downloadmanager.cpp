#include "downloadmanager.hpp"
#include <QtDebug>

DownloadManager::DownloadManager()
{

}

void DownloadManager::setQueue(QStringList queue)
{
    m_downloads = queue;

    for ( const auto& file : queue )
        m_queue.enqueue(toUrl(file));
}

QUrl DownloadManager::toUrl(QString file)
{
    QString root = m_host_addr.prepend("http://").append(":").append(QString::number(m_host_port));
    root.append(file.prepend("/"));

    return QUrl(root);
}

void DownloadManager::next()
{
    if ( m_queue.isEmpty() )
    {
        emit downloadsComplete();
        return;
    }

    m_output.setFileName(m_downloads.first());

    if ( !m_output.open(QIODevice::WriteOnly) )
    {
        qDebug() << "error opening file for writing";
    }

    QUrl url = m_queue.dequeue();
    QNetworkRequest req(url);

    m_current_download = m_netaccess.get(req);

    QObject::connect(m_current_download, SIGNAL(readyRead()), this, SLOT(onReadyRead()));
    QObject::connect(m_current_download, SIGNAL(finished()), this, SLOT(onComplete()));

}

void DownloadManager::onReadyRead()
{
    m_output.write(m_current_download->readAll());
}

void DownloadManager::onComplete()
{
    m_output.close();
    m_current_download->deleteLater();
    m_downloads.removeFirst();

    next();
}
