import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.5
import "./desktop"
import "./calculator"
import "./benchmark"
import "./video"
import "./fileview"
import "./album"
import "./settings"
import "./system"

Window {
    id: mainWindow
    visible: true
    width: 1280
    height: 800
    Item {
        id: theme
        property string theme_bkg_color: "#1F1E58"
        property string theme_font_color: "white"
        property int theme_font_size: 12
    }

    Rectangle {
        anchors.fill: parent
        color: theme.theme_bkg_color
    }

    RoundButton {
        id: backBtn
        z : 1
        x: parent.x + parent.width - 90
        y: parent.y + parent.height / 2 -50
        width: 60
        height: 60
        visible: mainSwipeView.currentIndex != 0
        hoverEnabled: true
        opacity: hovered ? 1 : 0.3

        Image {
            anchors.centerIn: parent
            source: "qrc:/desktop/icons/back.png"
        }

        MouseArea {
            anchors.fill: parent
            drag.target: backBtn
            drag.minimumX: 0
            drag.minimumY: 0
            drag.maximumX: mainWindow.width - 60
            drag.maximumY: mainWindow.height - 60
            onClicked: {
                if(mainSwipeView.currentIndex != 0)
                    mainSwipeView.currentIndex = 0
            }
        }
    }

    Rectangle {
        anchors.fill: parent
        color: "transparent"
        SwipeView{
            id: mainSwipeView
            anchors.fill: parent
            interactive: false
            orientation: ListView.Horizontal
            Desktop{}
            Calculator{}
            Benchmark{}
            Video{}
            Fileview{}
            Album{}
            Settings{}
            System{}
            onCurrentIndexChanged: {
                mainSwipeView.currentItem.visible = true
                for(var i=0; i<mainSwipeView.count; i++){
                    if(i !== mainSwipeView.currentIndex)
                        mainSwipeView.itemAt(i).visible = false
                }
            }
        }
    }
    Timer{
        id: initializing_Timer
        interval: 1000
        repeat: true
        running: true
        property int timerCount: 0
        onTriggered: {
            timerCount ++
            console.log("left-timer:", 4-timerCount)
            if(timerCount == 2){
                initializing_text.text = "Welcome"
            }
            if(timerCount == 4){
                initializing_item.visible = false
                initializing_Timer.running = false
            }
        }
    }

    Item{
        id: initializing_item
        anchors.fill: parent
        Rectangle{
            anchors.fill: parent
            color:theme.theme_bkg_color
            Text {
                id: initializing_text
                anchors.centerIn: parent
                text: "Initializing, Just a moment, Please"
                color: "white"
                font.pixelSize: 50
                font.bold: true
            }
        }
    }
}
