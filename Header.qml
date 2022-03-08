import QtQuick 2.14
import QtQuick.Window 2.14

Item {
    id: header_1
    Rectangle{
        id: title_1
        Text {
            id: exe_name
            text: qsTr("InterviewDemo")
            anchors.left: parent.left
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            font.pointSize: 24
        }
    }
}


/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
