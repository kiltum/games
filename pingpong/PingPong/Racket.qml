import QtQuick 2.0

Item {
    id: racket
    property int speed: 30
    property int size: 100

    property int limitY: parent.height

    Rectangle {
        width: 10
        height: parent.size
        color: "green"
    }
    focus: true
    Keys.onUpPressed: {
        if(racket.y > 0) {
            racket.y = racket.y - speed
        }
        if(racket.y < 0) {
            racket.y = 0
        }
    }
    Keys.onDownPressed: {
        if(racket.y < (limitY - size) ) {
            racket.y = racket.y + speed
        }
    }
}
