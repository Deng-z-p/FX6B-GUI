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
                    id: tips2
                    text: qsTr("App")
                    color: "white"
                    font.pixelSize: 17
                    font.bold: true
                    anchors.top: parent.top
                    anchors.topMargin: 10
                    anchors.left: calculator_app.left
                }
                Text {
                    id: tips3
                    text: qsTr("Text")
                    color: "white"
                    font.pixelSize: 17
                    font.bold: true
                    anchors.top: parent.top
                    anchors.topMargin: 10
                    anchors.left: benchmark_app.left
                }
                Button{
                    id:calculator_app
                    anchors.top: parent.top
                    anchors.topMargin: 50
                    anchors.right: parent.horizontalCenter
                    anchors.rightMargin: 50
                    width: 100
                    height: 100
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
                        font.pixelSize: 15
                        font.bold: true
                        anchors.left: parent.left
                        anchors.bottom: parent.bottom
                        anchors.leftMargin: 3
                        anchors.bottomMargin: 3
                    }
                    style:ButtonStyle{
                        background: Rectangle{
                            color: "#0072C5"
                            border.color: "#BBBBBBBB"
                            border.width: control.hovered ? 1 : 0
                        }
                    }
                }
                Button{
                    id: benchmark_app
                    anchors.top: parent.top
                    anchors.topMargin: 50
                    anchors.right: parent.right
                    anchors.rightMargin: 100
                    width: 150
                    height: 100
                    Text {
                        text: qsTr("BenchMark")
                        color: "white"
                        font.pixelSize: 15
                        font.bold: true
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 3
                        anchors.left: parent.left
                        anchors.leftMargin: 3
                    }
                    style: ButtonStyle{
                        background: Rectangle{
                            color: "#CA2C2B"
                            border.color: "#BBBBBBBB"
                            border.width: control.hovered ? 1 : 0
                        }
                    }
                }
            }
        }
//        Item{
//            id: secondPage
//        }
    }

    PageIndicator {
        id: indicator
        count: view.count
        currentIndex: view.currentIndex
        anchors.bottom: view.bottom
        anchors.horizontalCenter: parent.horizontalCenter
    }
}
