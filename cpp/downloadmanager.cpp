#include "downloadmanager.hpp"
#include <QtDebug>
#include <QStandardPaths>
#include <QDir>

DownloadManager::DownloadManager()
{
    m_modules_path = QStandardPaths::writableLocation(QStandardPaths::AppDataLocation).append("/modules");
    if ( !QDir(m_modules_path).exists()) QDir().mkdir(m_modules_path);
}

void DownloadManager::setQueue(QStringList queue)
{
    m_downloads = queue;

    for ( const auto& file : queue )
        m_queue.enqueue(toUrl(file));

    next();
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

    QString path = m_downloads.first().prepend("/").prepend(m_modules_path);
    m_output.setFileName(path);

    if ( !m_output.open(QIODevice::WriteOnly | QIODevice::Text ) )
    {
        qDebug() << "error opening file for writing";
        qDebug() << path;
        qDebug() << m_output.errorString();
        return;
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
    QObject::disconnect(m_current_download, SIGNAL(readyRead()), this, SLOT(onReadyRead()));
    QObject::disconnect(m_current_download, SIGNAL(finished()), this, SLOT(onComplete()));
    m_current_download->deleteLater();
    m_downloads.removeFirst();

    next();
}
