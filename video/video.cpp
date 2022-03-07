#include "video.h"
#include <QDebug>
#include <QQmlEngine>
#include <QQmlComponent>
#include <QQuickView>
#include <QQuickItem>

Video::Video(QObject *parent):QObject(parent){}
Video::~Video(){}

void Video::mplayer_play(const QString& program, \
                         const QString& width, \
                         const QString& height)
{
    QStringList mplayerargs;
    mplayerargs << "-slave";
    mplayerargs << "-quiet";
    mplayerargs << "-zoom";
    mplayerargs << "-x";
    mplayerargs << width;
    mplayerargs << "-y";
    mplayerargs << height;
    mplayerargs << program;
    qDebug()<<mplayerargs<<endl;
    if(video_process == NULL){
        video_process = new QProcess();
    }
    video_process->start("mplayer", mplayerargs);
}

void Video::mplayer_exit()
{
    if(video_process != NULL){
        video_process->kill();
        video_process->deleteLater();
        video_process = NULL;
    }
}
