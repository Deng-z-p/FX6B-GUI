#include "album.h"
#include <QDebug>
#include <QDir>
#include <QDirIterator>

album::album(QObject *parent) : QAbstractListModel(parent)
{
    Q_UNUSED(parent);
}

QHash<int, QByteArray> album::roleNames() const
{
    QHash<int, QByteArray> role;
    role[pathRole] = "path";
    role[titileRole] = "title";
    return  role;
}

QVariant album::data(const QModelIndex &index, int role) const
{
    if(index.row()<0 || index.row()>=photoListData.count()){
        qDebug()<<__FILE__<<":"<<__LINE__<<endl;
        return QVariant();
    }
    switch (role) {
        case pathRole:
        return photoListData.at(index.row());
    default:
        return QVariant();
    }
}

int album::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent);
    return photoListData.count();
}

void album::add(QString paths)
{
    QDir dir(paths);
    if(!dir.exists()){
        qDebug()<<"photo paths not exist"<<endl;
        return;
    }
    QStringList filter;
    filter<<"*.jpg"<<".png";
    QDirIterator iTerator(paths, filter, QDir::Files|QDir::NoSymLinks);
    while (iTerator.hasNext()) {
        iTerator.next();
        //QString photoPath = QString::fromUtf8((QString("file://" + iTerator.filePath()).toUtf8().data()));
        QString photoPath = "file://"+iTerator.filePath();
        photoListData.append(photoPath);
    }
}
