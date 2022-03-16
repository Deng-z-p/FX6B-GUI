#include "settings.h"
#include <QDebug>
#include <stdlib.h>
#include <unistd.h>

void Settings::reboot()
{
    system("reboot");
}

//void Settings::closeQt()
//{
//    system("exitQT");
//    //sleep(2);
//    //qDebug()<<__LINE__<<endl;
//   // system("echo '' > /dev/tty1");
//  //  system("echo '/***********************************/' > /dev/tty1");
//    //system("echo 'Qt is exited', > /dev/tty1");
//   // system("echo 'if you want to restart, Please execute the 'fx6b_GUI' file in directory /qt ', > /dev/tty1");
//}
