import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.4

Item {
    SwipeView{
        id: view
        anchors.fill: parent
        currentIndex: 0
        interactive: true

        Item{
            id: page1
            Flickable{
                id: first
                anchors.fill: parent
                Text {
                    text: qsTr("App")
                    color: "white"
                    font.pixelSize: 15
                    font.bold: true
                    anchors.bottom: calculator_app.top
                    anchors.bottomMargin: 10
                    anchors.left: calculator_app.left
                }
                Text {
                    text: qsTr("Test")
                    color: "white"
                    font.pixelSize: 15
                    font.bold: true
                    anchors.bottom: benchmark_app.top
                    anchors.bottomMargin: 10
                    anchors.left: benchmark_app.left
                }

                Button{
                    id:calculator_app
                    anchors{
                        top: parent.top; topMargin: parent.height/10
                        left: parent.left; leftMargin: parent.width/25
                    }
                    width: parent.width/6
                    height: parent.height/4

                    onClicked: {
                        mainSwipeView.setCurrentIndex(1)
                    }
                    Image {
                        anchors.centerIn: parent
                        width: calculator_app.width/5*4; height: calculator_app.height/5*4
                        source: "qrc:/desktop/icons/calculator.png"
                    }
                    Text{
                        text: "calculator"
                        color: "black"
                        font.pixelSize: 12
                        font.bold: true
                        anchors{
                            left: parent.left; leftMargin: 3
                            bottom: parent.bottom;
                        }

                    }
                    style:ButtonStyle{
                        background: Rectangle{
                            border.color: "white"
                            border.width: control.hovered ? 1 : 0
                            radius: 10
                        }
                    }
                }
                Button{
                    id: benchmark_app
                    anchors{
                        top: parent.top; topMargin: parent.height/10
                        right: parent.right; rightMargin: parent.width/25
                    }
                    width: parent.width/4
                    height: parent.height/4

                    onClicked: {
                        mainSwipeView.setCurrentIndex(2)
                    }
                    Image {
                        anchors.centerIn: parent
                        width: benchmark_app.width/5*4; height: benchmark_app.height/5*4
                        source: "qrc:/desktop/icons/benchmark.png"
                    }
                    Text {
                        text: qsTr("BenchMark")
                        color: "black"
                        font.pixelSize: 12
                        font.bold: true
                        anchors{
                            left: parent.left; leftMargin: 3
                            bottom: parent.bottom;
                        }
                    }
                    style: ButtonStyle{
                        background: Rectangle{
                            border.color: "white"
                            border.width: control.hovered ? 1 : 0
                            radius: 10
                        }
                    }
                }
                Button{
                    id: video_app
                    anchors{
                        top: calculator_app.bottom; topMargin: parent.height/30
                        left: calculator_app.left
                    }
                    width: parent.width/6
                    height: parent.height/4

                    onClicked: { mainSwipeView.setCurrentIndex(3)}
                    Image {
                        anchors.centerIn: parent
                        width: video_app.width/5*4; height: video_app.height/5*4
                        source: "qrc:/desktop/icons/video.png"
                    }
                    Text{
                        text: qsTr("video")
                        color: "black"
                        font.pixelSize: 12
                        font.bold: true
                        anchors{
                            left: parent.left; leftMargin: 3
                            bottom: parent.bottom;
                        }
                    }
                    style: ButtonStyle{
                        background: Rectangle{
                            border.color: "white"
                            border.width: control.hovered ? 1 : 0
                            radius: 10
                        }
                    }
                }
                Button{
                    id: fileview_app
                    anchors{
                        top: parent.top; topMargin: parent.height/10
                        left: calculator_app.right; leftMargin: parent.width/45
                    }
                    width: parent.width/6
                    height: parent.height/4

                    onClicked: {mainSwipeView.setCurrentIndex(4)}
                    Image {
                        anchors.centerIn: parent
                        width: fileview_app.width/5*4; height: fileview_app.height/5*4
                        source: "qrc:/desktop/icons/folder.png"
                    }
                    Text {
                        text: qsTr("File")
                        color: "black"
                        font.pixelSize: 12
                        font.bold: true
                        anchors{
                            left: parent.left; leftMargin: 3
                            bottom: parent.bottom;
                        }
                    }
                    style: ButtonStyle{
                        background: Rectangle{
                            border.color: "white"
                            border.width: control.hovered ? 1 : 0
                            radius: 10
                        }
                    }
                }
            }
        }
    }

    PageIndicator {
        id: indicator
        count: view.count
        currentIndex: view.currentIndex
        anchors.bottom: view.bottom
        anchors.horizontalCenter: parent.horizontalCenter
    }
}
