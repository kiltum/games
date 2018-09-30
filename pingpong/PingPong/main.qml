import QtQuick 2.9
import QtQuick.Window 2.2

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")

    Rectangle {
        x: 50
        y: 50
        width: 400
        height: 400
        color: "blue"

        Ball {
            x: 300
            y: 200
        }
    }

}
