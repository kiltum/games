import QtQuick 2.11
import QtQuick.Window 2.11
import QtMultimedia 5.8

Window {
    id: main
    visible: true
    width: 800
    height: 480
    title: qsTr("Boulder Dash")
    color: "black"

    property int spriteSize: 40
    property real spriteScale: 0.5


//    Cell {
//        c: "."
//    }

    Scr {
        id: first

    }

    Audio {
        source: "sound/initial_music.mp3"
        loops: Audio.Infinite
        autoPlay: true
    }

    Component.onCompleted: {
        //first.load(4,4,"CCCCC..CC..CCCCC")
        first.load(40,17,"CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC......................................CC.HCCCI................................CC.HC..H.HCCC.HC.H.HC...HCCI.HCCC.HCCI..CC.HCCCJ.HC.H.HC.H.HC...HC.H.HC...HC.H..CC.HCCCI.HC.H.HC.H.HC...HC.H.HCC..HCCJ..CC.HC..H.HC.H.HC.H.HC...HC.H.HC...HCCI..CC.HCCCJ.HCCC.HCCC.HCCC.HCCJ.HCCC.HC.H..CC......................................CC......HCCCI...........................CC......HC..H..HCI.HCCC.HC..H...........CC......HC..H.HC.H.HC...HC..H...........CC......HC..H.HCCC.HCCC.HCCCC...........CC......HC..H.HC.H...HC.HC..H...........CC......HCCCJ.HC.H.HCCC.HC..H...........CC......................................CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC")
        console.log(Screen.pixelDensity)
    }
}
