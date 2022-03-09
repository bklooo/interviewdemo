#include "netwoker.h"


NetWoker::NetWoker()
{
    sender = new QUdpSocket(this);
    receiver = new QUdpSocket(this);

    receiver->bind(8888,QUdpSocket::ShareAddress);
    connect(receiver, SIGNAL(readyRead()),this,SLOT(slotReadData()));
}

void NetWoker::sendData(QString strData)
{
    QByteArray byteData = strData.toUtf8();
//    QHostAddress addr;
//    addr.setAddress("192.168.1.1");
    sender->writeDatagram(byteData.data(),byteData.size(),QHostAddress::Broadcast,8888);

}

QString NetWoker::getRecData()
{
    return m_RecData;
}

void NetWoker::setRecData(QString temp)
{
    m_RecData = temp;
    emit recDataChanged();
}

void NetWoker::slotReadData()
{
    while(receiver->hasPendingDatagrams()){
        QByteArray byteDataGram;
        QString strDataGram;
        byteDataGram.resize(static_cast<int>(receiver->pendingDatagramSize()));
        receiver->readDatagram(byteDataGram.data(),byteDataGram.size());
        strDataGram.prepend(byteDataGram);
        m_RecData = strDataGram;
    }
}
