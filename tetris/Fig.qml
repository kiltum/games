import QtQuick 2.0

Item {
    function get() {
        var stick = '.#..' +
                    '.#..' +
                    '.#..' +
                    '.#..';

        var rect =  '....' +
                    '.##.' +
                    '.##.' +
                    '....';

        var tri =   '....' +
                    '###.' +
                    '.#..' +
                    '....';

        var rel =   '.##.' +
                    '.#..' +
                    '.#..' +
                    '....';

        var el =    '.##.' +
                    '..#.' +
                    '..#.' +
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
        s=4;//Math.random()*7
        if(s<1) return stick;
        if(s<2) return rect;
        if(s<3) return tri;
        if(s<4) return rel;
        if(s<5) return el;
        if(s<6) return skew;
        if(s<7) return rskew;
    }

    function rotate(f, deg) {
        var r,s, fr
        var x,y,d

        console.log("come",f,deg)
        r = new Array(16)
        fr = new Array(16)

        for(x=0;x<16;x++) {
            r[x]=f[x]
            fr[x] = f[x]
        }

        d = deg
        while(d>0)
        {
            for(x=0;x<4;x++)
                for(y=0;y<4;y++)
                {
                    r[x+y*4] = fr[(3-x)*4+y]
                }
            d = d -90
            for(x=0;x<16;x++) {
                fr[x]=r[x]
            }
        }
        s = ''
        for(x=0;x<16;x++) {
            s = s + r[x].toString()
        }

        return s
    }
}
