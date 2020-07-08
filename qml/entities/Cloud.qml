import QtQuick 2.0
import Felgo 3.0

TiledEntityBase {
    id: cloud
    entityType: "background"

    z: -1

    Column{
        Repeater{
            model: heightSize
            Row{
                id:grassRow
                Repeater {
                    model: widthSize
                    Tile {
                        sprite.frameNames: ["cloud.png"]
                        width: 64
                        height: 32
                    }
                }
            }
        }
    }

}
