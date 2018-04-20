#include "oshdl.hpp"
#include <QDebug>
#include <QNetworkInterface>

using namespace quarre;

platform_hdl* platform_hdl::singleton;

void onServerDiscoveredNative(JNIEnv*, jobject)
{
    auto hostaddr = QAndroidJniObject::getStaticObjectField("org/quarre/remote/ZConfRunnable", "HOST_ADDR", "Ljava/lang/String;");
    auto platform = platform_hdl::singleton;

    auto hoststr = hostaddr.toString();
    platform->setHostAddr(hoststr);
    auto hostlist = hoststr.split(':');
    platform->setPort(hostlist[1].toInt());
}

void onRemoteQuitNative(JNIEnv*, jobject)
{
    auto platform = platform_hdl::singleton;
    platform->application_quit();
}

void platform_hdl::application_quit()
{
    emit remoteQuit();
}

QString platform_hdl::hostAddr() const
{
    return m_hostAddr;
}

quint16 platform_hdl::port() const
{
    return m_port;
}

void platform_hdl::setHostAddr(QString addr)
{
    if(addr != m_hostAddr)
    {
        m_hostAddr = addr;
        emit hostAddrChanged();
    }
}

void platform_hdl::setPort(quint16 port)
{
    m_port = port;
}

platform_hdl::platform_hdl()
{    

#ifdef Q_OS_ANDROID

    auto activity   = QAndroidJniObject::callStaticObjectMethod("org/qtproject/qt5/android/QtNative", "activity", "()Landroid/app/Activity;");
    auto ctx        = activity.callObjectMethod("getApplicationContext", "()Landroid/content/Context;");

    // -----------  VIBRATOR
    auto vibstr     = QAndroidJniObject::fromString("vibrator");
    m_vibrator      = ctx.callObjectMethod("getSystemService", "(Ljava/lang/String;)Ljava/lang/Object;", vibstr.object<jstring>());

    // ----------   WAKELOCK
    auto powsvc     = QAndroidJniObject::getStaticObjectField<jstring>("android/content/Context", "POWER_SERVICE");
    auto power_mgr  = activity.callObjectMethod("getSystemService", "(Ljava/lang/String;)Ljava/lang/Object;", powsvc.object<jstring>());
    auto lnf        = QAndroidJniObject::getStaticField<jint>("android/os/PowerManager", "SCREEN_BRIGHT_WAKE_LOCK");
    auto tag        = QAndroidJniObject::fromString("My Tag");
    m_wakelock      = power_mgr.callObjectMethod("newWakeLock", "(ILjava/lang/String;)Landroid/os/PowerManager$WakeLock;", lnf, tag.object<jstring>());

    if      (m_wakelock.isValid())
            m_wakelock.callMethod<void>("acquire", "()V");
    else    qDebug() << "Unable to lock device..!!";

#endif

    singleton = this;

}

QString platform_hdl::device_address()
{
    for ( const auto& addr : QNetworkInterface::allAddresses())
    {
        if ( addr.protocol() == QAbstractSocket::IPv4Protocol &&
             addr != QHostAddress(QHostAddress::LocalHost))
            if ( addr.toString().startsWith("192"))
                 return addr.toString();
    }

    return "";
}

platform_hdl::~platform_hdl() {}

#ifdef Q_OS_ANDROID

#include <QMetaObject>




void platform_hdl::register_user_id(quint16 id)
{
    jint user_id = id;
    QAndroidJniObject::setStaticField<jint>("org/quarre/remote/ZConfRunnable", "USER_ID", user_id);
}

void platform_hdl::vibrate(int milliseconds) const
{    
    jboolean has_vibrator   = m_vibrator.callMethod<jboolean>("hasVibrator", "()Z");
    jlong ms                = milliseconds;

    m_vibrator.callMethod<void>("vibrate", "(J)V", ms);
}

void platform_hdl::register_zeroconf(QString name, QString type, quint16 port)
{
    auto    sname           = QAndroidJniObject::fromString(name);
    auto    stype           = QAndroidJniObject::fromString(type);
    jint    sport           = port;

    QtAndroid::androidActivity().callMethod<void>("registerZConfHdl","()V");
}

JNIEXPORT jint JNI_OnLoad(JavaVM* vm, void* /*reserved*/)
{
    JNIEnv* env;
    if (vm->GetEnv(reinterpret_cast<void**>(&env), JNI_VERSION_1_6) != JNI_OK)
      return JNI_ERR;

    JNINativeMethod methods[] = {
        {"onServerDiscoveredNative", "()V", (void*) onServerDiscoveredNative },
        {"onRemoteQuitNative", "()V", (void*) onRemoteQuitNative }
    };

    jclass javaClass = env->FindClass("org/quarre/remote/NativeFunctions");
    if (!javaClass)
      return JNI_ERR;

    if (env->RegisterNatives(javaClass, methods,
                          sizeof(methods) / sizeof(methods[0])) < 0) {
      return JNI_ERR;
    }

    return JNI_VERSION_1_6;
}

#endif
