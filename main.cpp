#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QFont>
#include <QTextCodec>
#include "benchmark/benchmark.h"
#include "fileview/fileio.h"
#include "video/video.h"
#include "album/album.h"
#include "settings/settings.h"
#include "desktop/desktop.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    QTextCodec::setCodecForLocale(QTextCodec::codecForName("UTF-8"));

    QFont font = app.font();
    font.setPixelSize(25);
    font.setStyle(QFont::StyleItalic);
    app.setFont(font);

    qmlRegisterType<Benchmark>("Package.benchmark", 1, 0, "Benchmark");
    qmlRegisterType<FileIO>("Package.fileio", 1, 0, "FileIO");
    qmlRegisterType<Video>("Package.video", 1, 0, "Video");
    qmlRegisterType<Settings>("Package.settings", 1, 0, "Settings");
    qmlRegisterType<Desktop>("Package.desktop", 1, 0, "Desktop");

    QQmlApplicationEngine engine;

    album *myAlbum = new album();
    engine.rootContext()->setContextProperty("myAlbum", myAlbum);
    myAlbum->add("/media/album");

    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
