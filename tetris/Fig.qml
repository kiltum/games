import QtQuick 2.0

Item {
    function get() {
    var stick = '#...' +
                '#...' +
                '#...' +
                '#...';

    var rect =  '##..' +
                '##..' +
                '....' +
                '....';

    var tri =   '###.' +
                '.#..' +
                '....' +
                '....';

    var rel =   '##..' +
                '#...' +
                '#...' +
                '....';

    var el =    '##..' +
                '.#..' +
                '.#..' +
                '....';

    var skew =  '.#..' +
                '.##.' +
                '..#.' +
                '....';

    var rskew = '..#.' +
                '.##.' +
                '.#..' +
                '....';


        var s
        s=Math.random()*7
        if(s<1) return stick;
        if(s<2) return rect;
        if(s<3) return tri;
        if(s<4) return rel;
        if(s<5) return el;
        if(s<6) return skew;
        if(s<7) return rskew;
    }
}
