import QtQuick 2.0
import Felgo 3.0

TiledEntityBase {
    id:sideGround
    entityType: "sideGround"

    x: row*gameScene.gridSize - 1
    width: 2

    BoxCollider{
        id:colliderSensor
        anchors.fill: parent
        //friction and damp to 0, do't allow player to collid the edge of entity
        friction: 0
        angularDamping: 0

        bodyType: Body.Static

        // Category15: groundColliderSensor
        categories: Box.Category15
        //category1:Player
        collidesWith: Box.Category1
    }
}


