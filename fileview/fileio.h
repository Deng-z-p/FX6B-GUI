#ifndef FILEIO_H
#define FILEIO_H

#include <QObject>
#include <QThread>

class WorkerThread;

class FileIO : public QObject
{
    Q_OBJECT
public:
    FileIO(QObject *parent = 0);
    ~FileIO();

    Q_PROPERTY(QString source
               READ source
               WRITE setSource
               NOTIFY sourceChanged);

    QString source();
    void setSource(const QString& filepath);

private slots:
    void handleResults();

signals:
    void sourceChanged();

private:
    WorkerThread *workerTh;
};



class WorkerThread : public QThread
{
    Q_OBJECT
public:
    WorkerThread(QObject *parent = nullptr){
        Q_UNUSED(parent);
    }

    void run() override;
    QString filemessage;
signals:
    void resultReady();
};

#endif // FILEIO_H
