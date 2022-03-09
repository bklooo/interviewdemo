import QtQuick 2.14
import QtQuick.Window 2.14

Window {
    id: window
    visible: true
    width: Screen.width + 1
    height: Screen.height + 1
    flags: Qt.FramelessWindowHint | Qt.Window


    Loader{
        id: loader_header_1
        anchors.fill: parent
    }

    Grid {
        id: grid_1
        anchors.fill: parent
        visible: true
        columns: 2
        rows: 2
        spacing: parent.width/15
        topPadding: parent.height/8
        leftPadding: parent.width/8
        Rectangle{
            id: choose_1
            visible: true
            width: parent.width/3
            height: parent.height/3

            color: "#f02c2c"
            Text {
                id: name_1
                text: "选项一：查看系统信息"
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                font.pointSize: 36
            }
            MouseArea{
                anchors.fill: parent
                onPressed: parent.opacity = 0.5
                onReleased: parent.opacity = 1
                onClicked: {
                    loadLocalInfo()
                }
            }

        }
        Rectangle{
            id: choose_2
            width: parent.width/3
            height: parent.height/3
            color: "#2c76f0"
            Text {
                id: name_2
                text: "选项二：播放视频"
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                font.pointSize: 36
            }
            MouseArea{
                anchors.fill: parent
                onPressed: parent.opacity = 0.5
                onReleased: parent.opacity = 1
                onClicked: {
                    loadVideo()
                }

            }

        }
        Rectangle{
            id: choose_3
            width: parent.width/3
            height: parent.height/3
            color: "#f02cc4"
            Text {
                id: name_3
                text: "选项三：数据库操作"
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                font.pointSize: 36
            }
            MouseArea{
                anchors.fill: parent
                onPressed: parent.opacity = 0.5
                onReleased: parent.opacity = 1
                onClicked: {
                    loadDBView()
                }
            }

        }
        Rectangle{
            id: choose_4
            width: parent.width/3
            height: parent.height/3
            color: "#65f02c"
            Text {
                id: name_4
                text: "选项四：网络消息收发"
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                font.pointSize: 36
            }
            MouseArea{
                anchors.fill: parent
                onPressed: parent.opacity = 0.5
                onReleased: parent.opacity = 1
                onClicked: {
                    loadNetWoker()
                }
            }

        }
    }

    Loader{
        id: loader_1
        anchors.fill: parent
    }





    function loadLocalInfo(){
        grid_1.visible = false;
        loader_1.source = "DevInfo.qml";
    }

    function unLoadLocalInfo(){
        grid_1.visible = true;
        loader_1.source = "";
    }

    function loadVideo(){
        grid_1.visible = false;
        loader_1.source = "VideoPlayer.qml";
    }

    function unLoadVideo(){
        grid_1.visible = true;
        loader_1.source = "";
    }

    function loadDBView(){
        grid_1.visible = false;
        loader_1.source = "DBView.qml";
    }

    function unloadDBView(){
        grid_1.visible = true;
        loader_1.source = "";
    }

    function loadNetWoker(){
        grid_1.visible = false;
        loader_1.source = "NetWoker.qml";
    }

    function unloadNetWoker(){
        grid_1.visible = true;
        loader_1.source = "";
    }

    Component.onCompleted: {
        loader_header_1.source = "Header.qml"
        sysinit.startInit()
    }

}

/*##^##
Designer {
    D{i:1;anchors_height:0;anchors_width:0}D{i:2;anchors_height:0;anchors_width:0}
}
##^##*/
