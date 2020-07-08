import Felgo 3.0
import QtQuick 2.0
import QtQml 2.13
import "../common"

SceneBase {
    id: creditScene

    // background
    Image {
        id: menuBackground
        source: "../../assets/background/arctis2.png"
        anchors.fill:parent.gameWindowAnchorItem
        z:-2
    }

    // back button to leave scene
    MenuButton {
        text: "Back"
        // anchor the button to the gameWindowAnchorItem to be on the edge of the screen on any device
        anchors.right: creditScene.gameWindowAnchorItem.right
        anchors.rightMargin: 10
        anchors.top: creditScene.gameWindowAnchorItem.top
        anchors.topMargin: 10
        onClicked: backButtonPressed()
        color:Qt.rgba(1,1,1,0.5)
    }

    Image {
        id: title
        source: "../../assets/images/engine/milestone.png"
        anchors.horizontalCenter: creditScene.gameWindowAnchorItem.horizontalCenter
        anchors.top: creditScene.gameWindowAnchorItem.top
        height: 120*0.8
        width: 180*0.8
    }

    Text {
        id:author
        text:"作者：李姗，王鑫，张建明"
        font.pixelSize: 20
        anchors.top:title.bottom
        anchors.left: creditScene.gameWindowAnchorItem.left
    }
    Text{
        id:introduction
        text:"\n    此作品是模仿SurperTux2写的横版闯关游戏，类似与超级马里奥，可以吃\n金币,变大，踩敌人等等。"
        anchors.top: author.bottom
        anchors.left:author.left
    }

}
