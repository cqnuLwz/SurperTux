/*
 *author:zhangjianming
 *
**/
import Felgo 3.0
import QtQuick 2.0
import QtQml 2.13
import "../common"

SceneBase {
    id: menuScene

    FontLoader{id:surperTuxFont ;source: "../../assets/fonts/SuperTux-Medium.ttf"}

    // signal indicating that the selectLevelScene should be displayed
    signal selectLevelPressed
    // signal indicating that the creditsScene should be displayed
    signal creditsPressed
    signal exitPressed
    // background
    Image {
        id: menuBackground
        source: "../../assets/background/arctis2.png"
        anchors.fill:parent.gameWindowAnchorItem
        z:-2
    }
    Image {
        id: windowFrame
        source: "../../assets/images/engine/frame.png"
        anchors.fill:parent.gameWindowAnchorItem
        z:-1
    }
    // the "logo"
    Image {
        id: title
        source: "../../assets/images/engine/logo.png"

        anchors.horizontalCenter: menuScene.gameWindowAnchorItem.horizontalCenter
        anchors.bottom: menu.top
        height: 120*0.8
        width: 180*0.8
    }

    // menu
    Rectangle {
        id:menu
        anchors.centerIn: parent
        width:80
        height: 100


        color:Qt.rgba(59/255,103/255,199/255,0.3)
        radius: height/16
        border.color: "#3e63c0"


        MenuButton {
            Text {
                text: "Starts"
                color: "white"
                font.family:surperTuxFont.name
                anchors.horizontalCenter: parent.horizontalCenter
            }

            color:Qt.rgba(143,176,221,0)
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.topMargin: 10
            onClicked: selectLevelPressed()
        }

        MenuButton {
            color:Qt.rgba(143,176,221,0)
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right

            anchors.topMargin: 45
            Text {
                text: "Credits"
                color: "white"
                font.family:surperTuxFont.name
                anchors.horizontalCenter: parent.horizontalCenter
            }
            onClicked: creditsPressed()
        }

        MenuButton {

            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            color:Qt.rgba(143,176,221,0)
            anchors.topMargin: 80
            Text {
                text: "Exit"
                color: "white"
                font.family:surperTuxFont.name
                anchors.horizontalCenter: parent.horizontalCenter
            }
            onClicked: exitPressed()
        }
    }

    MultiResolutionImage {
        id: musicButton

        width: 30
        height: 30
        // show music icon
        source: "../../assets/images/engine/music.png"
        // reduce opacity, if music is disabled
        opacity: settings.musicEnabled ? 0.9 : 0.4

        anchors.bottom: parent.bottom
        anchors.bottomMargin: 70
        anchors.topMargin: 30
        anchors.left: parent.left
        anchors.leftMargin: 30

        MouseArea {
            anchors.fill: parent

            onClicked: {
                // switch between enabled and disabled
                if(settings.musicEnabled)
                    settings.musicEnabled = false
                else
                    settings.musicEnabled = true
            }
        }
    }

    MultiResolutionImage {
        id: soundButton
        width: 30
        height: 30
        // show sound_on or sound_off icon, depending on if sound is enabled or not
        source: settings.soundEnabled ? "../../assets/images/engine/sound_on.png" : "../../assets/images/engine/sound_off.png"
        // reduce opacity, if sound is disabled
        opacity: settings.soundEnabled ? 0.9 : 0.4

        anchors.top: musicButton.bottom
        anchors.topMargin: 10
        anchors.left: parent.left
        anchors.leftMargin: 30

        MouseArea {
            anchors.fill: parent

            onClicked: {
                // switch between enabled and disabled
                if(settings.soundEnabled===true) {
                    settings.soundEnabled = false
                    console.debug("sounds false")
                }
                else{
                    settings.soundEnabled = true
                    console.debug("sounds true")
                    // play sound to signal, that sound is now on
                    audioManager.playSound("collectCoin")
                }
            }
        }
    }
    Image {
        source: "../../assets/felgo-logo.png"
        width: 15
        height: 15
        anchors.right: menuScene.gameWindowAnchorItem.right
        anchors.rightMargin: 10
        anchors.bottom: menuScene.gameWindowAnchorItem.bottom
        anchors.bottomMargin: 10
    }

}
