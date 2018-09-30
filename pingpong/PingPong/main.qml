import QtQuick 2.9
import QtQuick.Window 2.2
import QtMultimedia 5.8

Window {
    id: main
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")

    property int ballX: 100
    property int ballY: 100
    property int ballSize: 10
    property int racketY: 30
    property int racketX: pole.width - 30
    property int racketSize: 150

    property bool mute: false

    Rectangle {
        id: pole
        x: 50
        y: 50
        width: 500
        height: 400
        color: "blue"

        Ball {
            id: ball
            x: ballX
            y: ballY
            size: ballSize
            onMoved: {
                ballX = x
                ballY = y
                checkCollide()
            }
            mute: main.mute
        }

        Racket {
            x: racketX
            y: racketY
            size: racketSize
            onMoved: {
                racketY = y
                racketSize = size
                checkCollide()
            }
        }
    }

    function checkCollide() {
        if((ballX + ballSize) >= racketX) { // no need to check if ball far left from racket
            if((ballY + ballSize) >= racketY) { // ball below top corner of rocket
                if((ballY + ballSize) <= racketY+racketSize) {
                    console.log("rocket")
                    if (!main.mute) {
                        rocketHit.play()
                    }
                    ball.velocityX = -ball.speed
                }
                else {
                    fail()
                }
            }
            else {
                fail()
            }
        }
    }

    function fail() {
        ball.run=false
        failHit.play()

    }

    // sound from https://freesound.org/people/ProjectsU012/sounds/340982/
    SoundEffect {
        id: rocketHit
        source: "rocket.wav"
    }

    // https://freesound.org/people/OwlStorm/sounds/404743/

    SoundEffect {
        id: failHit
        source: "fail.wav"
    }

}
