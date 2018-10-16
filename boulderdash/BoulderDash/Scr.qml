import QtQuick 2.0

Item {
    id: inner
    property int wid: 40
    property int hei: 40

    property variant field: []
    property string field_source: ""

    function get(x,y) {
        return field_source[x+y*wid]
    }

    function load(w,h,source) {
        var i,j
        var cell

        wid = w
        hei = h
        field_source = source
        cell = Qt.createComponent("Cell.qml");

        // create field
        field = new Array(w)
        for(i=0;i<w;i++) {
            field[i] = new Array(h)
        }
        // fill field as empty
        for(i=0;i<w;i++)
            for(j=0;j<h;j++) {
                field[i][j] = cell.createObject(inner, {"x": i*main.spriteSize, "y": j*main.spriteSize, "c": get(i,j)});
            }
    }
}
