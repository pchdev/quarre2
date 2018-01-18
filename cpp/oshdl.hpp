#ifndef OSBRIDGE_H
#define OSBRIDGE_H

#ifdef ANDROID
#include "jni.h"
#include <QtAndroid>
#include <QtAndroidExtras/QAndroidJniObject>
#include <QAndroidJniEnvironment>
#endif
#include <QTimer>

namespace quarre {

class platform_hdl : public QObject {

    Q_OBJECT
    Q_PROPERTY(QString hostAddr READ hostAddr WRITE setHostAddr NOTIFY hostAddrChanged)
    Q_PROPERTY(quint16 port READ port WRITE setPort)

public:
    platform_hdl();
    ~platform_hdl();
    static platform_hdl* singleton;

    QString hostAddr() const;
    quint16 port() const;
    void setHostAddr(QString addr);
    void setPort(quint16 port);

signals:
    void hostAddrChanged();
    void disconnected();

public slots:    
    void vibrate(int milliseconds)  const;
    void register_zeroconf(QString name, QString type, quint16 port);

private:
    QString                 m_hostAddr;
    quint16                 m_port;
#ifdef Q_OS_ANDROID
    QAndroidJniObject       m_vibrator;
    QAndroidJniObject       m_wakelock;
#endif

};

}

#endif // OSBRIDGE_H
