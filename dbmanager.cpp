#include "dbmanager.h"

#include <QDir>
#include <QDebug>

DbManager::DbManager()
{
    if (QSqlDatabase::contains("qt_sql_default_connection"))
    {
        db = QSqlDatabase::database("qt_sql_default_connection");
    }
    else
    {
        db = QSqlDatabase::addDatabase("QSQLITE");
        QString dbname = QDir::currentPath() +QString("/")+ QString("demodb.db");
        db.setDatabaseName(dbname);
    }

    if (db.open())
    {
        qDebug() << "Success to connect database.";
        dbStatus = true;
        if(dbStatus){
            QSqlQuery query;
            query.exec("CREATE TABLE IF NOT EXISTS Person("
                       "id INTEGER PRIMARY KEY AUTOINCREMENT, "
                       "name VARCHAR(10) NOT NULL, "
                       "sex VARCHAR(10) NOT NULL, "
                       "weight VARCHAR(10) NOT NULL, "
                       "height VARCHAR(10) NOT NULL, "
                       "date VARCHAR(10) NOT NULL)");
        }
    }
    else
    {
        qDebug() << "Error: Failed to connect database." << db.lastError();
    }

}

QVariantList DbManager::searchData(QString strData)
{
    QSqlQuery query;
    QVariantMap mapPersonData;
    QVariantList listPersonOnes;
    if(dbStatus){
        query.exec(QString("SELECT * FROM Person Where name = '%1' or "
                   "sex = '%1' or weight = '%1' or height = '%1' or "
                   "date = '%1'").arg(strData));
        qDebug() << query.lastQuery();
        while(query.next()){
            QString id = query.value(0).toString();
            QString name = query.value(1).toString();
            QString sex = query.value(2).toString();
            QString width = query.value(3).toString();
            QString height = query.value(4).toString();
            QString date = query.value(5).toString();

            mapPersonData.clear();
            mapPersonData.insert("name", name);
            mapPersonData.insert("sex", sex);
            mapPersonData.insert("weight", width);
            mapPersonData.insert("height", height);
            mapPersonData.insert("date", date);

            listPersonOnes.append(mapPersonData);

        }
    }
    return listPersonOnes;

}

void DbManager::insertData(QVariantList listData)
{
    QVariantMap mapData = listData.at(0).toMap();
    QString name = mapData.value("name").toString();
    QString sex = mapData.value("sex").toString();
    QString weight = mapData.value("weight").toString();
    QString height = mapData.value("height").toString();
    QString date = mapData.value("date").toString();

    QSqlQuery query;
    if(dbStatus){
        query.exec(QString("INSERT INTO Person(name,sex,weight,height,date) VALUES "
                           "('%1','%2','%3','%4','%5')")
                   .arg(name).arg(sex).arg(weight).arg(height).arg(date));
        qDebug() << query.lastQuery();
    }
}

void DbManager::deleteData(QString strData)
{
    QSqlQuery query;
    QString name = strData;
    if(dbStatus){
        query.exec(QString("DELETE FROM Person WHERE name = '%1'")
                   .arg(name));
        qDebug() << query.lastQuery();
    }
}

QVariantList DbManager::initPersonData()
{
    QSqlQuery query;
    QVariantMap mapPersonData;
    QVariantList listPersonOnes;
    if(dbStatus){
        query.exec("SELECT * FROM Person");
        while(query.next()){
            QString id = query.value(0).toString();
            QString name = query.value(1).toString();
            QString sex = query.value(2).toString();
            QString width = query.value(3).toString();
            QString height = query.value(4).toString();
            QString date = query.value(5).toString();

            mapPersonData.clear();
            mapPersonData.insert("name", name);
            mapPersonData.insert("sex", sex);
            mapPersonData.insert("weight", width);
            mapPersonData.insert("height", height);
            mapPersonData.insert("date", date);

            listPersonOnes.append(mapPersonData);

        }
    }
    return listPersonOnes;
}
