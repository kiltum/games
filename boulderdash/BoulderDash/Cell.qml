import QtQuick 2.0

Item {

    property string path: ""
    property string c:""

    AnimatedSprite {
        id: sprite
        source: path
        frameWidth: main.spriteSize
        frameHeight: main.spriteSize
        frameCount: 1
        frameDuration: 100
        interpolate: false
        transform: Scale {xScale: main.spriteScale; yScale: main.spriteScale}
    }

    onCChanged: {
        if(c === "C") { loadimage("sprites/wall_white.png",1) }
        if(c === ".") { loadimage("sprites/wall_moving_blue.png",8) }
        if(c === "H") { loadimage("sprites/wall_gradient.png",1) }
        if(c === "I") { loadimage("sprites/wall_white_top.png",1) }
        if(c === "J") { loadimage("sprites/wall_white_bottom.png",1) }

    }

    function loadimage(file, frames) {

        sprite.source = file

        sprite.frameCount = frames
        if(frames === 1) {
            sprite.running = false
        }


    }
}
