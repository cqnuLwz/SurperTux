import Felgo 3.0
import QtQuick 2.13
import "../common"
import "../entities"
import "../levels"
import "../gameElements"
import "../dialogs"

SceneBase {
    id:gameScene
    // the filename of the current level gets stored here, it is used for loading the
    property string activeLevelFileName
    // the currently loaded level gets stored here
    property variant activeLevel

    property int offsetBeforeScrollingStarts: gameScene.width/2

    // the time the user is playing the current level, since his last death
    property int time: 300

    property alias container: viewPort
    property alias player: player
    property alias physicsWorld: physicsWorld

    // set the scene alignment
    sceneAlignmentX: "left"
    sceneAlignmentY: "top"

    // the level's grid size
    gridSize: 16

    // set the name of the current level, this will cause the Loader to load the corresponding level
    function setLevel(fileName) {
        activeLevelFileName = fileName
    }

    // back button to leave scene
    MenuButton {
        text: "Back"
        z:1
        // anchor the button to the gameWindowAnchorItem to be on the edge of the screen on any device
        anchors.right: gameScene.gameWindowAnchorItem.right
        anchors.rightMargin: 10
        anchors.top: gameScene.gameWindowAnchorItem.top
        anchors.topMargin: 10
        onClicked: backButtonPressed()
    }

    //Set the background to move with the character
    ParallaxScrollingBackground {
        id:bgImg
        sourceImage: "../../assets/background/arctis2.png"
        sourceImage2: "../../assets/background/arctis2.png"
        anchors.left: gameScene.gameWindowAnchorItem.left
        anchors.bottom: gameScene.gameWindowAnchorItem.bottom

        anchors.horizontalCenter: gameScene.gameWindowAnchorItem.horizontalCenter
        // we move the parallax layers at the same speed as the player
        movementVelocity: player.x > offsetBeforeScrollingStarts ? Qt.point(-player.horizontalVelocity,0) : Qt.point(0,0)
        // the speed then gets multiplied by this ratio to create the parallax effect
        ratio: Qt.point(0.3,0)
        z:-1
    }

    // camera
    Camera {
        id: camera

        // set the gameWindowSize and entityContainer with which the camera works with
        gameWindowSize: Qt.point(gameScene.gameWindowAnchorItem.width, gameScene.gameWindowAnchorItem.height)
        entityContainer: container

        // disable the camera's mouseArea, since we handle the controls of the free
        // moving camera ourself, in EditorUnderlay
        mouseAreaEnabled: false

        // the camera follows the player when not in edit mode
        focusedObject: player

        // set focused offset
        focusOffset: Qt.point(0.5, 0.3)

        // set limits
        limitLeft: 0
        limitBottom: 0

        freeOffset:  Qt.point(0, 0)

    }

    state: "play"

    states: [
        State {
            name: "play"
            StateChangeScript {script: audioManager.handleMusic()}
        },
        State {
            name: "finish"
            PropertyChanges {target: physicsWorld; running: false} // disable physics
        }
    ]



    // this is the moving item containing the level and player
    Item {
        id: viewPort
        height: gameScene.height
        width: gameScene.width
        anchors.bottom: gameScene.gameWindowAnchorItem.bottom
        x: player.x > offsetBeforeScrollingStarts ? offsetBeforeScrollingStarts-player.x : 0

        PhysicsWorld {
            id: physicsWorld
            gravity: Qt.point(0, 25)
            debugDrawVisible: false // enable this for physics debugging
            z: 1000

            //this is called before the Box2DWorld handles contact events
            onPreSolve: {
                var entityA = contact.fixtureA.getBody().target
                var entityB = contact.fixtureB.getBody().target

                // We want our platforms to be cloud platforms.
                // A cloud platform is a platform through which you can jump
                // from below.

                // If one of the colliding entities is a platform,
                // and the other a moving entity (player or opponent),
                // and the moving entity is below the platform...
                if(entityA.entityType === "platform" && (entityB.entityType === "player" || entityB.entityType === "opponent") && entityB.y + entityB.height > entityA.y + 1// add +1 to avoid wrong border-line decisions
                        || (entityA.entityType === "player" || entityA.entityType === "opponent") && entityB.entityType === "platform" && entityA.y + entityA.height > entityB.y + 1) {

                    // ...disable the contact
                    contact.enabled = false
                }
            }
        }

        // load levels at runtime
        Loader {
            id: levelLoader
            source: activeLevelFileName != "" ? "../levels/" + activeLevelFileName : ""
            onLoaded: {
                // since we did not define a width and height in the level item itself, we are doing it here
                item.width = gameScene.gameWindowAnchorItem.width
                item.height = gameScene.gameWindowAnchorItem.height
                // store the loaded level as activeLevel for easier access
                activeLevel = item
            }
        }

        Player {
            id: player
            x: 20
            y: 100
            z:1

            onFinish: {

                // set state to finish, to freeze the game
                gameScene.state = "finish"
                console.debug("player finish")
                // show finish dialog
                finishDialog.change()
                console.debug(player.coin)

                levelTimer.repeat=false
                audioManager.playSound("finish")
                                audioManager.startMusic("")
                audioManager.stopSound("playerJump")
                audioManager.stopSound("bigJump")
            }

        }

        FinishDialog {
            id: finishDialog
        }

        ResetSensor {
            width: player.width
            height: 10
            x: player.x
            anchors.bottom: viewPort.bottom
            // if the player collides with the reset sensor, he goes back to the start
            onContact: {
                player.die(true)
            }
            // this is just for you to see how the sensor moves, in your real game, you should position it lower, outside of the visible area
            Rectangle {
                anchors.fill: parent
                color: "yellow"
                opacity: 0
            }
        }
    }

    Keys.forwardTo: controller
    TwoAxisController {
        id: controller
        onInputActionPressed: {
            console.debug("gameScene key pressed actionName " + actionName)
            if(actionName == "up" && !player.big) {
                player.jump()
            }else if(actionName == "up" && player.big){
                player.bigtux_jump()
            }

            if((actionName == "left" || actionName == "right") && !player.big){
                player.walk()
            }else if((actionName == "left" || actionName == "right") && player.big){
                player.bigtux_walk()
            }
        }

        onInputActionReleased: {
            if(xAxis == 0 && yAxis == 0 && !player.big) {
                player.stand()
            }else if(xAxis == 0 && yAxis == 0 && player.big){
                player.bigtux_stand()
            }else if(yAxis == 0 && actionName == "up" && !player.big)
            {
                player.walk()
            }else if(yAxis == 0 && actionName == "up" && player.big){
                player.bigtux_walk()
            }
        }

        //change the player'orientation
        onXAxisChanged: player.changeSpriteOrientation()
    }

    /**
     * HUD
     */

    HUDIconAndText {
        id: timeDisplay

        // When the time is a whole number, the text would be e.g. "1" - but we
        // want it to be "1.0". So we check if it is a whole number, and if so,
        // add a ".0" to the end of it.
        text: time
        icon.source: "../../assets/images/engine/time.png"

    }

    // this timer keeps track of the time, the user plays a level
    Timer {
        id: levelTimer

        interval: 1000

        repeat: true

        onTriggered: {

            time -=1
            checkTime(time)
        }
    }

    // this displays the player's COIN
    HUDIconAndText {
        id: coinDisplay
        text: "X "+player.coin
        icon.source: "../../assets/images/engine/coin-0.png"

        anchors.left: timeDisplay.right
    }


    // initializes the level
    // this function is called after a level was loaded
    function initLevel() {

        console.debug("initLevel")

        //init level
        levelLoader.active = false
        levelLoader.active = true
        // init the camera
        camera.zoom = 1
        camera.freePosition = Qt.point(0, 0)

        // initialize the player
        player.x=20
        player.y=100
        bgImg.resetBackgrounds(0,0)
        // init the player's contacts and coin
        player.resetContacts()
        player.coin=0

        // init the controller's xAxis to ensure, that it's zero
        // at the beginning of the level
        controller.xAxis = 0

        // init time and timer
        time = 300
        levelTimer.restart(0,0)
        levelTimer.repeat = true

    }

    // reset the level when player die
    function resetLevel(){

        console.debug("resetLevel")

        //reload current level
        levelLoader.active = false
        levelLoader.active = true

        // reset the camera
        camera.zoom = 1
        camera.freePosition = Qt.point(0, 0)

        // reset the player
        player.x=20
        player.y=100
        audioManager.stopSound("finish")
        bgImg.resetBackgrounds(0,0)
        // reset the player
        player.big = false
        player.tux.currentSprite = "stand"
        player.coin = 0
        player.contacts = 0

        // reset the controller's xAxis to ensure, that it's zero
        // at the beginning of the level
        controller.xAxis = 0

        // reset time and timer
        time = 300
        levelTimer.restart(0,0)
        levelTimer.repeat = true
    }

    //check the time,if time out,player die.
    function checkTime(time){
        if(time===0){
            player.die(true)
        }
    }
}


