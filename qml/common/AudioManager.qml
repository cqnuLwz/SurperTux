/*
 *author:zhangjianming
 *
 *Function:add BackgroundMusic and Sounds
**/
import Felgo 3.0
import QtQuick 2.0
import QtMultimedia 5.0

Item {
    id: audioManager

    Component.onCompleted: handleMusic()

    /**
     * Background Music ----------------------------------
     */
    BackgroundMusic {
      id: menuMusic

      autoPlay:true

      source: "../../assets/audio/music/christmas_theme.ogg"
    }

    BackgroundMusic {
      id: playMusic

      autoPlay: false

      source: "../../assets/sounds/backgroundMusic1.mp3"
    }

    BackgroundMusic{
      id:selectMusic

      autoPlay: false

      source:  "../../assets/audio/music/salcon.ogg"
    }

    BackgroundMusic{
      id:playMusic2

      autoPlay: false

      source: "../../assets/sounds/backgroundMusic2.mp3"
    }

    BackgroundMusic {
      id: editMusic

      autoPlay: false

      source: "../../assets/audio/music/tropicalbreeze.ogg"
    }

    /**
     * Sounds ----------------------------------
     */
    SoundEffect {
      id: playerJump
      source: "../../assets/sounds/jump.wav"
    }
    SoundEffect{
        id:bigJump
        source:"../../assets/sounds/bigjump.wav"
    }

    SoundEffect {
      id: playerHit
      source: "../../assets/sounds/hurt.wav"
    }

    SoundEffect{
        id:brick
        source: "../../assets/sounds/brick.wav"
    }

    SoundEffect{
        id:iceBrick
        source: "../../assets/sounds/coin2.wav"
    }

    SoundEffect {
      id: playerDie
      source: "../../assets/sounds/playDie.wav"
    }

    SoundEffect {
      id: playerInvincible
      source: "../../assets/sounds/invincible_start.wav"
      loops: SoundEffect.Infinite
    }

    SoundEffect {
      id: collectCoin
      source: "../../assets/sounds/coin.wav"
    }

    SoundEffect {
      id: collectMushroom
      source: "../../assets/sounds/grow.wav"
    }

    SoundEffect{
        id:collectFireFlower
        source:"../../assets/sounds/fire-flower.wav"
    }

    SoundEffect {
      id: finish
      source: "../../assets/sounds/finish.wav"
    }

    SoundEffect{
        id:opponentJump
        source: "../../assets/sounds/flip.wav"
    }

    SoundEffect {
      id: opponentWalkerDie
      source: "../../assets/sounds/kill.wav"
    }

    SoundEffect {
      id: opponentJumperDie
      source: "../../assets/sounds/kill.wav"
    }
    SoundEffect{
        id:playerGrow
        source:"../../assets/sounds/grow.wav"
    }

    function handleMusic() {
      if(activeScene === gameScene) {
          audioManager.startMusic(playMusic)
     }else if(activeScene===selectLevelScene){
          audioManager.startMusic(selectMusic)
      }else{
          audioManager.startMusic(menuMusic)
      }
    }


    function startMusic(music) {
      // if music is already playing, we don't have to do anything
      if(music.playing)
        return

      // otherwise stop all music tracks
      menuMusic.stop()
      playMusic.stop()
     selectMusic.stop()
      editMusic.stop()
      // play the music
      music.play()
    }

    // play the sound effect with the given name
    function playSound(sound) {
      if(sound === "playerJump")
        playerJump.play()
      else if(sound==="bigJump")
          bigJump.play()
        else if(sound === "playerHit")
        playerHit.play()
      else if(sound === "playerDie")
        playerDie.play()
      else if(sound === "brick")
          brick.play()
      else if(sound === "iceBrick")
          iceBrick.play()
      else if(sound === "playerInvincible")
        playerInvincible.play()
      else if(sound === "collectCoin")
        collectCoin.play()
        else if(sound === "collectMushroom")
        collectMushroom.play()
      else if(sound === "finish")
        finish.play()
      else if(sound === "opponentWalkerDie")
        opponentWalkerDie.play()
      else if(sound === "opponentJumperDie")
        opponentJumperDie.play()
      else if(sound === "playerGrow")
        playerGrow.play()
      else
        console.debug("unknown sound name:", sound)
    }

    // stop the sound effect with the given name
    function stopSound(sound) {
      if(sound === "finish")
        finish.stop()
      else if(sound === "playerJump")
          playerJump.stop()
      else if(sound === "bigJump")
          bigJump.stop()
        console.debug("unknown sound name:", sound)
    }


}
