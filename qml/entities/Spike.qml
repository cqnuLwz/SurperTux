import QtQuick 2.0
import Felgo 3.0

TiledEntityBase {
    entityType: "spike"


    Column{
        Repeater{
            model: heightSize
            Row{
                id:grassRow
                Repeater {
                    model: widthSize
                    Tile {
                        sprite.frameNames: ["spike_up.png"]
                    }
                }
            }
        }
    }


    BoxCollider {
        anchors.fill: parent
        bodyType: Body.Static

        //mo cha li
        friction: 0.5
        fixture.onBeginContact: {
            var otherEntity = other.getBody().target
            if(otherEntity.entityType === "player") player.die(true)
        }

        // Category3: solids
        categories: Box.Category3
        // Category1: player
        // Category2: opponent
        collidesWith: Box.Category1 | Box.Category2
    }
}
