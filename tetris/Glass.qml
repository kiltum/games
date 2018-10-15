import QtQuick 2.0

Item {
    property int w: 3
    property int h: 5

    property int step: 20

    property variant field: []

    function initField() {
        var i,j
        var cell

        cell = Qt.createComponent("Cell.qml");

        if(cell.status !== Component.Ready) {
            console.log("Something wrong with Cell.qml")
        }

        // create field
        field = new Array(h)
        for(i=0;i<h;i++) {
            field[i] = new Array(w)
        }
        // fill field as empty
        for(i=0;i<h;i++)
            for(j=0;j<w;j++) {
                field[i][j] = cell.createObject(inner, {"x": 200+j*step, "y": i*step});
                field[i][j].c = '#'
                field[i][j].update()
            }
    }

    function updateField() {
        var i,j
        for(i=0;i<h;i++)
            for(j=0;j<w;j++) {
                if(field[i][j] !== '.') {

                } else { // empty field

                }

            }
    }

    Rectangle {
        id: outer
        x: step
        y: step
        width: (w+2)*step
        height: (h+1)*step
        color: "blue"
        Rectangle {
            id: inner
            x: step
            y:0
            width: w*step
            height: h*step
            color: "green"
        }
    }
    Component.onCompleted: {
        initField()
    }
}
