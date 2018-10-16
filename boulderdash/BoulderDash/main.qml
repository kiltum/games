import QtQuick 2.11
import QtQuick.Window 2.11

Window {
    id: main
    visible: true
    width: 640
    height: 480
    title: qsTr("Boulder Dash")
    color: "black"

    property int spriteSize: 40


//    Cell {
//        c: "."
//    }

    Scr {
        id: first

    }
    Component.onCompleted: {
        first.load(4,4,"CCCCC..CC..CCCCC")
    }
}
