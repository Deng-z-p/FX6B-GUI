#ifndef ALBUM_H
#define ALBUM_H
#include <QAbstractListModel>
#include <QUrl>


class album : public QAbstractListModel
{
    Q_OBJECT
public:
    explicit album(QObject *parent = 0);
    int rowCount(const QModelIndex &parent = QModelIndex()) const;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole)const;

    void add(QString paths);
    enum albumRole{
        pathRole = Qt::UserRole + 1,
        titileRole,
    };
private:
    QHash<int,QByteArray> roleNames() const;
    QList<QUrl> photoListData;
};

#endif // ALBUM_H
