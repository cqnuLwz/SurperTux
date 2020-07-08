import QtQuick 2.0
import Felgo 3.0

TiledEntityBase {
    id:ground
    entityType: "ground"

    width: 32 * widthSize
    height: 32 * heightSize
    Column{
        Repeater{
            model: heightSize
            Row{
                id:grassRow
                Repeater {
                    model: widthSize
                    Tile {
                        sprite.frameNames: ["block5.png"]
                        width: 32
                        height: 32
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

        // Category3: solids
        categories: Box.Category3
        // Category1: player
        // Category2: opponent
        // Category5: powerUp
        // Category8: opponentJump body
        // Category9: opponentJump sensor
        // Category10: player feet
        // Category11: opponentWalk sensor
        collidesWith: Box.Category1 | Box.Category2 | Box.Category5 | Box.Category8 | Box.Category9 | Box.Category10 | Box.Category11
    }
}
