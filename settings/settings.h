#ifndef SETTINGS_H
#define SETTINGS_H

#include <QObject>

class Settings : public QObject
{
    Q_OBJECT
public:
    Q_INVOKABLE void reboot();
    //Q_INVOKABLE void closeQt();
};

#endif // SETTINGS_H
