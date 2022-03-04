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
                        source: "qrc:/desktop/winstyleicons/calc_app.png"
                    }
                    Text{
                        text: qsTr("calculator")
                        color: "white"
                        font.pixelSize: 13
                        font.bold: true
                        anchors{
                            left: parent.left; leftMargin: 3
                            bottom: parent.bottom; bottomMargin: 3
                        }
                    }
                    style:ButtonStyle{
                        background: Rectangle{
                            color: "#0072C5"
                            border.color: "white"
                            border.width: control.hovered ? 1 : 0
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
                    Text {
                        text: qsTr("BenchMark")
                        color: "white"
                        font.pixelSize: 15
                        font.bold: true
                        anchors{
                            left: parent.left; leftMargin: 3
                            bottom: parent.bottom; bottomMargin: 3
                        }
                    }
                    style: ButtonStyle{
                        background: Rectangle{
                            color: "#CA2C2B"
                            border.color: "white"
                            border.width: control.hovered ? 1 : 0
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
                    Image {}
                    Text{
                        text: qsTr("video")
                        color: "white"
                        font.pixelSize: 15
                        font.bold: true
                        anchors{
                            left: parent.left; leftMargin: 3
                            bottom: parent.bottom; bottomMargin: 3
                        }
                    }
                    style: ButtonStyle{
                        background: Rectangle{
                            color: "#0072C5"
                            border.color: "white"
                            border.width: control.hovered ? 1 : 0
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
                    Image {}
                    Text {
                        text: qsTr("File")
                        color: "white"
                        font.pixelSize: 15
                        font.bold: true
                        anchors{
                            left: parent.left; leftMargin: 3
                            bottom: parent.bottom; bottomMargin: 3
                        }
                    }
                    style: ButtonStyle{
                        background: Rectangle{
                            color: "#0072C5"
                            border.color: "white"
                            border.width: control.hovered ? 1 : 0
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
