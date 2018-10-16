import QtQuick 2.0

Item {

    AnimatedSprite {
        source: "sprites/wall_moving_1.png"
        frameWidth: 40
        frameHeight: 40
        frameCount: 8
        frameDuration: 100
        interpolate: false
    }
}
