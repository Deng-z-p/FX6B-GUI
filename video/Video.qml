import QtQuick 2.12
import Qt.labs.folderlistmodel 2.12
import QtQuick.Controls 2.5
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.12

Item {
    id: videoItem
    Rectangle{
        id: video_Play_Area
        width: parent.width-150; height: parent.height-50
        anchors{
            top: parent.top
            left: parent.left
        }
        color: "black"
    }
    Rectangle{
        id: video_Item_Area
        width: 150; height: parent.height-50
        anchors{
            top: parent.top
            right: parent.right
        }
        color: "#1F1E58"
        ListView{
            id: listFileView
            anchors.fill: parent

            model: FolderListModel{
                id: folderModel
                nameFilters: ["*.avi", "*.mp4", "*.flv"]
                showDirs: false
                folder: "file:///media/"
            }

            delegate: Rectangle{
                height: 30; width: parent.width
                color: "#1F1E58"
                Text {
                    anchors.fill: parent
                    text: fileBaseName
                    color: "white"
                    font.pixelSize: 20
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        console.log(folderModel.get(index, "filePath"))
                    }
                }
            }
        }
    }
    Rectangle{
        id: video_btn_Area
        width: parent.width; height: 50
        anchors{
            bottom: parent.bottom
            left: parent.left
        }
        color: "#141414"
        Button{
            id: play
            width: 44; height: 44
            anchors{
                left: parent.left; leftMargin: 10
            }
            Image {
                anchors.centerIn: parent
                source: "qrc:/video/images/btn_play.png"
            }
        }
        Button{
            id: next
            width: 44; height: 44
            anchors{
                left: play.right; rightMargin: 20
            }
            Image {
                anchors.centerIn: parent
                source: "qrc:/video/images/btn_next.png"
            }
        }
        Button{
            id: fullscreen
            width: 44; height: 44
            anchors{
                right: parent.right; rightMargin: 10
            }
            Image {
                anchors.centerIn: parent
                source: "qrc:/video/images/btn_fullscreen.png"
            }
        }

    }
}
