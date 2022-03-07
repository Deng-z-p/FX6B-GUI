#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QFont>
#include "benchmark/benchmark.h"
#include "fileview/fileio.h"
#include "video/video.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    QFont font = app.font();
    font.setPixelSize(25);
    font.setStyle(QFont::StyleItalic);
    app.setFont(font);

    qmlRegisterType<Benchmark>("Package.benchmark", 1, 0, "Benchmark");
    qmlRegisterType<FileIO>("Package.fileio", 1, 0, "FileIO");
    qmlRegisterType<Video>("Package.video", 1, 0, "Video");

    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
