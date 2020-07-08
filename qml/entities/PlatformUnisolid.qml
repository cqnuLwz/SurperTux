import QtQuick 2.0
import Felgo 3.0

TiledEntityBase {
    id:unisolidGround
    entityType: "platform"

    Column{
        Repeater{
            model: heightSize
            Row{
                id:grassRow
                Repeater {
                    model: widthSize
                    Tile {
                        sprite.frameNames: ["unisolid1.png"]
                    }
                }
            }
        }
    }

    BoxCollider {
        anchors.fill: parent
        bodyType: Body.Static

        //friction and damp to 0, do't allow player to collid the edge of entity
        friction: 0
        angularDamping: 0

        // set size and position to fit the sprite
        width: 32
        height: 16

        // Category3: solids
        categories: Box.Category3
        // Category1: player
        // Category2: opponent
        collidesWith: Box.Category1 | Box.Category2
    }
}
