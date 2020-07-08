import QtQuick 2.0
import Felgo 3.0
import "../common"
TiledEntityBase {
    id:brick
    entityType: "brick"

    Column{
        Repeater{
            model: heightSize
            Row{
                id:grassRow
                Repeater {
                    model: widthSize
                    Tile {
                        sprite.frameNames: ["brick1.png"]
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
        collidesWith: Box.Category1 | Box.Category2 | Box.Category5
    }

    BoxCollider{
        anchors.bottom:parent.bottom
        anchors.bottomMargin: -0.5
        anchors.left: parent.left
        anchors.leftMargin: 0.5
        anchors.right: parent.right
        anchors.rightMargin: 0.5
        bodyType: Body.Static

        friction: 0
        angularDamping: 0

        // Category3: solids
        categories: Box.Category3
        // Category1: player
        // Category2: opponent
        collidesWith: Box.Category1| Box.Category5

        fixture.onBeginContact: {
            audioManager.playSound("brick")

        }
    }
}
