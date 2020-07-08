import QtQuick 2.0
import Felgo 3.0

TiledEntityBase {
    id: cloud
    entityType: "goal1"

    Column{
        Repeater{
            model: heightSize
            Row{
                id:grassRow
                Repeater {
                    model: widthSize
                    Tile {
                        sprite.frameNames: ["goal1-4.png"]
                    }
                }
            }
        }
    }

}
