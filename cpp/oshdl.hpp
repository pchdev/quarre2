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

public:
    platform_hdl();
    ~platform_hdl();

public slots:
    void vibrate(int milliseconds)  const;
    void register_zeroconf(QString name, QString type, quint16 port);

private:
#ifdef Q_OS_ANDROID
    QAndroidJniObject       m_vibrator;
    QAndroidJniObject       m_wakelock;
#endif

};

}

#endif // OSBRIDGE_H
