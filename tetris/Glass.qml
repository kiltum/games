import QtQuick 2.0

Item {
    id: glass
    property int w: 10
    property int h: 20

    property int step: 20

    property variant field: []

    property int figx: w/2 // current figure X coordinate
    property int figy: 0    // Y
    property int figdeg: 0  // rotate angle
    property string figcurrent: "" // current figure
    property string figorig: ""


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
        for(i=0;i<h;i++) {
            for(j=0;j<w;j++) {
                if(i===h-1) {
                  field[i][j].c = '#'
                } else {
                    field[i][j].c = '.'
                }


            }
            field[i][0].c = '#'
            field[i][w-1].c = '#'
        }

    }

    function clearTempField() {
        var i,j
        for(i=0;i<h;i++)
            for(j=0;j<w;j++) {
                if(field[i][j].c === '0')
                    field[i][j].c = '.'
                if(field[i][j].c === '_')
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


    function putFig(x,y, figure, temp) { // put figure to field
        var i,j
        for(i=0;i<4;i++)
            for(j=0;j<4;j++) {
                if(i+y<glass.h)
                if(temp === true) {

                    if(field[i+y][j+x].c !== '#')
                        if(figure[i+j*4] === '#') {
                            field[i+y][j+x].c = '0'
                        } else {
                            field[i+y][j+x].c = '_'
                        }
                } else {

                    if(field[i+y][j+x].c !== '#')
                        field[i+y][j+x].c = figure[i+j*4]
                }
            }
    }



    function canPut(x,y,figure) { // can figure placed?
        var i,j

        for(i=0;i<4;i++)
            for(j=0;j<4;j++) {
                if(figure[i+j*4] === '#'){
                    if(field[i+y][j+x].c === '#') {
                        return false;
                    }
                }
            }
        return true;
    }

    function updateFig() {
        var fi
        clearTempField()
        putFig(figx,figy,figcurrent, true)
        updateField()
        //console.log(figx,figy, figdeg)
    }

    function newFigure() {

        figcurrent = fig.get()
        figorig = figcurrent
        figx = w/2-2
        figy = 0
        figdeg = 0
        if(canPut(figx,figy,figcurrent)) {
            putFig(figx,figy,figcurrent, true)
            updateField()
        }
        else {
            console.log("No more space. Finish")
            tim.running = false
        }

    }


    Rectangle {
        id: inner
        x: step
        y:0
        width: w*step
        height: h*step
        color: "green"
        focus: true
        Keys.onUpPressed: { // rotate
            var newd, fi
            newd = figdeg + 90
            if(newd>270) {
                newd=0
            }
            fi = fig.rotate(figorig,newd)

            if(canPut(figx,figy,fi)) {
                figdeg = newd
                figcurrent = fi
            }

            updateFig()
        }
        Keys.onLeftPressed: {
            var newx
            newx = figx-1
            if(newx>=0)
                if(canPut(newx,figy,figcurrent)) {
                    figx = newx
                }
            updateFig()
        }
        Keys.onRightPressed: {
            var newx
            newx = figx+1
            if(newx<glass.w-3)
                if(canPut(newx,figy,figcurrent)) {
                    figx = newx
                }
            updateFig()
        }
        Keys.onSpacePressed: { // drop figure
            var newy
            newy = figy
            while(newy === figy) {
                newy = figy+1
                if(newy<glass.h-2) {
                    if(canPut(figx,newy,figcurrent)) {
                        figy = newy
                        clearTempField()
                        putFig(figx,figy,figcurrent, true)
                        updateField()
                    }
                }
            }

            putFig(figx,figy,figcurrent, false)
            newFigure()

        }
    }


    Timer {
        id: tim
        interval: 500
        repeat: true
        onTriggered: {
            var newy
            newy = figy+1
            if(newy<glass.h-2) {
                if(canPut(figx,newy,figcurrent)) {
                    figy = newy
                }
            }
            if(newy !== figy) {
                console.log("BOOM. new figure")
                putFig(figx,figy,figcurrent, false)
                newFigure()
            }

            updateFig()
        }

    }

    Component.onCompleted: {
        initField()
        clearField()

        newFigure()


//        field[5][5].c = '#'
//        updateField()
        tim.running = true
    }
}
