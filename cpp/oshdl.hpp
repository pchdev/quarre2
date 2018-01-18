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

public:
    platform_hdl();
    ~platform_hdl();
    static platform_hdl* singleton;

    QString hostAddr();
    void setHostAddr(QString addr);

signals:
    void hostAddrChanged();

public slots:    
    void vibrate(int milliseconds)  const;
    void register_zeroconf(QString name, QString type, quint16 port);

private:
    QString                 m_hostAddr;
#ifdef Q_OS_ANDROID
    QAndroidJniObject       m_vibrator;
    QAndroidJniObject       m_wakelock;
#endif

};

}

#endif // OSBRIDGE_H
