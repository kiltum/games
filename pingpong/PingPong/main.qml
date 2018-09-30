import QtQuick 2.9
import QtQuick.Window 2.2

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")

    property int ballX: 100
    property int ballY: 100
    property int racketY: 30
    property int racketSize: 100

    Rectangle {
        x: 50
        y: 50
        width: 500
        height: 400
        color: "blue"

        Ball {
            x: 50
            y: 100
            onMoved: {
//                console.log(x)
            }
        }

        Racket {
            x: parent.width-20
            y: racketY
            size: racketSize
            onMoved: {
                console.log(y)
            }
        }
    }

}
