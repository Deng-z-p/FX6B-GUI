#include "fileio.h"
#include <QDebug>
#include <QFile>
#include <QTextCodec>

FileIO::FileIO(QObject *parent) : QObject(parent)
{
   workerTh = new WorkerThread(this);
   connect(workerTh, \
           SIGNAL(resultReady()), \
           this, \
           SLOT(handleResults()));
}

FileIO::~FileIO()
{
    workerTh->quit();
    if(workerTh->wait(100)){
        qDebug()<<"Thread end"<<endl;
    }
}

QString FileIO::source()
{
    return workerTh->filemessage;
}

void FileIO::setSource(const QString& filepath)
{
    workerTh->filemessage = filepath;
    if(!workerTh->isRunning()){
        workerTh->start();
    }
}

void FileIO::handleResults()
{
    emit sourceChanged();
    workerTh->quit();
    if(workerTh->wait(100)){
        qDebug()<<"Thread end"<<endl;
    }
}

void WorkerThread::run(){
    QFile file(filemessage);
    if(file.open(QIODevice::ReadOnly | QIODevice::Text)){
        QString line;
        QTextCodec *code = QTextCodec::codecForName("UTF-8");
        QTextStream t(&file);
        t.setCodec(code);

        filemessage =t.readAll();

        file.close();
        emit resultReady();
    }
}
