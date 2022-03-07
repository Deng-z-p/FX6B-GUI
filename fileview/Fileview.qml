import QtQuick 2.12
import Qt.labs.folderlistmodel 2.12
import QtQuick.Controls 2.5
import Package.fileio 1.0

Item {
    id: fileview
    visible: false
    FileIO{
        id: fileIO
        onSourceChanged: {
            console.log("receive text")
            readText.text = source
            warningDialog.close()
        }
    }
    Rectangle {
        id: myFileView
        anchors.fill: parent
        color: theme.themecolor

        property string folderPathName: "file:/"
        property string currentPathName

        ListView{
            id: filePath
            anchors{
                top:parent.top; topMargin: 10
                left:parent.left;
            }
            width: parent.width; height: 40

            clip: true
            orientation: ListView.Horizontal

            delegate: Rectangle{
                width: pathText.contentWidth; height: 40
                color: "transparent"
                Text {
                    id: pathText
                    anchors.centerIn: parent
                    text: myPathName
                    color: parent.ListView.isCurrentItem ? "white": "#25cfea"
                }
                Text {
                    visible: false
                    text: myPath
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        myFileView.folderPathName = filePath.model.get(index).myPath
                        if(index < filePath.count-1){
                            var count = filePath.count - 1
                            for(var i=index; i<count; i++)
                                filePath.model.remove(index + 1)
                        }
                    }
                }
            }

            model: ListModel{id: listmodel}
        }
        ListView{
            id: listFileView
            anchors{
                top: filePath.bottom
                left: parent.left
                right: parent.right
                bottom: parent.bottom
            }
            ScrollBar.vertical: ScrollBar{}
            clip: true
            delegate: Rectangle{
                width: parent.width; height: 60
                color: "transparent"
                Image {
                    id: folderIcon
                    anchors.left: parent.left; anchors.leftMargin: 15
                    anchors.verticalCenter: parent.verticalCenter
                    width: 59; height: 48
                    source: folderModel.get(index, "fileIsDir") ? "qrc:/fileview/icons/folder_file.png" : "qrc:/fileview/icons/other_file.png"
                }
                Text {
                    text: fileName
                    color: "white"
                    anchors{
                        left: folderIcon.right; leftMargin: 10
                        verticalCenter: parent.verticalCenter
                    }
                }

                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        if(folderModel.isFolder(index)){
                            myFileView.folderPathName = folderModel.get(index, "fileURL")
                            myFileView.currentPathName = folderModel.get(index, "fileName")
                            myFileView.insertItem()
                        }else{
                            switch(folderModel.get(index, "fileSuffix")){
                                case "txt":
                                case ".c":
                                case "h":
                                case "cpp":
                                case "py":
                                case "mak":
                                case "sh":
                                case "conf":
                                case "xml":
                                    break;
                                default:
                                    warningText.text = "Sorry, Failed to open file type"
                                    warningDialog.open()
                                    return
                            }
                            dialog.open()
                            if(folderModel.get(index, "fileSize") >= 20000){
                                warningText.text = "Sorry, File too big!"
                                warningDialog.open()
                                return
                            }
                            if(folderModel.get(index, "fileSize") >= 2000){
                                console.log(folderModel.get(index, "fileSize"))
                                warningText.text = "File too big, Please waitting"
                                warningDialog.open()
                            }
                            /*Get the file path and file name, the sub-thread will go to read the
                             content,and send "SourceChanged" signal*/
                            fileIO.source = folderModel.get(index, "filePath")
                        }
                    }
                }
            }
           model: FolderListModel{
                id:folderModel
                showDirs: true
                showFiles: true
                showDirsFirst: true
                showDotAndDotDot: false
                nameFilters: ["*"]
                folder: myFileView.folderPathName
            }
        }
        Dialog{
            id: warningDialog
            modal: true
            closePolicy: Popup.CloseOnPressOutside
            anchors.centerIn: parent
            width: parent.width/2
            height: parent.height/5
            background: Rectangle{
                anchors.fill: parent
                color: theme.themecolor
                radius: 20
            }
            Text {
                id: warningText
                anchors.top: parent.top
                width: parent.width
                color: "red"
                font.pixelSize: 18
            }
        }
        Dialog{
            id: dialog
            visible: false
            anchors.centerIn: parent
            width: parent.width; height: parent.height
            background: Rectangle{
                anchors.fill: parent
                color: theme.themecolor
            }
            Button{
                anchors{
                    top: parent.top; topMargin: 10
                    left: parent.left; leftMargin: 10
                }
                width: 50; height: 30
                background: Rectangle{
                    color: "transparent"
                }
                contentItem: Text {
                    text: (">> Back")
                    color: "white"
                    font.bold: true
                }
                onClicked: {
                    readText.text = ""
                    dialog.close()
                }
            }
            Flickable{
                anchors.top: parent.top
                anchors.topMargin: 50
                width: parent.width; height: parent.height
                contentWidth: readText.width
                contentHeight: readText.height
                clip: true
                    Text {
                    id: readText
                    color: "green"
                    font.pixelSize: 15
                }
                ScrollBar.vertical: ScrollBar{}
               //ScrollBar.horizontal: ScrollBar{}
            }
        }
        function insertItem(){
            filePath.model.insert(filePath.model.count,
                                   {"myPathName":">" + myFileView.currentPathName,
                                    "myPath":myFileView.folderPathName})
            filePath.currentIndex = filePath.count -1
        }
        Component.onCompleted: {
            filePath.model.insert(filePath.model.count,
                                   {"myPathName": "/"
                                   ,"myPath": "file:/"})
            filePath.currentIndex = filePath.count - 1
        }
    }
}
