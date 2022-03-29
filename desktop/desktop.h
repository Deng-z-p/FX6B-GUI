#ifndef DESKTOP_H
#define DESKTOP_H
#include <QObject>
#include <QStringList>

class Desktop : public QObject
{
    Q_OBJECT
public:
    Desktop(QObject *parent = nullptr){
        Q_UNUSED(parent);
    }
    //~Desktop();
    Q_PROPERTY(QString  MemUsed
               MEMBER m_MemUsed);
    Q_PROPERTY(QString  MemTotal
               MEMBER m_MemTotal);

    Q_PROPERTY(QString cpurate0
               MEMBER m_cpurate0);
    Q_PROPERTY(QString cpurate1
               MEMBER m_cpurate1);

    Q_INVOKABLE QString read_uptime();
    Q_INVOKABLE void read_meminfo();
    Q_INVOKABLE void read_cpurate();

signals:
    void cpurate_Changed();

private:
    QString m_MemUsed;
    QString m_MemTotal;
    QString m_cpurate0;
    QString m_cpurate1;
};

#endif // DESKTOP_H
