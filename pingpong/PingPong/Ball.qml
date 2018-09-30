import QtQuick 2.0
import QtMultimedia 5.8

Item {
    id: mainBall
    property bool run: true
    property int speed: 10
    property bool mute: true
    property int velocityX: -speed
    property int velocityY: -speed

    property int size: 20

    property int limitX: parent.width
    property int limitY: parent.height

    signal moved(int x, int y)

    Rectangle {
        id: ball
        x: -parent.size/2
        y: -parent.size/2
        height: parent.size
        width: parent.size
        color: "red"
        radius: parent.size/2
    }

    Timer {
        running: parent.run
        interval: 50
        repeat: true
        onTriggered: {
            parent.x = parent.x + velocityX
            parent.y = parent.y + velocityY

            if (parent.x > limitX - mainBall.size/2) {
                velocityX = -speed
                hit()
            }

            if (parent.x < 0 + mainBall.size/2) {
                velocityX = speed
                hit()
            }

            if (parent.y > limitY - mainBall.size/2) {
                velocityY = -speed
                hit()
            }

            if (parent.y < 0 + mainBall.size/2) {
                velocityY = speed
                hit()
            }

            if (mainBall.y < mainBall.size/2) {
                mainBall.y = mainBall.size/2
            }

            if (mainBall.x < mainBall.size/2) {
                mainBall.x = mainBall.size/2
            }

            if (mainBall.x > limitX - mainBall.size/2) {
               mainBall.x = limitX - mainBall.size/2
            }

            if (mainBall.y > limitY - mainBall.size/2) {
               mainBall.y = limitY - mainBall.size/2
            }
            mainBall.moved(parent.x, parent.y)
        }
    }

    function hit() {
        if (mainBall.mute == false) {
            playBall.play();
        }
    }

    // sound from https://www.freesoundeffects.com/free-sounds/ping-pong-10108/
    // and then cutted in audacity
    SoundEffect {
        id: playBall
        source: "pong.wav"
    }
}

