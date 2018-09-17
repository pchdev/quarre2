#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "cpp/system.hpp"
#include "cpp/audio.hpp"
#include "cpp/downloadmanager.hpp"
#include <QObject>
#include <QQmlComponent>

int main(int argc, char *argv[])
{
#if defined(Q_OS_WIN)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif

    QGuiApplication app(argc, argv);

    qmlRegisterType<quarre::platform_hdl>   ( "Quarre", 1, 0, "System" );
    qmlRegisterType<quarre::audio_hdl>      ( "Quarre", 1, 0, "Audio" );
    qmlRegisterType<DownloadManager>        ( "Quarre", 1, 0, "DownloadManager");

    QQmlApplicationEngine engine;

    engine.load(QUrl(QStringLiteral("qrc:/Main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    QObject::connect(&engine, SIGNAL(quit()), &app, SLOT(quit()));

    return app.exec();
}
