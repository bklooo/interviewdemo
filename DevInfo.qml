import QtQuick 2.0

Item {

    Rectangle{
        id: tip_1
        visible: true
        width: parent.width/2
        height: parent.height/2
        y: -height
        color: "#050505"
        z: 10
        anchors.horizontalCenter: parent.horizontalCenter

        Column {
            spacing: 10
            Text {
                color: "#11ff08"
                font.pointSize: 24
                text: "本地计算机名：" + sysinit.strDevName
            }
            Text {
                color: "#11ff08"
                font.pointSize: 24
                text: "本地计算机IP：" + sysinit.strDevIP
            }
            Text {
                id: text_strcurrentdatetime
                color: "#11ff08"
                font.pointSize: 24
                text: "本地计算机时间：" + sysinit.strCurrentDateTime
            }
        }
        Timer{
            id: timer_strcurrentdatetime
            repeat: true
            interval: 100
            triggeredOnStart: true
            onTriggered: {
                sysinit.updateDevInfo()
                text_strcurrentdatetime.text = "本地计算机时间：" + sysinit.strCurrentDateTime
            }
        }

        PropertyAnimation{
            running: true
            target: tip_1
            property: "y"
            from: -height
            to: height/4
            duration: 5000
            easing.type: Easing.OutBack
        }
    }

    Rectangle{
        id: back_1
        visible: true
        width: window.width/10
        height: window.height/10
        y: parent.height
        color: "#06fdbd"
        radius: 10
        rotation: 0
        anchors.horizontalCenter: parent.horizontalCenter
        z: 10

        Text {
            id: name_back_1
            color: "#000000"
            text: qsTr("返回")
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            font.pointSize: 24
        }

        PropertyAnimation{
            running: true
            target: back_1
            property: "y"
            from: window.height
            to: window.height - (back_1.height/2)*2.8
            duration: 5000
            easing.type: Easing.Bezier
        }

        MouseArea{
            anchors.fill: parent
            onPressed: parent.opacity = 0.5
            onReleased: parent.opacity = 1
            onClicked: {
                unLoadLocalInfo()
            }
        }
    }

    Component.onCompleted: {
        timer_strcurrentdatetime.start()
    }

}
