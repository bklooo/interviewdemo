import QtQuick 2.0
import QtMultimedia 5.12

import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2

Item {
    id: item_video

    //视频框
    Rectangle{
        id: rec_video_player_1
        visible: true
        width: parent.width/2
        height: parent.height/2
        color: "#000000"
        z: 10
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter


        MediaPlayer {
            id: player_1
            source: "file:videos/pig.mp4"
            autoPlay: true
            volume: slider_volume_1.value
        }

        VideoOutput{
            anchors.fill: parent;
            source: player_1;
        }

    }

    //亮度遮罩
    Rectangle{
        id: rec_video_1
        visible: true
        width: parent.width/2
        height: parent.height/2
        opacity: 1 - slider_light_1.value
        color: "#000000"
        z: 10
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
    }





    //滑动条
    Rectangle{
        id: rec_slider_1
        visible: true
        width: parent.width/2
        height: parent.height/2
        opacity: 0
        z: 10
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        Row{
            anchors.fill: parent

            Rectangle{
                width: parent.width/2
                height: parent.height
                Slider {
                    id: slider_light_1
                    anchors.fill: parent
                    value: 0.8
                    stepSize: 0.1
                    maximumValue: 1
                    minimumValue: 0
                    orientation: Qt.Vertical

                    MouseArea{
                        anchors.fill: parent
                        propagateComposedEvents: true

                        onPressed: {
                            rec_light_1.opacity = 0.5
                            mouse.accepted = false
                            timer_light_1.start()
                        }
                    }
                }
            }
            Rectangle{
                width: parent.width/2
                height: parent.height
                Slider {
                    id: slider_volume_1
                    anchors.fill: parent
                    value: 0.5
                    stepSize: 0.1
                    maximumValue: 1
                    minimumValue: 0
                    orientation: Qt.Vertical
                    MouseArea{
                        anchors.fill: parent
                        propagateComposedEvents: true

                        onPressed: {
                            rec_volume_1.opacity = 0.5
                            mouse.accepted = false
                            timer_vloume_1.start()
                        }
                    }

                }

            }

        }
    }


    Timer{
        id: timer_vloume_1
        repeat: true
        interval: 3000
        onTriggered: {
            rec_volume_1.opacity = 0
            timer_vloume_1.stop()
        }
    }

    Timer{
        id: timer_light_1
        repeat: true
        interval: 3000
        onTriggered: {
            rec_light_1.opacity = 0
            timer_light_1.stop()
        }
    }

    //提示遮罩
    Row{
        id: rec_slider_tip_1
        visible: true
        width: parent.width/2
        height: parent.height/2
        z: 10
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        Rectangle{
            id: rec_light_1
            width: parent.width/2
            height: parent.height
            color: "#000000"
            opacity: 0
            Text {
                id: text_volume_1
                color: "#ffffff"
                text: qsTr("往上滑增加亮度\n往下滑减少亮度")
                font.pointSize: 22
                anchors.fill: parent
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
            }
        }
        Rectangle{
            id: rec_volume_1
            width: parent.width/2
            height: parent.height
            color: "#000000"
            opacity: 0
            Text {
                id: text_volume_2
                color: "#ffffff"
                text: qsTr("往上滑增加音量\n往下滑减少音量")
                font.pointSize: 22
                anchors.fill: parent
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
            }

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
                unLoadVideo()
            }
        }
    }


    //进度条
    Slider{
        id: slider_video_pos_1
        width: rec_video_player_1.width
        height: rec_video_player_1.height/20
        anchors.top: rec_video_1.bottom
        anchors.horizontalCenter: parent.horizontalCenter

        maximumValue: player_1.duration
        minimumValue: 0
        value: player_1.position
        stepSize:1000

        MouseArea {
            property int pos
            anchors.fill: parent
            onPressed: {
                if (player_1.seekable){
                    pos = player_1.duration * mouse.x/parent.width
                }
                player_1.seek(pos)

            }
        }

    }

    Rectangle{
        id: rec_video_restart_1
        visible: false
        width: parent.width/2
        height: parent.height/2
        opacity: 1
        color: "#ffffff"
        z: 15
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        Image {
            id: image_1
            width: parent.width/4
            height: parent.width/4
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            source: "qrc:/imgs/start.png"
            MouseArea{
                anchors.fill: parent
                onPressed: {
                    player_1.play()
                    image_1.opacity = 0.5

                }
                onReleased: {
                    image_1.opacity = 1
                    rec_video_restart_1.visible = false
                }
            }

        }


    }

    Timer{
        id: timer_tip_restart_1
        repeat: true
        interval: 1000
        triggeredOnStart: true
        onTriggered: {
            if(player_1.duration > 0 && player_1.position === player_1.duration){
                rec_video_restart_1.visible = true
            }
        }
    }

    Component.onCompleted: {
        timer_tip_restart_1.start()
    }


}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}D{i:1;anchors_height:0;anchors_width:0}
}
##^##*/
