import QtQuick 2.12
import QtQml 2.12

Item {
    id: system_Item
    Rectangle {
        id: system_bkg
        anchors.fill: parent
        color: theme.theme_bkg_color
    }
    Rectangle {
        id: system_Description
        anchors {
            top: system_Item.top
            left: system_Item.left
        }
        width: parent.width; height: parent.height/5
        color: (theme.theme_bkg_color == "#1F1E58") ? "#2F2D84" : "#F0F0CD"
        Text {
            anchors {
                verticalCenter: system_Description.verticalCenter
                left: system_Description.left; leftMargin: 10
            }
            font.pixelSize: theme.theme_font_size + 10
            font.bold: true
            color: theme.theme_font_color
            text: "This Page is a description of onboard hardware resources"
        }
    }
    ListModel {
        id: system_ListModel
        ListElement{name:""}
        ListElement{name:""}
        ListElement{name:""}
        ListElement{name:""}
        function getIcon(index){
            var data = ["icons/CPU.png",
                        "icons/Memory.png",
                        "icons/emmc.png",
                        "icons/screen.png"]
            return data[index]
        }
        function getItemName(index){
            var data = ["CPU",
                        "MEMORY",
                        "EMMC",
                        "RESOLUTION"]
            return data[index]
        }
        function getInformation(index){
            var data = [["SCS931 800MHZ"],
                        ["2048MB"],
                        ["4.00GB"],
                        [system_Item.width+ "X" + system_Item.height]]
            return data[index][0]
        }
    }
    Component {
        id: system_delegate
        Rectangle {
            width: system_GrideView.cellWidth
            height: system_GrideView.cellHeight
            color: theme.theme_bkg_color
            radius: 10
            Image {
                id: system_icon
                anchors.centerIn: parent
                width: parent.width/5*3
                height: parent.height/5*3
                source: system_GrideView.model.getIcon(index)
            }
            Text {
                id: system_Name_Text
                anchors {
                    top: system_icon.bottom; bottomMargin: 10
                    left: system_icon.left; leftMargin: 10
                }
                font.pixelSize: theme.theme_font_size + 3
                font.bold: true
                color: theme.theme_font_color
                text: system_GrideView.model.getItemName(index)
            }
            Text {
                anchors {
                    top: system_Name_Text.bottom; bottomMargin: 3
                    left: system_Name_Text.left
                }
                font.pixelSize: theme.theme_font_size + 3
                font.bold: true
                color: theme.theme_font_color
                text: system_GrideView.model.getInformation(index)
            }
        }
    }
    GridView {
        id: system_GrideView
        visible: true
        anchors {
            top: system_Description.bottom; topMargin: 10
            left: system_Description.left
        }
        width: parent.width; height: parent.height/5*4
        cellWidth: system_GrideView.width / 3
        cellHeight: system_GrideView.height / 2
        model: system_ListModel
        delegate: system_delegate
    }
}
