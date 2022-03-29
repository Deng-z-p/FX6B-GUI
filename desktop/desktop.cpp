#include "desktop.h"
#include <QDebug>
#include <QFile>

QString Desktop::read_uptime()
{
    QString uptime;
    QFile file("/proc/uptime");
    if(!file.open(QIODevice::ReadOnly|QIODevice::Text)){
        qDebug()<<"File does not exist"<<endl;
        return  QString();
    }
    uptime = file.readLine();
    file.close();
    uptime = uptime.section(' ', 0, 0);
    uptime = uptime.section('.', 0, 0);
    return uptime;
}

void Desktop::read_cpurate()
{
    int i=0;
    static int read_Count = 0;
    static int cpu0_Total[2]={0};
    static int cpu0_Idle[2]={0};
    static int cpu1_Total[2]={0};
    static int cpu1_Idle[2]={0};
    QString cpuxrate;

    QFile file("/proc/stat");
    if(!file.open(QIODevice::ReadOnly|QIODevice::Text)){
        qDebug()<<"File does not exist"<<endl;
        return;
    }
    file.readLine();
    /*
     * @note CPU time = user + system + nice + idle + iowait + irq + softing
     */
    cpuxrate = file.readLine();
    cpuxrate.remove("cpu0 ");
    for(i=0; i<7; i++){
        cpu0_Total[read_Count] += cpuxrate.section(' ',i, i).toUInt();
    }
    cpu0_Idle[read_Count] += cpuxrate.section(' ', 3, 3).toUInt();

    cpuxrate = file.readLine();
    cpuxrate.remove("cpu1 ");
    for(i=0; i<7; i++){
        cpu1_Total[read_Count] += cpuxrate.section(' ',i, i).toUInt();
    }
    cpu1_Idle[read_Count] += cpuxrate.section(' ', 3, 3).toUInt();

    file.close();
    /*
     * @note The calculation formula is
     *      cpu usage = (1-(idle2-idle1)/(total2-total1))*100%
     *      Must ensure that the /proc/stat file is read twice
    */
    read_Count ++;
    if(read_Count == 2){
        read_Count = 0;

        cpu0_Total[0] = cpu0_Total[1]-cpu0_Total[0];
        cpu0_Idle[0] = cpu0_Idle[1]-cpu0_Idle[0];

        cpu1_Total[0] = cpu1_Total[1]-cpu1_Total[0];
        cpu1_Idle[0] = cpu1_Idle[1]-cpu1_Idle[0];

        m_cpurate0 = QString::number(((1-((double)cpu0_Idle[0]/(double)cpu0_Total[0]))*100));
        m_cpurate1 = QString::number(((1-((double)cpu1_Idle[0]/(double)cpu1_Total[0]))*100));
        emit cpurate_Changed();

        for(i=0; i<2; i++){
            cpu0_Total[i]=0;
            cpu0_Idle[i]=0;

            cpu1_Total[i]=0;
            cpu1_Idle[i]=0;
        }
    }

}

void Desktop::read_meminfo()
{
    QString meminfo;
    QFile file("/proc/meminfo");
    if(!file.open(QIODevice::ReadOnly|QIODevice::Text)){
        qDebug()<<"File does not exist"<<endl;
        return;
    }
    meminfo = file.readLine();
    file.readLine();
    meminfo.append(file.readLine());
    //qDebug()<<meminfo<<endl;
    file.close();
    meminfo = meminfo.remove("MemAvailable:");
    meminfo = meminfo.remove("MemTotal:");
    meminfo = meminfo.remove("\n");
    meminfo = meminfo.remove(" ");
    m_MemUsed = meminfo.section("kB", 1, 1);  //read memeAvailable
    m_MemTotal = meminfo.section("kB", 0, 0); //read memTotal
    m_MemUsed = QString::number(m_MemTotal.toInt() - m_MemUsed.toInt());
}
