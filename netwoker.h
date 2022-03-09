#ifndef NETWOKER_H
#define NETWOKER_H

#include <QObject>
#include <QtNetwork>

class NetWoker : public QObject
{
    Q_OBJECT
public:
    NetWoker();
    Q_INVOKABLE void sendData(QString);
    Q_PROPERTY(QString strRecData READ getRecData WRITE setRecData NOTIFY recDataChanged);

private:
    QUdpSocket *sender;
    QUdpSocket *receiver;

    QString m_RecData;

    QString getRecData();
    void setRecData(QString temp);

signals:
    void recDataChanged();

private slots:
    void slotReadData();

};

#endif // NETWOKER_H
