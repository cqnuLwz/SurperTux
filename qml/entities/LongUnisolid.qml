import QtQuick 2.0
import Felgo 3.0

TiledEntityBase {
    id: longUnisolid
    entityType: "background"

    z: -1

    Row{
        id:longUnisolidRow
        Repeater {
            model: size
            Tile {
                sprite.source: "../../assets/background/unisolid.png"
            }
        }
    }
}
