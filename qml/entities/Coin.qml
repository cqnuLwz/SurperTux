import QtQuick 2.0
import Felgo 3.0


TiledEntityBase {
    id: coin
    entityType: "coin"

    poolingEnabled:true

    // this property is true when the player collected the coin
    property bool collected: false
    TexturePackerSpriteSequence{
        id:coinAnimation
        anchors.fill: parent
        TexturePackerSprite{
            name: "coin"
            source: "../../assets/coin/-hd2coin.json"
            frameNames: ["coin-0.png","coin-1.png","coin-2.png","coin-3.png","coin-4.png","coin-5.png","coin-6.png","coin-7.png","coin-8.png","coin-9.png","coin-10.png","coin-11.png","coin-12.png","coin-13.png","coin-14.png","coin-15.png"]
            frameRate: 10
        }
        visible: !collected
    }

    CircleCollider {
        id: collider

        // make the collider a little smaller than the sprite
        radius: parent.width / 2

        // center collider
        anchors.fill: coinAnimation

        // disable collider when coin is collected
        active: !collected

        // the collider is static (shouldn't move) and should only test
        // for collisions
        bodyType: Body.Static
        collisionTestingOnlyMode: true

        fixture.onBeginContact:   {
            console.debug("fixture")

            collect()

        }
        // Category3: solids
        categories: Box.Category3
        // Category1: player
        // Category2: opponent
        collidesWith: Box.Category1 | Box.Category2
    }

    // set collected to true
    function collect() {
        console.debug("collect coin" + Player.coin)
        coin.collected = true

        // for every collected coin, the time gets set back a little bit
        // gameScene.time -= 5
        player.coin++
         audioManager.playSound("collectCoin")

    }

    // reset coin
    function reset() {
        coin.collected = false
    }
}
