#ifndef BENCHMARK_H
#define BENCHMARK_H
#include <QObject>
#include <QProcess>
#include <QByteArray>

class Benchmark : public QObject
{
    Q_OBJECT
public:
    Benchmark(QObject *parent = 0);
    ~Benchmark();
    Q_PROPERTY(QString benchmark_resulttext MEMBER m_benchmark_resulttext NOTIFY benchmark_resulttext_Changed);
public slots:
    void benchmark_test_start(QString name, QStringList arg);
    void benchmark_test_stop();
    void QProcess_started();
    void QProcess_readyReadStandardOutput();
    void QProcess_finished(int exitCode, QProcess::ExitStatus exitStatus);

private:
    QProcess *benchmark_process;
    QString m_benchmark_resulttext;

signals:
    void benchmark_resulttext_Changed();
    void benchmark_test_finised();
};

#endif // BENCHMARK_H
