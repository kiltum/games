import QtQuick 2.9
import QtQuick.Window 2.2

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")

    Rectangle {
        x: 10
        y: 10
        width: 400
        height: 400
        color: "blue"
    }

    Ball {
        x: 200
        y: 200
    }
    onHeightChanged: {
        console.log(width)
        console.log(height)
        console.log(Screen.pixelDensity)
    }
}
