import QtQuick 2.0
import Felgo 3.0

TiledEntityBase {
    id: grass
    entityType: "background"

    y: gameScene.height - (column+1)*gameScene.gridSize - 14

    Column{
        Repeater{
            model: heightSize
            Row{
                id:grassRow
                Repeater {
                    model: widthSize
                    Tile {
                        sprite.frameNames: ["grass1.png"]
                    }
                }
            }
        }
    }

}
