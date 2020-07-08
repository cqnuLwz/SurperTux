import QtQuick 2.0
import Felgo 3.0

EntityBase {
    id: player
    entityType: "player"
    width: tuxAnimation.width
    height: tuxAnimation.height

    // add some aliases for easier access to those properties from outside
    property alias collider: collider

    // add aliases for easier access
    property alias horizontalVelocity: collider.linearVelocity.x
    property alias verticalVelocity: collider.linearVelocity.y

    //collect coin
    property int coin: 0
    property bool dieImmediately:true
    property bool big:false
    property int contacts: 0
    // property binding to determine the state of the player like described above
    signal finish

    property alias tux:tuxAnimation

    onStateChanged: console.debug("player.state " + state)

    state: contacts > 0 ? "walk" : "jump"

    TexturePackerSpriteSequence{
        id:tuxAnimation

        TexturePackerSprite{
            name: "walk"
            source: "../../assets/tux/-hdSmall.json"
            frameNames: ["walk-0.png","walk-1.png","walk-2.png","walk-3.png","walk-4.png","walk-5.png","walk-6.png","walk-7.png"]
            frameRate: 10
        }
        TexturePackerSprite{
            name: "run"
            source: "../../assets/tux/-hdSmall.json"
            frameNames: ["run-0.png","run-1.png","run-2.png","run-3.png","run-4.png","run-5.png","run-6.png","run-7.png","run-8.png","run-9.png","run-10.png","run-11.png","run-12.png","run-13.png","run-14.png","run-14.png"]
            frameRate: 10
        }
        TexturePackerSprite{
            name: "jump"
            source: "../../assets/tux/-hdSmall.json"
            frameNames: ["jump-0.png"]
            frameRate: 10
        }
        TexturePackerSprite{
            name: "stand"
            source: "../../assets/tux/-hdSmall.json"
            frameNames: ["stand-0.png"]
        }
        TexturePackerSprite{
            name:"die"
            source: "../../assets/tux/-hdSmall.json"
            frameNames: ["gameover-0.png","gameover-1.png"]
        }
        TexturePackerSprite{
            name:"bigtux_walk"
            source: "../../assets/bigtux/-hdbigtux.json"
            frameNames: ["walk-1.png","walk-2.png","walk-3.png","walk-4.png","walk-5.png","walk-6.png","walk-7.png"]
            frameRate: 15
        }
        TexturePackerSprite{
            name:"bigtux_jump"
            source: "../../assets/bigtux/-hdbigtux.json"
            frameNames: ["jump-0.png"]
        }
        TexturePackerSprite{
            name:"bigtux_stand"
            source: "../../assets/bigtux/-hdbigtux.json"
            frameNames: ["stand-0.png"]
        }

        currentSprite: "stand"
    }

    BoxCollider {
        id: collider
        height: parent.height
        width: parent.width
        anchors.horizontalCenter: parent.horizontalCenter
        // this collider must be dynamic because we are moving it by applying forces and impulses
        bodyType: Body.Dynamic // this is the default value but I wanted to mention it ;)
        fixedRotation: true // we are running, not rolling...
        bullet: true // for super accurate collision detection, use this sparingly, because it's quite performance greedy
        sleepingAllowed: false
        // apply the horizontal value of the TwoAxisController as force to move the player left and right
        force: Qt.point(controller.xAxis*170*23,0)
        // limit the horizontal velocity
        onLinearVelocityChanged: {
            if(linearVelocity.x > 10) linearVelocity.x = 10
            if(linearVelocity.x < -10) linearVelocity.x = -10
        }

        // Category1: Player
        categories: Box.Category1
        // Category2: opponentWalk
        // Category3: solids
        // category4: ResetSensor
        // category5: PowerUp
        // Category6: QuestionMark
        // Category9: opponentJump body
        // Category15: groundColliderSensor

        collidesWith: Box.Category2 | Box.Category3|Box.Category4 | Box.Category5 | Box.Category6 | Box.Category9 |Box.Category15

        fixture.onBeginContact: {
            var otherEntity = other.getBody().target
            if(otherEntity.entityType === "platform" || otherEntity.entityType === "ground" || otherEntity.entityType === "brick" || otherEntity.entityType ===  "questionMark") {
                // ...increase the player's contacts
                contacts++
            }
            console.debug("player qml begin contact with " + otherEntity.entityType + " contacts:" + contacts)
        }
        fixture.onEndContact: {
            var otherEntity = other.getBody().target

            // when collision with another object ends, decrease the player's contacts
            if(otherEntity.entityType === "platform" || otherEntity.entityType === "ground" || otherEntity.entityType === "brick" || otherEntity.entityType ===  "questionMark")
                contacts--

            console.debug("player qml end contact with " + otherEntity.entityType + " contacts:" + contacts)
        }

        fixture.onContactChanged:{
            var otherEntity = other.getBody().target

            // on contact with an opponent, call the die() function
            if(otherEntity.entityType === "spike" || otherEntity.entityType === "jumper") {
                die(true)
            }else if(otherEntity.entityType === "walker" && !big){
                die(true)
            }else if(otherEntity.entityType === "walker" && big){
                bigtux_die()
                die(false)//player not die
                otherEntity.die(true)//opponetwalker not die

                audioManager.playSound("playerHit")
            }
        }


    }
    BoxCollider{
        id:feetSensor

        //adjust size
        width: 32 * parent.scale
        height: 10 * parent.scale

        //set position
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.bottom

        // the bodyType is dynamic
        bodyType: Body.Dynamic

        // Category10: player feet sensor
        categories: Box.Category10
        // Category3: opponent body, Category3: solids
        collidesWith: Box.Category2 | Box.Category3 |Box.category4

        collisionTestingOnlyMode: true

        fixture.onBeginContact: {
            var otherEntity = other.getBody().target

            // if colliding with opponent...
            if(otherEntity.entityType === "walker") {
                // ...calculate the lowest point of the player and
                // the opponent...
                var playerLowestY = player.y + player.height
                var oppLowestY = otherEntity.y + otherEntity.height

                // ...and if the player's y position is at least
                // 5px above the opponent's...
                if(playerLowestY < oppLowestY - 5) {
                    // ...kill opponent...
                    console.debug("kill opponent")
                    otherEntity.die(false)
                }
            }
        }

    }

    // slow to stand
    Timer {
        id: updateTimer
        // set this interval as high as possible to improve performance, but as low as needed so it still looks good
        interval: 60
        running: true
        repeat: true
        onTriggered: {
            var xAxis = controller.xAxis;
            // if xAxis is 0 (no movement command) we slow the player down until he stops
            if(xAxis === 0) {
                if(Math.abs(player.horizontalVelocity) > 10) player.horizontalVelocity /= 1.5
                else player.horizontalVelocity = 0
            }
        }
    }

    //change the direction
    function changeSpriteOrientation() {
        if(controller.xAxis == -1) {
            tuxAnimation.mirrorX = true
        }
        else if (controller.xAxis == 1) {
            tuxAnimation.mirrorX = false
        }
    }



    function jump() {
        big = false
        console.debug("jump requested at player.state " + state)
        if(player.state == "walk") {
            audioManager.playSound("playerJump")

            console.debug("do the jump")
            tuxAnimation.currentSprite = "jump"
            // for the jump, we simply set the upwards velocity of the collider
            collider.linearVelocity.y = -350
        }else{
            console.debug(player.state)
        }
    }

    function walk(){
        big = false
        tuxAnimation.currentSprite = "walk"
    }

    function stand(){
        big = false
        tuxAnimation.currentSprite = "stand"
    }
    function bigtux_walk(){
        big = true
        tuxAnimation.currentSprite = "bigtux_walk"
    }
    function bigtux_stand(){
        big = true
        tuxAnimation.currentSprite = "bigtux_stand"
    }
    function bigtux_jump(){
        big = true
        if(player.state == "walk") {
            audioManager.playSound("playerJump")
            tuxAnimation.currentSprite = "bigtux_jump"
            collider.linearVelocity.y = -350
        }
    }
    function bigtux_die(){
        big = false
        tuxAnimation.currentSprite = "stand"
    }

    Timer{
        id:resetLevelTime
        interval: 1500
        onTriggered: resetLevel()
    }

    function die(dieImmediately){
        if(dieImmediately === true){
            tuxAnimation.currentSprite = "die"
            collider.linearVelocity.y = -520
            audioManager.playSound("playerDie")
            resetLevelTime.start()
        }else{
            //do nothing..
        }
    }
    function resetContacts() {
        // Reset the contacts to ensure the player starts each level
        // with zero contacts.
        player.contacts = 0
        console.log("player qml player die, reset contacts:" + contacts)
    }
}
