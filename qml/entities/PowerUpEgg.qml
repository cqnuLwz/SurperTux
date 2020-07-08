import QtQuick 2.0
import Felgo 3.0
import "../common"
TiledEntityBase {
    id: powerUpEgg
    entityType: "powerUp"

    y: gameScene.height - (column+1)*gameScene.gridSize + 1

    // this property is true when the player collected the powerUp
    property bool collected: false
    // this property is true when the player collides the powerUp
    property bool isCollided: false
    // this property for player to eat power
    property int collideTimes: 0

    // roll speed
    property int speed: 70
    property int direction: -1



    TexturePackerSpriteSequence{
        id:powerUpAnimation
        anchors.fill: parent
        TexturePackerSprite{
            name: "egg"
            source: "../../assets/powerUp/-hd2powerUp.json"
            frameNames: ["egg-shade.png"]
        }
        currentSprite: "egg"
        visible: isCollided
    }

    CircleCollider {
        id: collider

        //        // make the collider a little smaller than the sprite
        radius: parent.width / 2


        anchors.fill: parent

        // disable collider when power is collected
        active: !collected

        // the collider is static until the play collider it
        bodyType: Body.Static

        onLinearVelocityChanged: {
            // if the power stops moving, reverse direction
            if(linearVelocity.x === 0)
                direction *= -1

            // make sure the speed is constant
            linearVelocity.x = direction * speed
        }

        fixture.onBeginContact:   {
            console.debug("collide egg")
            var otherEntity = other.getBody().target

            // on contact with player ,this will rise up and shown
            if(otherEntity.entityType === "player" ) {
                collided()
                isCollided = true
                if(collideTimes > 0) collect()
                collideTimes++
            }
        }
        // Category5: powerUp
        categories: Box.Category5
        // Category1: player
        // Category3: solid
        collidesWith: Box.Category1 | Box.Category3
    }

    //left and right check
    BoxCollider{
        id:leftCheck

        width: 3
        height: 5
        anchors.top: parent.top - 2
        anchors.left: parent.left - 2

        bodyType: Body.Static

        //        categories: Box.category5

        //category3:solid
        collidesWith: Box.Category3

        property int contacts : 0

        // handle number of contacts
        fixture.onBeginContact:   {
            contacts++
            console.debug("collide egg ")
            var otherEntity = other.getBody().target

            // on contact with player, collect it
            if(otherEntity.entityType === "player" ) {
                collect()
            }
        }
        fixture.onEndContact: if(contacts > 0) contacts--

        // change direction when there are no contacts
        onContactsChanged: if(contacts == 0) direction *= -1


    }

    //set egg to rasie up to sky when player collide it
    function collided(){
        console.debug(" collide")
        collider.bodyType = Body.Dynamic
        collider.linearVelocity.y = -300
    }

    // set collected to true
    function collect() {
        console.debug("collect powerUp")
        powerUpEgg.collected = true
        removeEntity()
        //to be big

        player.resetContacts()
        player.bigtux_stand()
        audioManager.playSound("playerGrow")
    }

    // reset coin
    function reset() {
        powerUpEgg.collected = false
    }
}
