import QtQuick 2.0
import Felgo 3.0

TiledEntityBase{
    id:jumper
    entityType: "jumper"

    //the jumper direction
    property int verticalJumpForce: 510
    property int horizontalJumpForce:0


    width: opponentjumper.width
    height: opponentjumper.height

    TexturePackerSpriteSequence{
        id:opponentjumper

        TexturePackerSprite{
            name:"opponent_jump"
            source: "../../assets/tux_entity_sprites/-hdtux_sprites.json"
            frameNames: ["creatures/snowjumpy/left-down.png","creatures/snowjumpy/left-middle.png","creatures/snowjumpy/left-up.png"]
            frameRate: 2.7
        }
        currentSprite: "opponent_jump"
    }

    BoxCollider{
        id:jumpcollider
        height: parent.height
        width: 30
        anchors.horizontalCenter: parent.horizontalCenter

        // the bodyType is dynamic
        bodyType: Body.Dynamic

        // Category9: jump body
        categories: Box.Category9
        //category1:player,category3:solid,categoriy10:player feet sensor
        collidesWith: Box.Category1 | Box.Category3 | Box.Category10

    }

    BoxCollider{
        id:bottomSensor

        width: 30
        height: 3

        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.bottom

        // the bodyType is dynamic
        bodyType: Body.Dynamic

        // Category8: jump sensor
        categories: Box.Category8
        // Category3: solids
        collidesWith: Box.Category3

        // this collider is for collision testing only
        collisionTestingOnlyMode: true

        // this is called whenever the contact with another entity begins
        fixture.onContactChanged: {
          var otherEntity = other.getBody().target

          // When the opponent stands on a solid object, we want it
          // to wait a little and then jump again.
          // Since we set the collidesWith property, we can be sure
          // that it won't collide with any unwanted entities.
          if(jumpcollider.linearVelocity.y === 0 && !jumpTimer.running)
            jumpTimer.start()
        }
    }

    Timer{
        id:jumpTimer

        interval: 200

        onTriggered: {
            jumpcollider.applyLinearImpulse(Qt.point(horizontalJumpForce,-verticalJumpForce))
        }
    }
    function reset_super()
    {

      // reset velocity
      jumpcollider.linearVelocity.x = 0
      jumpcollider.linearVelocity.y = 0

      // reset force
      jumpcollider.force = Qt.point(0, 0)
    }
    function reset() {

      // this is the reset function of the base entity Opponent.qml
      reset_super()

      // reset timer
      if(jumpTimer.running)
        jumpTimer.stop()
    }
}
