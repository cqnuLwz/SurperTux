import Felgo 3.0
import QtQuick 2.0

Item {
  width: gameScene.gridSize
  height: gameScene.gridSize

   property alias sprite: sprite

  TexturePackerAnimatedSprite{
      id:sprite
      anchors.fill: parent
      source: "../../assets/static/-hd2static.json"
  }

}
