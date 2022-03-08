#ifndef SYSINIT_H
#define SYSINIT_H

#include <QObject>

class SysInit : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString strDevName READ getDevName NOTIFY devNameChanged)
    Q_PROPERTY(QString strDevIP READ getDevIP NOTIFY devIPChanged)
    Q_PROPERTY(QString strCurrentDateTime READ getCurrentDateTime WRITE setCurrentDateTime NOTIFY currentDateTimeChanged)
public:
    SysInit();
    Q_INVOKABLE void printDevName();
    Q_INVOKABLE void startInit();
    Q_INVOKABLE void updateDevInfo();

    QString getDevName();
    QString getDevIP();
    QString getCurrentDateTime();

    void setCurrentDateTime(QString temp);

public:
    QString m_devName;
    QString m_devIP;
    QString m_CurrentDateTime;

signals:
    void sigInit();

    void devNameChanged();
    void devIPChanged();
    void currentDateTimeChanged();

public slots:
    void init();

};

#endif // SYSINIT_H
