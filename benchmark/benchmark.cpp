#include "benchmark.h"
#include <QDebug>
#include <QDir>

Benchmark::Benchmark(QObject *parent) : QObject(parent)
{}

Benchmark::~Benchmark()
{}

void Benchmark::benchmark_test_start(QString name, QStringList arg)
{
    QString path = "/qt/sbc-bench";
   // QStringList arguments;

    benchmark_process = new QProcess(this);

    connect(benchmark_process, \
            SIGNAL(started()), \
            this, \
            SLOT(QProcess_started()));

    connect(benchmark_process, \
            SIGNAL(readyReadStandardOutput()), \
            this, \
            SLOT(QProcess_readyReadStandardOutput()));

    connect(benchmark_process, \
            SIGNAL(finished(int, QProcess::ExitStatus)), \
            this, \
            SLOT(QProcess_finished(int, QProcess::ExitStatus)));

    path.append("/");
    path.append(name);
    qDebug()<<path<<"  "<<arg<<endl;
    benchmark_process->start(path, arg);
}

void Benchmark::benchmark_test_stop()
{
    if(benchmark_process->state() != QProcess::NotRunning){
        benchmark_process->kill();
        benchmark_process->deleteLater();
        m_benchmark_resulttext = "...It's over...";
        emit benchmark_resulttext_Changed();
    }
}

void Benchmark::QProcess_started()
{
    m_benchmark_resulttext = "...Start,Please Waitting...";
    emit benchmark_resulttext_Changed();
}

void Benchmark::QProcess_readyReadStandardOutput()
{
    m_benchmark_resulttext = benchmark_process->readAllStandardOutput();
    //m_benchmark_resulttext.remove(QChar('\n'), Qt::CaseInsensitive);

    emit benchmark_resulttext_Changed();
}

void Benchmark::QProcess_finished(int exitCode, QProcess::ExitStatus exitStatus)
{
    Q_UNUSED(exitCode);
    if(exitStatus == QProcess::NormalExit){
        m_benchmark_resulttext = "...Exit...";
        emit benchmark_resulttext_Changed();
    }
    benchmark_process->deleteLater();
    emit benchmark_test_finised();
}



