#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "cpp/oshdl.hpp"
#include <QObject>

int main(int argc, char *argv[])
{
#if defined(Q_OS_WIN)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif

    QGuiApplication app(argc, argv);

    qmlRegisterType<quarre::platform_hdl>("io.quarre.org", 1, 0, "PlatformHdl");

    QQmlApplicationEngine engine;

    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
