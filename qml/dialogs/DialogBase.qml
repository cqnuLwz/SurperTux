
import QtQuick 2.0
import Felgo 3.0
import "../common"

Item {
  id: dialogBase

  // make it appear in front of anything else
  z: 1000

  // fill game window
//  anchors.fill: parent.gameWindowAnchorItem
  width: 100000
  height: 100
  opacity: 0// opaque by default
//  enabled: opacity > 0 // otherwise this item would receive mouse events when opaque

  // if this is true, the user can close this dialog by clicking anywhere in the background
  property bool closeableByClickOnBackground: true

  // this MouseArea fills the whole screen
//  MouseArea {
//    anchors.fill: parent

//    // when it's clicked and closeableByClickOnBackground is true, the dialog should be closed
//    onClicked: {
//      if(closeableByClickOnBackground)
//        dialogBase.opacity = 0
//    }

//  }

  Rectangle{
      color: "black"
      anchors.top: parent.top
      anchors.topMargin: -320
      anchors.left: parent.left
      anchors.right: parent.right
      anchors.bottom: parent.bottom
      anchors.bottomMargin: -320
      opacity:0.9

  }

  function change(){
      opacity=1
      console.debug("opacity changed")

  }
}

