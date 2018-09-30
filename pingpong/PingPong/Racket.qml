import QtQuick 2.0

Item {
    id: racket
    property int speed: 30
    property int size: 100

    property int limitY: parent.height

    signal moved(int y, int size)

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



        racket.moved(y, size)
    }
    Keys.onDownPressed: {
        if(racket.y < (limitY - size) ) {
            racket.y = racket.y + speed
        }
        if((racket.y + racket.size) > limitY) {
            racket.y = limitY - racket.size
        }

        racket.moved(y, size)
    }
}
