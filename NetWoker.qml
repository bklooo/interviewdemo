import QtQuick 2.0

Item {
    id: element
    anchors.fill: parent

    //发送框
    Rectangle{
        id: rec_sender_1
        width: parent.width/3
        height: parent.height/3*2
        color: "lightblue"
        anchors.left: parent.left
        anchors.leftMargin: parent.width/7
        anchors.verticalCenter: parent.verticalCenter
        TextEdit{
            id: edit_sender_1
            width: parent.width/5*4
            height: parent.height/3*2
            z: 11
            focus: true
            wrapMode: TextEdit.Wrap
            font.pointSize: 12
            selectedTextColor: "#ff0c0c"
            anchors.top: parent.top
            anchors.topMargin: parent.height/10
            anchors.horizontalCenter: parent.horizontalCenter
            clip: true
        }

        Rectangle{
            anchors.fill: edit_sender_1
            z: 10
            color: "white"
        }

        Rectangle{
            id: rec_sender_button_1
            width: parent.width/4
            height: width/2
            color: "#0088ff"
            anchors.bottom: parent.bottom
            anchors.bottomMargin: parent.height/15
            anchors.horizontalCenter: parent.horizontalCenter
            Text {
                color: "#ffffff"
                text: qsTr("发送")
                font.bold: true
                font.pointSize: 14
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
            }

            MouseArea{
                anchors.fill: parent
                onPressed: {
                    rec_sender_button_1.opacity = 0.5
                }
                onReleased: {
                    rec_sender_button_1.opacity = 1
                }
                onClicked: {
                    netwoker.sendData(edit_sender_1.text)
                    timer_strcurrentdatetime.start()
                    edit_sender_1.clear()
                }
            }
        }
    }

    //接收框
    Rectangle{
        id: rec_receiver_1
        width: parent.width/3
        height: parent.height/3*2
        color: "lightblue"
        anchors.right: parent.right
        anchors.rightMargin: parent.width/7
        anchors.verticalCenter: parent.verticalCenter
        TextEdit{
            id: edit_receiver_1
            width: parent.width/5*4
            height: parent.height/3*2
            z: 11
            focus: true
            wrapMode: TextEdit.Wrap
            font.pointSize: 12
            selectedTextColor: "#ff0c0c"
            anchors.top: parent.top
            anchors.topMargin: parent.height/10
            anchors.horizontalCenter: parent.horizontalCenter
            clip: true
        }


        Rectangle{
            anchors.fill: edit_receiver_1
            z: 10
            color: "white"
        }
    }

    Timer{
        id: timer_strcurrentdatetime
        repeat: true
        interval: 100
        triggeredOnStart: true
        onTriggered: {
            edit_receiver_1.text = netwoker.strRecData
            timer_strcurrentdatetime.stop()
        }
    }

    //返回按钮
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
                unloadNetWoker()
            }
        }
    }

    Rectangle {
        id: rectangle
        width: parent.width/2
        height: width/6
        color: "#ffffff"
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        Text {
            text: qsTr("UDP广播，端口:8888")
            font.pointSize: 18
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }

}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
