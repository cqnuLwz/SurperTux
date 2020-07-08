import Felgo 3.0
import QtQuick 2.0
import "../common"

SceneBase {
    id: selectLevelScene

    // signal indicating that a level has been selected
    signal levelPressed(string selectedLevel)
    height: 320

    ParallaxScrollingBackground {
      id:bgImg
      sourceImage: "../../assets/background/arctis2.png"
      sourceImage2: "../../assets/background/arctis2.png"

      // we move the parallax layers at the same speed as the player
      movementVelocity: Qt.point(-20,0)
      // the speed then gets multiplied by this ratio to create the parallax effect
      ratio: Qt.point(0.8,0)
      z:-1
    }

    // back button to leave scene
    MenuButton {
        text: "Back"
        // anchor the button to the gameWindowAnchorItem to be on the edge of the screen on any device
        anchors.right: selectLevelScene.gameWindowAnchorItem.right
        anchors.rightMargin: 10
        anchors.top: selectLevelScene.gameWindowAnchorItem.top
        anchors.topMargin: 10
        onClicked: backButtonPressed()
        color:Qt.rgba(1,1,1,0.5)
    }

    // levels to be selected
    Grid {
        anchors.centerIn: parent
        spacing: 10
        columns: 5

        MenuButton {
            text: "1"
            width: 50
            height: 50
            color:Qt.rgba(1,1,1,0.5)

            onClicked: {
                levelPressed("Level1.qml")
            }
        }
        MenuButton {
            text: "2"
            width: 50
            height: 50
            color:Qt.rgba(1,1,1,0.5)

            onClicked: {
                levelPressed("Level2.qml")
            }
        }
        MenuButton {
            text: "3"
            width: 50
            height: 50
            color:Qt.rgba(1,1,1,0.5)

            onClicked: {
                levelPressed("Level3.qml")
            }
        }
    }
}
