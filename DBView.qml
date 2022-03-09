import QtQuick 2.0

Item {
    id: element
    anchors.fill: parent
    Component{
        id: comp_data_1

        Item{
            id: item_data_1
            width: parent.width
            height: width/6
            Column{
                spacing: 20
                Text {
                    text: "名字:" + m_name
                    color: item_data_1.ListView.isCurrentItem ? "red" : "black"
                    font.pixelSize: 18
                }
                Text {
                    text: "性别:" + m_sex
                    color: item_data_1.ListView.isCurrentItem ? "red" : "black"
                    font.pixelSize: 18
                }
                Text {
                    text: "体重:" + m_weight
                    color: item_data_1.ListView.isCurrentItem ? "red" : "black"
                    font.pixelSize: 18
                }
                Text {
                    text: "身高:" + m_height
                    color: item_data_1.ListView.isCurrentItem ? "red" : "black"
                    font.pixelSize: 18
                }
                Text {
                    text: "创建日期:" + m_date
                    color: item_data_1.ListView.isCurrentItem ? "red" : "black"
                    font.pixelSize: 18
                }


            }
            MouseArea {
            anchors.fill: parent
            onClicked: item_data_1.ListView.view.currentIndex = index
            }
        }

    }

    ListModel{
        id: model_data_1

    }

    Rectangle{
        id: rec_error_1
        visible: false
        width: parent.width/3
        height: parent.height/3
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        color: "#fd5b5b"
        z: 15
        Text {
            text: qsTr("搜索结果为空，请重试")
            font.pointSize: 18
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
        }
    }

    ListView{
        id: view_data_1
        width: parent.width/3*2
        height: parent.height/3*2
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        model: model_data_1
        delegate: comp_data_1

        focus: true
        highlight: Rectangle{
            color: "lightblue"
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
                unloadDBView()
            }
        }
    }

    Item{
        id: item_choose_db_1
        width: parent.width/2
        height: width/10
        anchors.right: parent.right
        Row{
            anchors.fill: parent
            spacing: 10
            Rectangle{
                id: rec_search_1
                width: parent.width/5
                height: width/2
                color: "#eead00"
                Text {
                    text: qsTr("查询")
                    font.pointSize: 18
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                }
                MouseArea{
                    anchors.fill: parent
                    onPressed: {
                        rec_search_1.opacity = 0.5
                    }
                    onReleased: {
                        rec_search_1.opacity = 1
                    }
                    onClicked: {
                        view_data_1.visible = false
                        rec_search_str_1.visible = true
                        back_1.visible = false
                    }
                }
            }
            Rectangle{
                id: rec_insert_1
                width: parent.width/5
                height: width/2
                color: "#eead00"
                Text {
                    text: qsTr("插入")
                    font.pointSize: 18
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                }
                MouseArea{
                    anchors.fill: parent
                    onPressed: rec_insert_1.opacity = 0.5
                    onReleased: rec_insert_1.opacity = 1
                    onClicked: {
                        rec_insert_str_1.visible = true
                        view_data_1.visible = false
                        back_1.visible = false

                    }
                }
            }
            Rectangle{
                id: rec_delete_1
                width: parent.width/5
                height: width/2
                color: "#eead00"
                Text {
                    text: qsTr("删除")
                    font.pointSize: 18
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                }
                MouseArea{
                    anchors.fill: parent
                    onPressed: rec_delete_1.opacity = 0.5
                    onReleased: rec_delete_1.opacity = 1
                    onClicked: {
                        var viewIndex = view_data_1.currentIndex
                        var m_name = model_data_1.get(viewIndex).m_name
                        dbmanger.deleteData(m_name)
                        initPersonData()
                    }
                }
            }
        }
    }

    //搜索框
    Rectangle{
        id: rec_search_str_1
        visible: false
        width: parent.width/2
        height: parent.height/3
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        color: "lightblue"

        TextInput {
            id: input_search_str_1
            width: parent.width
            height: parent.height/3
            text: qsTr("")
            anchors.verticalCenter: parent.verticalCenter
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: 20
            color: "#0011ff"
            focus: true
            maximumLength: 10
        }
        Rectangle{
            width: parent.width
            height: parent.height/3
            opacity: 0.5
            anchors.verticalCenter: parent.verticalCenter
            color: "#fffb00"
        }
        Rectangle{
            width: parent.width/5
            height: parent.height/4
            color: "#0053ff"
            radius: 20
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            Text {
                text: qsTr("确定")
                font.pointSize: 15
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
            }
            MouseArea{
                anchors.fill: parent
                onPressed: parent.opacity = 0.5
                onReleased: parent.opacity = 1
                onClicked: {
                    rec_search_str_1.visible = false

                    var result = dbmanger.searchData(input_search_str_1.text.toString())
                    if(result[0]){
                        model_data_1.clear()
                    }
                    else{
                        rec_error_1.visible = true
                        timer_close_tip_error_1.start()
                    }

                    for(var i in result){
                        model_data_1.append({
                                                "m_name": result[i].name,
                                                "m_sex": result[i].sex,
                                                "m_weight": result[i].weight,
                                                "m_height": result[i].height,
                                                "m_date": result[i].date
                                            })
                    }
                    view_data_1.visible = true
                    back_1.visible = true
                    input_search_str_1.clear()
                }
            }

        }
    }

    //插入框
    Rectangle{
        id: rec_insert_str_1
        visible: false
        width: parent.width/2
        height: parent.height/3*2
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        color: "lightblue"


        Column{
            id: col_insert_input_1
            spacing: 5
            anchors.fill: parent
            Rectangle{
                color: "#eead00"
                width: parent.width
                height: parent.height/8
                Text {
                    text: qsTr("名字")
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    font.pointSize: 16
                    color: "white"
                    opacity: 0.5
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                }
                TextInput {
                    id: input_insert_str_1
                    anchors.fill: parent
                    text: qsTr("")
                    font.pixelSize: 20
                    color: "#0011ff"
                    focus: true
                    maximumLength: 10
                }
            }

            Rectangle{
                id: rectangle
                color: "#eead00"
                width: parent.width
                height: parent.height/8
                Text {
                    text: qsTr("性别")
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    font.pointSize: 16
                    color: "white"
                    opacity: 0.5
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                }
                TextInput {
                    id: input_insert_str_2
                    anchors.fill: parent
                    text: qsTr("")
                    font.pixelSize: 20
                    color: "#0011ff"
                    focus: true
                    maximumLength: 10
                }
            }

            Rectangle{
                color: "#eead00"
                width: parent.width
                height: parent.height/8
                Text {
                    text: qsTr("体重")
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    font.pointSize: 16
                    color: "white"
                    opacity: 0.5
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                }
                TextInput {
                    id: input_insert_str_3
                    anchors.fill: parent
                    text: qsTr("")
                    font.pixelSize: 20
                    color: "#0011ff"
                    focus: true
                    maximumLength: 10
                }
            }

            Rectangle{
                color: "#eead00"
                width: parent.width
                height: parent.height/8
                Text {
                    text: qsTr("身高")
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    font.pointSize: 16
                    color: "white"
                    opacity: 0.5
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                }
                TextInput {
                    id: input_insert_str_4
                    anchors.fill: parent
                    text: qsTr("")
                    font.pixelSize: 20
                    color: "#0011ff"
                    focus: true
                    maximumLength: 10
                }
            }

            Rectangle{
                color: "#eead00"
                width: parent.width
                height: parent.height/8

                Text {
                    text: qsTr("创建日期")
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    font.pointSize: 16
                    color: "white"
                    opacity: 0.5
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                }
                TextInput {
                    id: input_insert_str_5
                    anchors.fill: parent
                    text: qsTr("")
                    font.pixelSize: 20
                    color: "#0011ff"
                    focus: true
                    maximumLength: 10
                }
            }

        }


        Rectangle{
            width: parent.width/6
            height: parent.height/6
            color: "#0053ff"
            radius: 20
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            Text {
                text: qsTr("确定")
                font.pointSize: 15
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
            }
            MouseArea{
                anchors.fill: parent
                onPressed: parent.opacity = 0.5
                onReleased: parent.opacity = 1
                onClicked: {

                    var listData = [{
                        "name": input_insert_str_1.text,
                        "sex": input_insert_str_2.text,
                        "weight": input_insert_str_3.text,
                        "height": input_insert_str_4.text,
                        "date": input_insert_str_5.text
                    }]
                    if(listData[0].name && listData[0].sex && listData[0].weight && listData[0].height && listData[0].date){
                        dbmanger.insertData(listData)
                    }
                    initPersonData()
                    rec_insert_str_1.visible = false
                    view_data_1.visible = true
                    back_1.visible = true
                    input_insert_str_1.clear()
                    input_insert_str_2.clear()
                    input_insert_str_3.clear()
                    input_insert_str_4.clear()
                    input_insert_str_5.clear()
                }
            }
        }
    }

    function initPersonData(){
        var initResult = dbmanger.initPersonData()
        model_data_1.clear()
        for(var i in initResult){
            model_data_1.append({
                                    "m_name": initResult[i].name,
                                    "m_sex": initResult[i].sex,
                                    "m_weight": initResult[i].weight,
                                    "m_height": initResult[i].height,
                                    "m_date": initResult[i].date
                                })
        }


    }

    Component.onCompleted: {
        initPersonData()

    }

    Timer{
        id: timer_close_tip_error_1
        repeat: true
        interval: 2000
//        triggeredOnStart: true
        onTriggered: {
            rec_error_1.visible = false
            timer_close_tip_error_1.stop()
        }
    }


}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/

