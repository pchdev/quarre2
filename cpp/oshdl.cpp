#include "oshdl.hpp"
#include <QDebug>

using namespace quarre;

platform_hdl::platform_hdl()
{
    // NEED TO INTEGRATE ANDROIDJNI ERROR MANAGEMENT!!
    /* ANDROID */

#ifdef Q_OS_ANDROID

    // CATCH VIBRATOR DEVICE
    QAndroidJniObject vibr_string = QAndroidJniObject::fromString("vibrator");
    QAndroidJniObject vibr_activity = QAndroidJniObject::callStaticObjectMethod("org/qtproject/qt5/android/QtNative", "activity", "()Landroid/app/Activity;");
    QAndroidJniObject vibr_app_context = vibr_activity.callObjectMethod("getApplicationContext", "()Landroid/content/Context;");
    m_vibrator = vibr_app_context.callObjectMethod("getSystemService", "(Ljava/lang/String;)Ljava/lang/Object;", vibr_string.object<jstring>());

    // CATCH & ACTIVATE WAKELOCK
    QAndroidJniObject wl_activity = QAndroidJniObject::callStaticObjectMethod("org/qtproject/qt5/android/QtNative", "activity", "()Landroid/app/Activity;");
    QAndroidJniObject service_name = QAndroidJniObject::getStaticObjectField<jstring>("android/content/Context", "POWER_SERVICE");
    QAndroidJniObject power_mgr = wl_activity.callObjectMethod("getSystemService", "(Ljava/lang/String;)Ljava/lang/Object;", service_name.object<jobject>());
    jint level_and_flags = QAndroidJniObject::getStaticField<jint>("android/os/PowerManager", "SCREEN_BRIGHT_WAKE_LOCK");
    QAndroidJniObject tag = QAndroidJniObject::fromString("My Tag");
    m_wake_lock = power_mgr.callObjectMethod("newWakeLock", "(ILjava/lang/String;)Landroid/os/PowerManager$WakeLock;", level_and_flags, tag.object<jstring>());

    if(m_wake_lock.isValid()) {
        m_wake_lock.callMethod<void>("acquire", "()V");
        qDebug() << "Locked device, cannot go to standby anymore";
    } else { qDebug() << "Unable to lock device..!!";}

#endif

    /* IOS ? */

}

platform_hdl::~platform_hdl() {}

#ifdef Q_OS_ANDROID

void platform_hdl::vibrate(int milliseconds) const
{
    jlong ms = milliseconds;
    jboolean has_vibrator = m_vibrator.callMethod<jboolean>("hasVibrator", "()Z");
    m_vibrator.callMethod<void>("vibrate", "(J)V", ms);
}

#endif
