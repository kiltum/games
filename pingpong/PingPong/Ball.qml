import QtQuick 2.0

Item {
    property bool run: true
    property int speed: 10
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
            }

            if (parent.x < 0 + ball.width) {
                velocityX = speed
            }

            if (parent.y > limitY - ball.height) {
                velocityY = -speed
            }

            if (parent.y < 0 + ball.height) {
                velocityY = speed
            }
        }
    }
}

