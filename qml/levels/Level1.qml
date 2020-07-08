import QtQuick 2.13
import Felgo 3.0
import "../common"
import "../entities"
import "../scenes"

LevelBase {
    levelName: "Level1"

    Grass2{
        row:4
        column:1
        widthSize: 1
        heightSize: 1
    }

    //row: 15 - 20 | Brick * 3 + QuestionMark * 3
    Brick{
        row:15
        column:5
        widthSize: 1
        heightSize: 1
    }
    QuestionMark{
        row:16
        column:5
        widthSize: 1
        heightSize: 1
    }
    Brick{
        row:17
        column:5
        widthSize: 1
        heightSize: 1
    }
    QuestionMark{
        row:18
        column:5
        widthSize: 1
        heightSize: 1
    }
    Brick{
        row:19
        column:5
        widthSize: 1
        heightSize: 1
    }
    QuestionMark{
        row:20
        column:5
        widthSize: 1
        heightSize: 1
    }


    Cloud{
        row:25
        column:18
    }
    //row: 22
    OpponentWalk{
        row:22
        column: 1
    }

    SnowMountain{
        row:25
        column:1
        widthSize: 1
        heightSize: 1
    }

    SnowSquareBackGround{
        row:28
        column:2
        widthSize: 1
        heightSize: 1
    }

    //row: 36 - 41 | Brick * 3 + QuestionMark * 3 + PowerUpEgg * 1 + coin * 3
    Coin{
        row:37
        column: 8
    }
    Coin{
        row:38
        column: 8
    }
    Coin{
        row:39
        column: 8
    }
    Coin{
        row:40
        column: 8
    }

    Brick{
        row:36
        column:5
        widthSize: 1
        heightSize: 1
    }
    QuestionMark{
        row:37
        column:5
        widthSize: 1
        heightSize: 1
    }
    Brick{
        row:38
        column:5
        widthSize: 1
        heightSize: 1
    }
    QuestionMark{
        row:39
        column:5
        widthSize: 1
        heightSize: 1
    }
    PowerUpEgg{
        row:39
        column:5
        widthSize: 1
        heightSize: 1
    }
    Brick{
        row:40
        column:5
        widthSize: 1
        heightSize: 1
    }
    QuestionMark{
        row:41
        column:5
        widthSize: 1
        heightSize: 1
    }

    //row: 34
    OpponentWalk{
        row:34
        column: 1
    }

    //row: 0-53
    Ground{
        row:0
        column:1
        widthSize: 250
        heightSize: 2
    }
    SnowTile{
        row:0
        column: 1
        widthSize: 53
        heightSize: 1
    }

    //row: 53-55
    Ground{
        row:53
        column: 3
        widthSize: 3
        heightSize: 2
    }
    SnowTile{
        row:53
        column: 3
        widthSize: 3
        heightSize: 1
    }
    SideGround{
        row:53
        column: 3
        widthSize: 1
        heightSize: 2
    }
    SideGround{
        row:56
        column: 3
        heightSize: 2
    }

    Coin{
        row:53
        column: 4
    }
    Coin{
        row:54
        column: 4
    }
    Coin{
        row:55
        column: 4
    }

    Cloud{
        row:53
        column:17
    }


    //row: 56-65
    SnowTile{
        row: 56
        column: 1
        widthSize: 10
        heightSize: 1
    }

    //a walk op at row 58
    OpponentWalk{
        row:58
        column: 1
    }
    SnowMountain{
        row:64
        column:1
        widthSize: 1
        heightSize: 1
    }

    //row: 66-68
    Ground{
        row:66
        column: 5
        widthSize: 3
        heightSize: 4
    }
    SnowTile{
        row:66
        column: 5
        widthSize: 3
        heightSize: 1
    }
    SideGround{
        row:66
        column: 5
        heightSize: 4
    }
    SideGround{
        row:69
        column: 5
        heightSize: 4
    }

    Coin{
        row:66
        column: 6
    }
    Coin{
        row:67
        column: 6
    }
    Coin{
        row:68
        column: 6
    }

    //row: 69-83
    SnowTile{
        row:69
        column: 1
        widthSize: 15
        heightSize: 1
    }

    //two walk op at row 70 / 75
    OpponentWalk{
        row:70
        column: 1
    }
    OpponentWalk{
        row:75
        column: 1
    }

    SnowMountain{
        row:82
        column: 1
    }
    Grass1{
        row:83
        column: 1
    }

    //row: 84-86
    Ground{
        row:84
        column: 2
        widthSize: 3
        heightSize: 1
    }
    SnowTile{
        row:84
        column: 2
        widthSize: 3
        heightSize: 1
    }

    //row: 88-94
    Cloud{
        row:88
        column:17
    }
    Spike{
        row:87
        column: 2
        widthSize: 8
    }
    PlatformUnisolid{
        row:88
        column: 4
        widthSize: 3
    }
    PlatformUnisolid{
        row:91
        column: 6
        widthSize: 3
    }
    Grass2{
        row:105
        column: 1
    }
    Coin{
        row:96
        column: 8
    }
    Coin{
        row:97
        column: 8
    }
    Coin{
        row:98
        column: 8
    }
    Coin{
        row:99
        column: 8
    }
    Coin{
        row:100
        column: 8
    }
    Coin{
        row:101
        column: 8
    }
    Coin{
        row:102
        column: 8
    }
    Coin{
        row:103
        column: 8
    }
    OpponentJump{
        row:105
        column: 1
    }

    // coin * 8
    // platform * 3
    // spike * 7

    //row: 95-107
    SnowTile{
        row:95
        column: 1
        widthSize: 13
        heightSize: 1
    }

    //row: 108-127  column: 5
    Ground{
        row:108
        column: 5
        widthSize: 20
        heightSize: 1
    }
    SnowTile{
        row:108
        column: 5
        widthSize: 20
        heightSize: 1
    }
    SideGround{
        row:108
        column: 5
        heightSize: 4
    }

    //row: 108-128  column: 4
    Ground{
        row:108
        column: 4
        widthSize: 21
        heightSize: 1
    }
    SnowTile{
        row:128
        column: 4
        widthSize: 1
        heightSize: 1
    }
    //row: 108-129  column: 3
    Ground{
        row:108
        column: 3
        widthSize: 22
        heightSize: 1
    }
    SnowTile{
        row:129
        column: 3
        widthSize: 1
        heightSize: 1
    }
    //row: 108-130  column: 2
    Ground{
        row:108
        column: 2
        widthSize: 23
        heightSize: 1
    }
    SnowTile{
        row:130
        column: 2
        widthSize: 1
        heightSize: 1
    }

    // brick and QuestionMark row:115  PowerUpFlower * 1 row:116
    Brick{
        row:115
        column: 9
    }
    QuestionMark{
        row:116
        column: 9
    }
    PowerUpFlower{
        row:116
        column: 10
    }
    Brick{
        row:117
        column: 9
    }
    QuestionMark{
        row:118
        column: 9
    }
    Brick{
        row:119
        column: 9
    }
    QuestionMark{
        row:120
        column: 9
    }
    Grass1{
        row:110
        column: 5
    }
    Grass1{
        row:125
        column: 5
    }
    Cloud{
        row:128
        column:18
    }

    //row: 128 column:7   coin * 9
    Coin{
        row:128
        column: 9
    }
    Coin{
        row:129
        column: 9
    }
    Coin{
        row:130
        column: 9
    }
    Coin{
        row:131
        column: 9
    }
    Coin{
        row:132
        column: 9
    }
    Coin{
        row:133
        column: 9
    }
    Coin{
        row:134
        column: 9
    }
    Coin{
        row:135
        column: 9
    }
    Coin{
        row:136
        column: 9
    }


    //row: 131-155
    SnowTile{
        row:131
        column: 1
        widthSize: 25
        heightSize: 1
    }

    //Brick and QuestionMark row:139 Column:5
    Brick{
        row:139
        column: 5
    }
    QuestionMark{
        row:140
        column: 5
    }
    Brick{
        row:141
        column: 5
    }
    QuestionMark{
        row:142
        column: 5
    }   Brick{
        row:143
        column: 5
    }
    Brick{
        row:140
        column: 9
    }
    QuestionMark{
        row:141
        column: 9
    }
    Brick{
        row:142
        column: 9
    }
    QuestionMark{
        row:141
        column: 13
    }

    // OpponentWalk * 2 row: 138 144
    OpponentWalk{
        row:138
        column: 1
    }
    OpponentWalk{
        row:144
        column: 1
    }

    //row: 156-160
    Ground{
        row: 156
        column: 4
        widthSize: 5
        heightSize: 3
    }
    SnowTile{
        row:156
        column: 4
        widthSize: 5
        heightSize: 1
    }
    SideGround{
        row:156
        column: 4
        heightSize: 3
    }
    SideGround{
        row:161
        column: 4
        heightSize: 3
    }

    Coin{
        row:156
        column: 6
    }
    Coin{
        row:157
        column: 6
    }
    Coin{
        row:158
        column: 6
    }
    Coin{
        row:159
        column: 6
    }
    Coin{
        row:160
        column: 6
    }

    // row:161 - 165
    // Spike * 5
    Spike{
        row:161
        column: 2
        widthSize: 5
    }
    Cloud{
        row:164
        column:15
    }

    //row: 166-173
    Ground{
        row: 166
        column: 4
        widthSize: 8
        heightSize: 3
    }
    SnowTile{
        row:166
        column: 4
        widthSize: 8
        heightSize: 1
    }
    SideGround{
        row:166
        column: 4
        heightSize: 3
    }
    SideGround{
        row:174
        column: 4
        heightSize: 3
    }

    Coin{
        row:168
        column:6
    }
    Coin{
        row:169
        column:6
    }
    Coin{
        row:170
        column:6
    }
    Coin{
        row:171
        column:6
    }
    Grass2{
        row:169
        column: 4
        widthSize: 2
    }

    // row:174 - 178
    // Spike * 5
    Spike{
        row:174
        column: 2
        widthSize: 5
    }

    //row: 179 - 183
    Ground{
        row: 179
        column: 4
        widthSize: 5
        heightSize: 3
    }
    SnowTile{
        row:179
        column: 4
        widthSize: 5
        heightSize: 1
    }
    SideGround{
        row:179
        column: 4
        heightSize: 3
    }
    SideGround{
        row:184
        column: 4
        heightSize: 3
    }

    //row: 184 - 198
    SnowTile{
        row:184
        column: 1
        widthSize: 15
        heightSize: 1
    }

    //OpponentWalk * 2 row:186
    OpponentWalk{
        row:186
        column: 1
    }
    OpponentWalk{
        row:194
        column: 1
    }
    Grass1{
        row:190
        column: 1
    }

    //row: 199 - 204
    // stone blocks * 5
    BigBlock{
        row:199
        column: 5
        heightSize: 2
    }
    Cloud{
        row:205
        column:19
    }
    SideGround{
        row:199
        column: 5
        heightSize: 4
    }
    SideGround{
        row:201
        column: 6
        heightSize: 3
    }

    SmallBolck{
        row:200
        column: 6
    }
    SmallBolck{
        row:201
        column: 3
        heightSize: 2
    }
    SmallBolck{
        row:202
        column: 2
    }
    SnowMountain{
        row:206
        column: 1
    }


    //row: 203-210
    SnowTile{
        row:203
        column: 1
        widthSize: 8
        heightSize: 1
    }

    //row: 211 - 220
    Ground{
        row:211
        column: 2
        widthSize: 10
        heightSize: 1
    }
    SnowTile{
        row:211
        column: 2
        widthSize: 2
        heightSize: 1
    }
    //row: 213 - 220
    Ground{
        row:213
        column: 4
        widthSize: 8
        heightSize: 2
    }
    SnowTile{
        row:213
        column: 4
        widthSize: 2
        heightSize: 1
    }
    SideGround{
        row:213
        column: 4
        heightSize: 2
    }

    //row: 215 - 220
    Ground{
        row:215
        column: 5
        widthSize: 6
        heightSize: 1
    }
    SnowTile{
        row:215
        column: 5
        widthSize: 6
        heightSize: 1
    }

    SideGround{
        row:221
        column: 5
        heightSize: 4
    }

    // OpponentJump
    OpponentJump{
        row:218
        column:7
    }

    //row: 221 - 250
    SnowTile{
        row:221
        column: 1
        widthSize: 29
        heightSize: 1
    }

    //Goal
    Goal{
        row:245
        column:11
    }

    Goal1{
        row:245
        column: 10
        heightSize: 9
    }
}
