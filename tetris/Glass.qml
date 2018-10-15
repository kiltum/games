import QtQuick 2.0

Item {
    id: glass
    property int w: 10
    property int h: 20

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
                field[i][j] = cell.createObject(inner, {"x": j*step, "y": i*step});
            }
    }

    function clearField() {
        var i,j
        for(i=0;i<h;i++)
            for(j=0;j<w;j++) {
               field[i][j].c = '.'
            }
    }

    function updateField() {
        var i,j
        for(i=0;i<h;i++)
            for(j=0;j<w;j++) {
               field[i][j].update()
            }
    }

    Fig {
        id: fig
    }


    function putFig(x,y) {
        var i,j, f
        f = fig.get()
        for(i=0;i<4;i++)
            for(j=0;j<4;j++) {
               field[i+y][j+x].c = f[i+j*4]
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

    Timer {
        id: tim
        repeat: true
        onTriggered: {
            clearField()
            putFig(2,2)
            updateField()
        }
    }

    Component.onCompleted: {
        initField()
        clearField()
        updateField()
        tim.running = true
    }
}
