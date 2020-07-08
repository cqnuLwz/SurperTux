import QtQuick 2.0
import Felgo 3.0

TiledEntityBase {
    id: polygonUnisolid
    entityType: "background"

    z: -2

    x: row*gameScene.gridSize - 10
    y: gameScene.height - (column+1)*gameScene.gridSize - 10

    Row{
        id:polygonUnisolidRow
        Repeater {
            model: size
            Tile {
                sprite.source: "../../assets/background/unisolid3.png"
            }
        }
    }

}
