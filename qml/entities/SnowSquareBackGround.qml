import QtQuick 2.0
import Felgo 3.0

TiledEntityBase {
    id: grass
    entityType: "background"

    z: -1
    y: gameScene.height - (column+1)*gameScene.gridSize - 25

    Column{
        Repeater{
            model: heightSize
            Row{
                id:grassRow
                Repeater {
                    model: widthSize
                    Tile {
                        sprite.frameNames: ["background.png"]
                        width: 32
                        height: 48
                    }
                }
            }
        }
    }

}
