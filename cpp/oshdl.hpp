#ifndef OSBRIDGE_H
#define OSBRIDGE_H

#ifdef ANDROID
#include "jni.h"
#include <QtAndroid>
#include <QAndroidJniObject>
#include <QAndroidJniEnvironment>
#endif
#include <QTimer>

namespace quarre {

class platform_hdl : public QObject {

    Q_OBJECT

public:
    platform_hdl();
    ~platform_hdl();

    void vibrate(int milliseconds)  const;
    void light(int milliseconds)    const;

protected slots:
    void torch_timer_callback();

private:
#ifdef Q_OS_ANDROID
    QTimer*                 m_torch_timer;
    QAndroidJniObject       m_wake_lock;
    QAndroidJniObject       m_vibrator;
    QAndroidJniObject       m_camera_manager;
    bool                    m_flash_available;
#endif

};

}

#endif // OSBRIDGE_H
