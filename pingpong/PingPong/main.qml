import QtQuick 2.9
import QtQuick.Window 2.2

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
                    ball.velocityX = -ball.speed
                }
                else {
                    console.log("HIT")
                }
            }
            else {
                console.log("hit")
            }
        }
    }

}
