import QtQuick 2.0
import QtQuick.Window 2.0
import QtGraphicalEffects 1.0
import QtQuick.Controls 2.12
import Myweather 1.0
import QtMultimedia 5.15

Window {
    id:root
    visible: true
    width: 1024
    height: 600
    title: qsTr("Hello World")
    Image {
        id: bg
        source: "qrc:/assets/Background.png"
        anchors.fill: parent
    }

//    MediaPlayer {
//         id: player
//         source: "/assets/bg_video.mp4"
//         autoPlay: true
//         loops: Animation.Infinite
//     }

//    VideoOutput {
//        id: myvideo
//        //height: width
//        source: player
//        opacity: 0.7 // Set the opacity as you wish
//        anchors.fill: parent
//     }

    Video {
            id: videoPlayer
            width: parent.width
            height: parent.height
            source: "/assets/bg_video.mp4"
            autoPlay: true
    }

//    LinearGradient {
//            anchors.fill: parent
//            start: Qt.point(parent.width/2, 0)
//            end: Qt.point(parent.width/2,parent.height)
//            gradient: Gradient {
//                GradientStop { position: 0.0; color: "#01155C" }
//                GradientStop { position: 1.0; color: "#2F4CAF" }
//            }
//        }

    Weather {
        id : weathercontroller
    }

    StackView {
            id: stackView
            objectName: "stack"
            anchors.fill: parent
            initialItem: "qrc:/pages/Dashboard.qml"

            onCurrentItemChanged: animation.running = true

            NumberAnimation {
                        id: animation
                        target: stackView.currentItem
                        property: "opacity"
                        from: 0
                        to: 1
                        duration: 1000
                        easing.type: Easing.InExpo
                    }

            pushEnter: Transition {
                    PropertyAnimation {
                        property: "opacity"
                        from: 0
                        to:1
                        duration: 500
                    }
                }
                pushExit: Transition {
                    PropertyAnimation {
                        property: "opacity"
                        from: 1
                        to:0
                        duration: 500
                    }
                }
        }



}


