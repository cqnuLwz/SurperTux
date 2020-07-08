import Felgo 3.0
import QtQuick 2.0

EntityBase {

    //for dirction
    property int column: 0
    property int row: 0

    //for width and height
    property int widthSize : 1
    property int heightSize: 1

    // instead of directly modifying the x and y values of your tiles, we introduced rows and columns for easier positioning, have a look at Level1.qml on how they are used
    x: row*gameScene.gridSize
    y: gameScene.height - (column+1)*gameScene.gridSize
    width: gameScene.gridSize * widthSize
    height: gameScene.gridSize * heightSize
}

