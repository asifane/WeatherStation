import QtQuick 2.0
import QtLocation 5.12
import QtPositioning 5.12
import QtGraphicalEffects 1.0
//import QtCharts 2.2
Item {

    FontLoader { id: myfont; source: "qrc:/font/Gugi-Regular.ttf" }
    FontLoader { id: unitfont; source: "qrc:/font/SF-Pro-Rounded-Medium.ttf" }

    Text {
        id: city_name
        font.pixelSize: 23
        font.family: myfont.name
        font.letterSpacing:10
        text: "Marrakech"
        color: "white"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors{
            top:parent.top
            topMargin: 19
        }
    }
    Text {
        id: city_datetime
        font.pixelSize: 14
        font.family: myfont.name
        font.letterSpacing:10
        text: "09:30"+" | "+"03/08"
        color: "#AEAEAE"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors{
            top:city_name.bottom
            topMargin: 5
        }
    }

    Image {
        id: windspeed_card
        source: "qrc:/assets/wspeed_card.png"
        anchors{
            top:parent.top
            topMargin: 92
            left:parent.left
            leftMargin:77
        }

        Text {
            id: windspeedvalue
            font.pixelSize:25
            font.family: myfont.name
            font.letterSpacing:2
            color:"white"
            text:weathercontroller.m_windspeed.toFixed(1)
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom:parent.bottom
            anchors.bottomMargin: 60
        }
        Text {
            id: windunit
            font.pixelSize:15
            font.family: unitfont.name
            font.letterSpacing:1
            color:"white"
            text:"m/s"
            anchors.left:windspeedvalue.right
            anchors.leftMargin:5
            anchors.bottom:parent.bottom
            anchors.bottomMargin: 60
        }
    }

    Image {
        id: uv_card
        source: "qrc:/assets/uv_card.png"
        anchors{
            top:parent.top
            topMargin: 92
            left:windspeed_card.right
            leftMargin:40
        }

        Text {
            id: uvvalue
            font.pixelSize:25
            font.family: myfont.name
            font.letterSpacing:2
            color:"white"
            text:weathercontroller.m_uv
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom:parent.bottom
            anchors.bottomMargin: 60
        }
        Text {
            id: uvunit
            font.pixelSize:15
            font.family: unitfont.name
            font.letterSpacing:1
            color:"white"
            text:"µW/m2"
            anchors.left:uvvalue.right
            anchors.leftMargin:5
            anchors.bottom:parent.bottom
            anchors.bottomMargin: 60
        }

    }

    Image {
        id: winddir_card
        source: "qrc:/assets/wdir_card.png"
        anchors{
            top:parent.top
            topMargin: 92
            left:uv_card.right
            leftMargin:40
        }
        Image {
            id: winddir
            property real lastAngle: 0
            source: "qrc:/assets/windir.png"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top:parent.top
            anchors.topMargin: 50

            RotationAnimation {
                target: winddir
                duration: 1000
                running: true
                loops: Animation.Infinite
                direction: RotationAnimation.Counterclockwise
                from: 0
                to: 360


//               onStarted: {
//                   lastAngle = to;
//                   console.log("Rotating sfrom "+from+" to "+to)
//               }
//               onStopped: {
//                   console.log("Done rotating from "+from+" to "+to)
//                   from = lastAngle;
//               }
            }
        }

        Text {
            id: winddirvalue
            font.pixelSize:25
            font.family: myfont.name
            font.letterSpacing:2
            color:"white"
            text:weathercontroller.m_winddir+"°"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom:parent.bottom
            anchors.bottomMargin: 60
        }
    }

    Image {
        id: humid_card
        source: "qrc:/assets/hum_card.png"
        anchors{
            top:parent.top
            topMargin: 92
            left:winddir_card.right
            leftMargin:40
        }

        Text {
            id: humvalue
            font.pixelSize:25
            font.family: myfont.name
            font.letterSpacing:2
            color:"white"
            text:weathercontroller.m_humid
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom:parent.bottom
            anchors.bottomMargin: 60
        }

        Text {
            id: humunit
            font.pixelSize:15
            font.family: unitfont.name
            font.letterSpacing:1
            color:"white"
            text:"%"
            anchors.left:humvalue.right
            anchors.leftMargin:5
            anchors.bottom:parent.bottom
            anchors.bottomMargin: 60
        }
    }

    Image {
        id: rain_card
        source: "qrc:/assets/rain_card.png"
        anchors{
            top:windspeed_card.bottom
            topMargin: 55
            left:parent.left
            leftMargin:77
        }
        Text {
            id: rainvalue
            font.pixelSize:25
            font.family: myfont.name
            font.letterSpacing:2
            color:"white"
            text:weathercontroller.m_rainfall.toFixed(1)
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom:parent.bottom
            anchors.bottomMargin: 60
        }
        Text {
            id: rainunit
            font.pixelSize:15
            font.family: unitfont.name
            font.letterSpacing:1
            color:"white"
            text:"mm"
            anchors.left:rainvalue.right
            anchors.leftMargin:5
            anchors.bottom:parent.bottom
            anchors.bottomMargin: 60
        }
    }

    Image {
        id: temp_card
        source: "qrc:/assets/chart_card_demo.png"
        anchors{
            top:uv_card.bottom
            topMargin: 55
            left:rain_card.right
            leftMargin:28
        }
//        ChartView {
//            id: tempchart
//            title: "Spline Chart"
//            anchors.fill: parent
//            antialiasing: true

//            SplineSeries {
//                name: "Spline"
//                XYPoint { x: 0; y: 0.0 }
//                XYPoint { x: 1.1; y: 3.2 }
//                XYPoint { x: 1.9; y: 2.4 }
//                XYPoint { x: 2.1; y: 2.1 }
//                XYPoint { x: 2.9; y: 2.6 }
//                XYPoint { x: 3.4; y: 2.3 }
//                XYPoint { x: 4.1; y: 3.1 }
//            }
//        }

//        Glow {
//                id:glow
//                anchors.fill: tempchart
//                radius: 18
//                samples: 168
//                color: "#7D9AFF"
//                source: tempchart

//            }

        Text {
            id: tempvalue
            font.pixelSize:29
            font.family: myfont.name
            font.letterSpacing:2
            color:"white"
            text:weathercontroller.m_temperature.toFixed(1)
            anchors{
                top:parent.top
                topMargin: 36
                right:parent.right
                rightMargin: 35
            }
        }

        Text {
            id: tempunit
            font.pixelSize:15
            font.family: unitfont.name
            font.letterSpacing:1
            color:"white"
            text:"°C"
            anchors.left:tempvalue.right
            anchors.leftMargin:5
            anchors.top:parent.top
            anchors.topMargin: 36
        }


    }


//    Image {
//        id: map_card
//        source: "qrc:/assets/map_demo.png"
//        anchors{
//            bottom:parent.bottom
//            bottomMargin: 58
//            right:parent.right
//            rightMargin:87
//        }
//    }

    Rectangle {
        id: rectMap
        width: 330
        height: 191
        radius: 25
//        border {
//            width: 1
//            color: "black"
//        }
        anchors{
            top:humid_card.bottom
            topMargin: 55
            left:temp_card.right
            leftMargin:30
        }


        Plugin {
            id:mapPlugin
            name:"osm" // "mapboxgl", "esri","osm" ...

            PluginParameter {
                name: "osm.mapping.providersrepository.disabled"
                value: "true"
            }
            PluginParameter {
                name: "osm.mapping.providersrepository.address"
                value: "http://maps-redirect.qt.io/osm/5.6/"
            }
            PluginParameter
            {
                name: "osm.mapping.custom.host"
                value: "http://a.tile.openstreetmap.fr/hot/"
                //                    value:"https://cartodb-basemaps-a.global.ssl.fastly.net/dark_all/"
            }
            PluginParameter {
                name: "osm.mapping.cache.memory"
                value: true
            }
        }

        Map {
            id: carte
            anchors.fill: parent

            layer.enabled: true
            layer.effect: OpacityMask {
                maskSource: Rectangle {
                    width: rectMap.width
                    height: rectMap.height
                    radius: rectMap.radius
                }
            }

            // Enable pan, flick, and pinch gestures to zoom in and out
            gesture.acceptedGestures: MapGestureArea.PanGesture | MapGestureArea.FlickGesture | MapGestureArea.PinchGesture | MapGestureArea.RotationGesture | MapGestureArea.TiltGesture

            gesture.flickDeceleration: 3000
            //                gesture.enabled: true
            plugin: mapPlugin
            center:QtPositioning.coordinate(33.59160,-7.678);
            //center: location
            zoomLevel: 15
            tilt: 40
            //activeMapType: supportedMapTypes[supportedMapTypes.length - 1]
            activeMapType: supportedMapTypes[3]
            copyrightsVisible: false

            transitions: Transition {
                ColorAnimation {
                    properties: "lineColor"
                    easing.type: Easing.InOutQuad
                    duration: 1000
                }
            }
            MapCircle {
                id: puce
                radius: 90
                center: QtPositioning.coordinate(33.59160,-7.678);
                color: 'green'
                border.width: 2
                opacity: 0.25
            }

            MapQuickItem {
                id: marqueur
                anchorPoint {
                    x: image.width/2
                    y: image.height
                }
                sourceItem:Image
                { id: image
                  source: "qrc:/assets/map_position.svg"
                }

            }
        }
    }



//    Text {
//        id: temp
//        font.pointSize: 20
//        font.family: myfont.name
//        font.letterSpacing:2
//        text: "Temperature: "+weathercontroller.m_temperature.toFixed(1) +"°C"
//        anchors.horizontalCenter: parent.horizontalCenter
//    }
//    Text {
//        id: hum
//        font.pointSize: 20
//        font.family: myfont.name
//        font.letterSpacing:2
//        text: "Humidité: "+weathercontroller.m_humid +"%"
//        anchors.top: temp.bottom
//        anchors.horizontalCenter:parent.horizontalCenter
//    }
//    Text {
//        id: windir
//        font.pointSize: 20
//        font.family: myfont.name
//        font.letterSpacing:2
//        text: "Direction du vent: "+weathercontroller.m_winddir+"°"
//        anchors.top: hum.bottom
//        anchors.horizontalCenter:parent.horizontalCenter
//    }
//    Text {
//        id: winspeed
//        font.pointSize: 20
//        font.family: myfont.name
//        font.letterSpacing:2
//        text: "Vitesse du vent: "+weathercontroller.m_windspeed.toFixed(1)+"m/s"
//        anchors.top: windir.bottom
//        anchors.horizontalCenter:parent.horizontalCenter
//    }
//    Text {
//        id: light
//        font.pointSize: 20
//        font.family: myfont.name
//        font.letterSpacing:2
//        text: "Eclairement: "+weathercontroller.m_lux+"lux"
//        anchors.top: winspeed.bottom
//        anchors.horizontalCenter:parent.horizontalCenter
//    }

//    Text {
//        id: uv
//        font.pointSize: 20
//        font.family: myfont.name
//        font.letterSpacing:2
//        text: "Irradiation Ultraviolet: "+weathercontroller.m_uv+"µW/cm2"
//        anchors.top: light.bottom
//        anchors.horizontalCenter:parent.horizontalCenter
//    }

//    Text {
//        id: rainfall
//        font.pointSize: 20
//        font.family: myfont.name
//        font.letterSpacing:2
//        text: "Pluviométrie: "+weathercontroller.m_rainfall.toFixed(1)+"mm"
//        anchors.top: uv.bottom
//        anchors.horizontalCenter:parent.horizontalCenter
//    }
}
