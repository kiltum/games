import QtQuick 2.9
import QtQuick.Window 2.2
import QtMultimedia 5.8

Window {
    id: main
    visible: true
    width: 640
    height: 480
    title: qsTr("Ping Pong")

    property int ballX: main.width/2
    property int ballY: main.height/2
    property int ballSize: 30
    property int ballSpeed: 10
    property int racketY: 30
    property int racketX: pole.width - 30
    property int racketSize: 150

    property bool mute: false

    property int border: 10
    property int score: 0

    Rectangle {
        id: pole
        x: main.border
        y: main.border
        width: main.width-main.border*2
        height: main.height-main.border*2
        color: "blue"

        Ball {
            id: ball
            x: ballX
            y: ballY
            size: ballSize
            speed: ballSpeed
            onMoved: {
                ballX = x
                ballY = y
                checkCollide()
            }
            mute: main.mute
            run: false
        }

        Racket {
            id: racket
            x: racketX
            y: racketY
            size: racketSize
            canMove: false
            onMoved: {
                racketY = y
                racketSize = size
                checkCollide()
            }
        }
    }

    function checkCollide() {
        if((ballX + ball.size/2) >= racketX) { // no need to check if ball far left from racket
            if((ballY + ball.size/2) >= racketY) { // ball below top corner of rocket
                if((ballY + ball.size/2) <= racketY+racket.size) {
                    if (!main.mute) {
                        rocketHit.play()
                    }
                    ball.x = racketX - ball.size/2
                    main.score = main.score + 1
                    ball.velocityX = -ball.speed
                    if(ball.size > 10) {
                        ball.size=ball.size-1
                        ball.speed=ball.speed+1
                    }
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
        racket.canMove=false
        if(!main.mute) {
            failHit.play()
        }
        failedTimer.running=true;

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

    Text {
        x: main.border*2
        y: main.border*2
        text: main.score
        font.family: "Helvetica"
        font.pointSize: 48
        font.bold: true
        color: "red"
    }

    // https://freesound.org/people/steel2008/sounds/231277/

    SoundEffect {
        id: readySetGo
        source: "start.wav"
        onPlayingChanged: {
            if(!playing) {
                ball.run=true
                racket.canMove=true
                main.score=0
                ball.x=main.width/2
                ball.x=main.height/2
                ball.speed=ballSpeed
                ball.size=ballSize
            }
        }
    }

    Timer {
        id: failedTimer
        interval: 100
        onTriggered: {
            readySetGo.play()
        }
    }

    Component.onCompleted: {
        readySetGo.play()
    }
}
