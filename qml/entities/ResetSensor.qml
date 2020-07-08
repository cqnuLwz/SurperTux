import Felgo 3.0
import QtQuick 2.0

EntityBase {
  id: resetSensor
  entityType: "resetSensor"

  signal contact

  BoxCollider {
    anchors.fill: parent
    collisionTestingOnlyMode: true
    // Category4: ResetSensor
    categories: Box.Category4
    // Category1: player
    collidesWith: Box.Category1
    fixture.onBeginContact: {
      // if the player hits the sensor, we emit a signal which will be used to reset the player

        // we could also directly modify the player position here, but the signal approach is a bit cleaner and helps separating the components
       resetSensor.contact()
       console.debug("resetSensor")
    }
  }
}

