#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "WalletSimulator.h"

int main(int argc, char *argv[]) {
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    WalletSimulator wallet;
    engine.rootContext()->setContextProperty("wallet", &wallet);

    const QUrl url(u"qrc:/WalletPoc/qml/Main.qml"_qs);
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);

    engine.load(url);
    return app.exec();
}