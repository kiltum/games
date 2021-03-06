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

    property int score: 0

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
        score = -1
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
                if(j+x<glass.w)
                if(temp === true) {
                    if((field[i+y][j+x].c !== '#') && (field[i+y][j+x].c !== '$'))
                        if(figure[i+j*4] === '#') {
                            field[i+y][j+x].c = '0'
                        } else {
                            field[i+y][j+x].c = '_'
                        }
                } else {

                    if((field[i+y][j+x].c !== '#') && (field[i+y][j+x].c !== '$'))
                        if(figure[i+j*4] === '#') {
                            field[i+y][j+x].c = '$'
                        }
                }
            }
    }



    function canPut(x,y,figure) { // can figure placed?
        var i,j

        for(i=0;i<4;i++)
            for(j=0;j<4;j++) {
                if(figure[i+j*4] === '#'){
                    if((field[i+y][j+x].c === '#') || (field[i+y][j+x].c === '$')) {
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
        score = score + 1
        scoretext.text = score.toString()
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
            finishtext.text = "FINISH"
        }

    }

    function collapseField() { // remove fully filled rows
        var i,j,q,g,z
        for(z=0;z<4;z++) // figure can shrink up to 4 rows
        for(i=h-1;i>0;i--) {
            g = 0
            for(j=1;j<w-1;j++) {
                if(field[i][j].c !== '$')
                {
                    g=1
                }
            }
            if(g===0) {
                console.log("need collapse on",i)
                for(q=i;q>0;q--)
                    for(j=1;j<w-1;j++) {
                        field[q][j].c = field[q-1][j].c
                    }
            }
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
            if(newx<glass.w-2)
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
            collapseField()
            newFigure()

        }
    }

    Text {
        id: scoretext
        x: inner.x+inner.width + 20
        text: "100"
        font.family: "Helvetica"
        font.pointSize: 48
        font.bold: true
    }

    Text {
        id: finishtext
        x: inner.x+inner.width + 20
        y: scoretext.y+scoretext.paintedHeight+20
        text: ""
        font.family: "Helvetica"
        font.pointSize: 48
        font.bold: true
        color: "red"
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
                collapseField()
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
