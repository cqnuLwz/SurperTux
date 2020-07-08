import QtQuick 2.0
import Felgo 3.0


TiledEntityBase {
    id: powerUpFlower
    entityType: "powerUp"
    poolingEnabled:true

    // this property is true when the player collected the powerUp
    property bool collected: false
    // this property is true when the player collides the powerUp
    property bool isCollided: false
    // this property for player to eat power
    property int collideTimes: 0

    height: 32

    TexturePackerSpriteSequence{
        id:powerUpAnimation
        width: 16
        height: 16
        anchors.top: parent.top
        TexturePackerSprite{
            name: "fireFlower"
            source: "../../assets/powerUp/-hd2powerUp.json"
            frameNames: ["fire_flower-0.png"/*,"fire_flower.png","fire_flower.png","fire_flower.png"*/]

        }
        currentSprite: "fireFlower"
        visible: isCollided
    }

    BoxCollider {
        id: collider

        // fill animation collider
        anchors.bottom: parent.bottom

        // disable collider when coin is collected
        active: !collected

        // the collider is static until the play collider it
        // for collisions
        bodyType: Body.Static
        fixture.onBeginContact: {
            console.debug(" flower fixture")

            var otherEntity = other.getBody().target

            // on contact with player ,this will rase up and shown
            if(otherEntity.entityType === "player" && isCollided) {
                collect()
            }
        }
    }

    BoxCollider{
        id:colliderSensor

        anchors.bottom: parent.bottom
        anchors.bottomMargin: -1
        anchors.left: parent.left
        anchors.leftMargin: 1
        anchors.right: parent.right
        anchors.rightMargin: 1
        height: 2

        bodyType: Body.Static
        fixture.onBeginContact: {
            console.debug(" flower sensor")

            var otherEntity = other.getBody().target

            // on contact with player ,this will rase up and shown
            if(otherEntity.entityType === "player" ) {
                collided()
                isCollided = true
                collideTimes++
            }
        }
        // Category5: powerUp
        categories: Box.Category5
        // Category1: player
        collidesWith: Box.Category1
    }

    //set egg to visible when player collide it
    function collided(){
        collider.categories = Box.Category5
        collider.collidesWith = Box.Category1
    }

    // set collected to true
    function collect() {
        console.debug("collect powerUp flower")
        powerUpFlower.collected = true
        removeEntity()
        //to be fire man
    }

    // reset coin
    function reset() {
        coin.collected = false
    }
}
