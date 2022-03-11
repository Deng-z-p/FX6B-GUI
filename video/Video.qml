import QtQuick 2.12
import Qt.labs.folderlistmodel 2.12
import QtQuick.Controls 2.5
import Package.video 1.0

Item {
    id: videoItem
    Video{id: m_video}
    Rectangle{
        id: video_Area
        objectName: "video_Area"
        anchors.fill: parent
        width: parent.width; height: parent.height
        color: theme.themecolor
        ListView{
            id: listFileView
            anchors.fill: parent

            model: FolderListModel{
                id: folderModel
                nameFilters: ["*.avi", "*.mp4", "*.flv"]
                showDirs: false
                folder: "file:///media/video/"
            }

            delegate: Rectangle{
                height: 50; width: parent.width
                color: "#1F1E58"
                Text {
                    anchors.centerIn: parent
                    text: fileBaseName
                    color: "white"
                    font.pixelSize: 20
                }
                Rectangle{
                   anchors.left: parent.left
                   anchors.leftMargin: 30
                   anchors.right: parent.right
                   anchors.rightMargin: 30
                   width: parent.width; height: 1
                   color: "yellow"
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        //console.log(folderModel.get(index, "filePath"))
                        rec_Exit.visible = true
                        backBtn.visible = false
                        m_video.mplayer_play(folderModel.get(index, "filePath"),
                                             video_Area.width,
                                             video_Area.height)
                    }
                }
            }
        }
        Rectangle{
            id: rec_Exit
            visible: false
            anchors.fill: video_Area
            color: theme.themecolor
            MouseArea{
                anchors.fill: parent
                onClicked:{
                    console.log("exit video play")
                    m_video.mplayer_exit()
                    backBtn.visible = true
                    rec_Exit.visible = false
                }
            }
        }
    }
}
