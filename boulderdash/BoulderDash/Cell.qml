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
    }

    onCChanged: {
        if(c === "C") { loadimage("sprites/wall_white.png",1) }
        if(c === ".") { loadimage("sprites/wall_moving_1.png",8) }

    }

    function loadimage(file, frames) {

        sprite.source = file

        sprite.frameCount = frames
        if(frames === 1) {
            sprite.running = false
        }


    }
}
