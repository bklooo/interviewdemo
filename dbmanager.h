#ifndef DBMANAGER_H
#define DBMANAGER_H
#include <QSqlDatabase>
#include <QSqlError>
#include <QSqlQuery>
#include <QObject>
#include <QVariant>
#include <QVariantMap>
#include <QVariantList>

class DbManager : public QObject
{
    Q_OBJECT
public:
    DbManager();
    Q_INVOKABLE QVariantList searchData(QString);
    Q_INVOKABLE void insertData(QVariantList);
    Q_INVOKABLE void deleteData(QString);
    Q_INVOKABLE QVariantList initPersonData();

private:
    QSqlDatabase db;
    bool dbStatus = false;
    char m_padding [7];  //字节填充，去除warning
};

#endif // DBMANAGER_H
