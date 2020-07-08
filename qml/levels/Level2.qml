import QtQuick 2.0
import Felgo 3.0
import "../common"
import "../entities"
import "../scenes"
LevelBase {
    levelName: "Level2"

    Ground{
        row:0
        column: 0
        widthSize: 20
    }

    Text {
        anchors.horizontalCenter: parent.horizontalCenter
        text: qsTr("NOT YET PRODUCED")
    }
}
