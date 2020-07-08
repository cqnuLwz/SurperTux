import QtQuick 2.0
import Felgo 3.0
import "../common"

TiledEntityBase{
    id:walker
    entityType: "walker"

    //start position
    property int startX
    property int startY

    property bool alive: true
    property bool hidden: false
    property int speed: 70
    property int direction: 1

    property alias opponentwalker:opponentwalker

    opponentwalker.mirrorX: collider.linearVelocity.x < 0? false:true

    width: opponentwalker.width
    height: opponentwalker.height

    TexturePackerSpriteSequence{
        id:opponentwalker

        visible: !hidden
        TexturePackerSprite{
            name:"opponent_walk"
            source: "../../assets/tux_entity_sprites/-hdtux_sprites.json"
            frameNames: ["creatures/sport-left-0.png","creatures/sport-left-1.png","creatures/sport-left-2.png"]
            frameRate: 5
        }
        TexturePackerSprite{
            name:"walk_die"
            source: "../../assets/tux_entity_sprites/-hdtux_sprites.json"
            frameNames: ["creatures/squished-left.png"]
        }
    }

    Timer{
        id:hideTimer
        interval: 2000

        onTriggered: hidden = true
    }

    BoxCollider{
        id:collider
        height: parent.height
        width: 30
        anchors.horizontalCenter: parent.horizontalCenter


        //category2:opponent
        categories: Box.Category2
        //category1:player,category3:solid
        // Category10: player feet sensor
        collidesWith: Box.Category1 | Box.Category3 | Box.Category10 | Box.Category2

        linearVelocity: Qt.point(direction * speed, 0)
        onLinearVelocityChanged: {
            // if the opponent stops moving, reverse direction
            if(linearVelocity.x === 0)
                direction *= -1

            // make sure the speed is constant
            linearVelocity.x = direction * speed
        }
    }

    //leftcheck
    BoxCollider{
        id:leftAbyssCheck

        width: 5
        height: 5

        anchors.top: parent.bottom
        anchors.left: parent.left

        //category11:opponent sensor
        categories: Box.Category11

        //category3:solid
        collidesWith: Box.Category3
        collisionTestingOnlyMode: true

        property int contacts: 0

        // handle number of contacts
        fixture.onBeginContact: contacts++
        fixture.onEndContact: if(contacts > 0) contacts--

        // change direction when there are no contacts
        onContactsChanged: if(contacts == 0) direction *= -1
    }

    //rightcheck
    BoxCollider{
        id:rightAbyssCheck

        width: 5
        height: 5

        anchors.top: parent.bottom
        anchors.left: parent.left

        //category11:opponent sensor
        categories: Box.Category11

        //category3:solid
        collidesWith: Box.Category3
        collisionTestingOnlyMode: true

        property int contacts: 0

        // handle number of contacts
        fixture.onBeginContact: contacts++
        fixture.onEndContact: if(contacts > 0) contacts--

        // change direction when there are no contacts
        onContactsChanged: if(contacts == 0) direction *= -1
    }

    function die(){
        opponentwalker.currentSprite = "walk_die"
        audioManager.playSound("opponentWalkerDie")
        hideTimer.start()
        removeEntity()
        console.debug("walk die")
    }
    function walk(){
        opponentwalker.currentSprite = "opponent_walk"
    }
    function updateStartPosition()
    {
        startX = x
        startY = y
    }
    function reset_super()
    {
        // reset alive property
        alive = true

        // stop hideTimer, to avoid unwanted, delayed hiding of the opponent
        hideTimer.stop()
        // reset hidden
        hidden = false

        // reset position
        x = startX
        y = startY

        // reset velocity
        collider.linearVelocity.x = 0
        collider.linearVelocity.y = 0

        // reset force
        collider.force = Qt.point(0, 0)
    }
    function reset() {
        // this is the reset function of the base entity Opponent.qml
        reset_super()

        // reset direction
        direction = -1

        // reset force
        collider.linearVelocity.x = Qt.point(direction * speed, 0)
    }
}

