#ifndef VIDEO_H
#define VIDEO_H

#include <QObject>
#include <QProcess>

class Video : public QObject
{
    Q_OBJECT
public:
    Video(QObject *parent = 0);
    ~Video();

    Q_INVOKABLE void mplayer_play(const QString& program, \
                                  const QString& width, \
                                  const QString& height);

public slots:
    void mplayer_exit();

private:
    QProcess *video_process = NULL;
};


#endif // VIDEO_H
