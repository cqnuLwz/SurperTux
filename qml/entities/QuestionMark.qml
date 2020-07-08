import QtQuick 2.0
import Felgo 3.0
import "../common"
TiledEntityBase {
    id: questionMark
    entityType: "questionMark"

    //set full state ,if state is 1 ,full is true else full is false
    property int full: 1
    TexturePackerSpriteSequence{
        id:iceBlock
        anchors.fill: parent
        TexturePackerSprite{
            name: "full"
            source: "../../assets/questionMark/-hd2questionMark.json"
            frameNames: ["full-0.png","full-1.png","full-2.png","full-3.png","full-4.png"]
            frameRate: 8
        }
        TexturePackerSprite{
            name: "empty"
            source: "../../assets/questionMark/-hd2questionMark.json"
            frameNames: ["empty.png"]
            frameRate: 1
        }
        currentSprite: "full"
//        scale: 0.5
    }

    BoxCollider {
        id:collider
        //friction and damp to 0, do't allow player to collid the edge of entity
        friction: 0
        angularDamping: 0

        anchors.fill: parent
        bodyType: Body.Static

        //category3:soild
        categories: Box.Category3
        // Category1: player
        // Category2: opponent
        // Category5: powerUp
        // Category10: player feet
        // Category11: opponentWalk sensor
        collidesWith: Box.Category1 | Box.Category2  | Box.Category10 | Box.Category11
    }

    BoxCollider{
        id:colliderSensor
        //friction and damp to 0, do't allow player to collid the edge of entity
        friction: 0
        angularDamping: 0

        anchors.bottom: parent.bottom
        anchors.bottomMargin: -1
        anchors.left: parent.left
        anchors.leftMargin: 1
        anchors.right: parent.right
        anchors.rightMargin: 1
        height: 2

        bodyType: Body.Static
        fixture.onBeginContact: {
            if(full==1){
            iceBlock.currentSprite="empty"
            player.coin++
            audioManager.playSound("iceBrick")
            full=0
            }else{
                //do nothing
            }

        }
        // Category6: QuestionMark
        categories: Box.Category6
        //category1:Player
        collidesWith: Box.Category1

    }
}
