import QtQuick 2.0
import Felgo 3.0

TiledEntityBase {
    id:goal
    entityType: "goal"

    z:1
    Column{
        Repeater{
            model: heightSize
            Row{
                id:grassRow
                Repeater {
                    model: widthSize
                    Tile {
                        sprite.frameNames: ["goal2-4.png"]
                    }
                }
            }
        }
    }

    BoxCollider {
        x:9
        y:9
        width: 15
        height: 200
        bodyType: Body.Static
        collisionTestingOnlyMode: true

        fixture.onBeginContact: {
            var otherEntity = other.getBody().target
            if(otherEntity.entityType === "player") {
                console.debug("finsh")
                gameScene.player.finish()
            }
        }

        // Category3: solids
        categories: Box.Category3
        // Category1: player
        // Category2: opponent
        collidesWith: Box.Category1 | Box.Category2

    }
}
