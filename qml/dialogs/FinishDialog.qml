import QtQuick 2.0
import Felgo 3.0
import "../common"
import "../entities"
DialogBase {
  id: finishDialog

  // this dialog should not be closeable
  closeableByClickOnBackground: false

  // this holds the score, the player achieved
  property int score:0

  Text {
    anchors.bottom:score.top
    anchors.bottomMargin: 50
    anchors.left: score.left

    anchors.verticalCenterOffset: -20

    text: "Finished!"

    color: "white"
  }

  Text {
    id:score
    anchors.top: parent.top
    anchors.topMargin: 100
    anchors.left:parent.left
    anchors.leftMargin: 3700
    text: qsTr("Score: "+(player.coin*20+gameScene.time))
    color: "white"
  }

  // Buttons ------------------------------------------

  GameButton {
    id:restartButton

    text: "Restart"

    width: 100

    anchors.bottom: parent.bottom
    anchors.bottomMargin: 50
    anchors.left:parent.left
    anchors.leftMargin: 3800

    onClicked: {
      // close dialog
      finishDialog.opacity = 0

      // reset state to play
      gameScene.state = "play"

      // reset and restart level
      gameScene.resetLevel()
        console.debug(score)
    }

  }

  GameButton {
    id: cancelButton

    text: "Menu"

    width: 100

    anchors.bottom: parent.bottom
    anchors.bottomMargin: 50
    anchors.leftMargin: 100
    anchors.left:restartButton.right

    onClicked: {
      // close dialog
      finishDialog.opacity = 0

      // reset state to play
      gameScene.state = "play"

      // go back to menu
      backButtonPressed()
//      audioManager.handleMusic();
        audioManager.stopSound("finish")
    }
  }
  function change(){
      opacity=1
      console.debug("opacity changed")
  }
}

