#include "sysinit.h"
#include "dbmanager.h"

#include <QDateTime>
#include <QHostInfo>

SysInit::SysInit()
{
    connect(this,SIGNAL(sigInit()),this,SLOT(init()));
}

void SysInit::printDevName()
{
    qDebug() << m_devName;
    qDebug() << m_devIP;
    qDebug() << m_CurrentDateTime;
}

void SysInit::startInit()
{
    emit sigInit();
}

void SysInit::updateDevInfo()
{
    //获取设备名
    m_devName =  QHostInfo::localHostName();

    //获取主机ip
    QHostInfo info = QHostInfo::fromName(m_devName);
    QList<QHostAddress> listAddr = info.addresses();
    QList<QString> listTempIP;
    foreach (QHostAddress address, listAddr){
       if(address.protocol() == QAbstractSocket::IPv4Protocol){
           listTempIP.append(address.toString());
       }
    }
    m_devIP = listTempIP.last();

    //获取系统当前时间
    QDateTime currentDateTime = QDateTime::currentDateTime();
    m_CurrentDateTime = currentDateTime.toString("yyyy.MM.dd hh:mm:ss.zzz ddd");
}

QString SysInit::getDevName()
{
    return m_devName;
}

QString SysInit::getDevIP()
{
    return m_devIP;
}

QString SysInit::getCurrentDateTime()
{
    return m_CurrentDateTime;
}

void SysInit::setCurrentDateTime(QString temp)
{
    m_CurrentDateTime = temp;
    emit currentDateTimeChanged();
}

void SysInit::init()
{
    //获取设备名
    m_devName =  QHostInfo::localHostName();

    //获取主机ip
    QHostInfo info = QHostInfo::fromName(m_devName);
    QList<QHostAddress> listAddr = info.addresses();
    QList<QString> listTempIP;
    foreach (QHostAddress address, listAddr){
       if(address.protocol() == QAbstractSocket::IPv4Protocol){
           listTempIP.append(address.toString());
       }
    }
    m_devIP = listTempIP.last();

    //获取系统当前时间
    QDateTime currentDateTime = QDateTime::currentDateTime();
    m_CurrentDateTime = currentDateTime.toString("yyyy.MM.dd hh:mm:ss.zzz ddd");


    //初始化数据库
    DbManager db;

}
