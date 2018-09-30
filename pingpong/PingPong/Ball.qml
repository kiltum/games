import QtQuick 2.0
import QtMultimedia 5.8

Item {
    id: mainBall
    property bool run: true
    property int speed: 15
    property bool mute: true
    property int velocityX: speed
    property int velocityY: speed

    property int limitX: parent.width
    property int limitY: parent.height

    Rectangle {
        id: ball
        x: -5
        y: -5
        height: 10
        width: 10
        color: "red"
        radius: width * 0.5
    }

    Timer {
        running: parent.run
        interval: 50
        repeat: true
        onTriggered: {
            parent.x = parent.x + velocityX
            parent.y = parent.y + velocityY
            if (parent.x > limitX - ball.width) {
                velocityX = -speed
                hit()
            }

            if (parent.x < 0 + ball.width) {
                velocityX = speed
                hit()
            }

            if (parent.y > limitY - ball.height) {
                velocityY = -speed
                hit()
            }

            if (parent.y < 0 + ball.height) {
                velocityY = speed
                hit()
            }

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

