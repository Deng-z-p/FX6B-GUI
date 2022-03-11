import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.5
import "./desktop"
import "./calculator"
import "./benchmark"
import "./video"
import "./fileview"
import "./album"

Window {
    id: mainWindow
    visible: true
    width: 1280
    height: 800
    Item {
        id: theme
        property string themecolor: "#1f1e58"
    }

    Rectangle {
        anchors.fill: parent
        color: theme.themecolor
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
            WinStyleDesktop{}
            Calculator{}
            Benchmark{}
            Video{}
            Fileview{}
            Album{}
            onCurrentIndexChanged: {
                mainSwipeView.currentItem.visible = true
                for(var i=0; i<mainSwipeView.count; i++){
                    if(i !== mainSwipeView.currentIndex)
                        mainSwipeView.itemAt(i).visible = false
                }
            }
        }
    }
}
