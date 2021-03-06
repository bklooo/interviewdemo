#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "sysinit.h"
#include "dbmanager.h"
#include "netwoker.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);
    SysInit sysinit;
    DbManager dbmanger;
    NetWoker netwoker;

    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("sysinit", &sysinit);
    engine.rootContext()->setContextProperty("dbmanger", &dbmanger);
    engine.rootContext()->setContextProperty("netwoker", &netwoker);

    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
