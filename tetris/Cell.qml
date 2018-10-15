import QtQuick 2.0

Item {
    property string c: '.'
    property int size: 20

    function getColor() {
        if(c === '.') return "green"
        if(c === '#') return "blue"
    }

    function update() {
        cll.color = getColor()
    }

    Rectangle {
        id: cll
        x: 0
        y: 0
        height: size
        width: size
        color: getColor()
    }

}
