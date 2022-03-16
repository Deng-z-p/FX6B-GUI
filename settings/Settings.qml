import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQml 2.12
import Package.settings 1.0

Item {
    visible: false

    property int settings_status

    Settings{id: settings}
    Rectangle{
        id: settings_bkg
        anchors.fill: parent
        color: theme.theme_bkg_color
    }
    Rectangle{
        anchors{
            top: parent.top; topMargin: 20
            left: parent.left; leftMargin: 20
        }
        width: parent.width/3; height: parent.height/4
        color: (theme.theme_bkg_color == "#1F1E58") ? "#2F2D84" : "#F0F0CD"
        radius: 10
        Slider{
            id: setting_Slider_fontSize
            anchors.centerIn: parent
            width: parent.width/5*4; height: parent.height/4
            stepSize: 1
            from: 5
            to: 35
            value: theme.theme_font_size
            Text {
                id: settings_Slider_FontSize_Text
                text: "System Font Size"
                anchors{
                    bottom: setting_Slider_fontSize.top; bottomMargin: 20
                    left: setting_Slider_fontSize.left
                }
                font.pixelSize: theme.theme_font_size
                font.bold: true
                color: theme.theme_font_color
            }
            onMoved: {
                theme.theme_font_size = value
            }
        }
    }
    Timer{
        id: dialogTimer
        interval: 1000
        running: false
        repeat: false
        onTriggered: {
            switch (settings_status){
            case 1:
                mainWindow.visible=false
                Qt.quit()
                break;
            case 2:
                settings.reboot()
                break;
            case 3:
                if(theme.theme_bkg_color == "#1F1E58"){
                    theme.theme_bkg_color = "beige"
                    theme.theme_font_color = "black"
                }
                else if(theme.theme_bkg_color == "beige"){
                    theme.theme_bkg_color = "#1F1E58"
                    theme.theme_font_color = "white"
                }
                settings_hintdialog.close()
                break;
            }
        }
    }
    ListModel{
        id: settingListModel
        ListElement{name:""}
        ListElement{name:""}
        ListElement{name:""}
        function getIcon(index){
            var data = ["icons/close.png",
                        "icons/reboot.png",
                        "icons/theme.png"]
            return data[index];
        }
        function getItemName(index){
            var data = ["Quit",
                        "Reboot",
                        "Theme"]
            return data[index];
        }
    }
    Component{
        id: settingListDelegate
        Rectangle{
            width: settingGridView.cellWidth
            height: settingGridView.cellHeight
            color: theme.theme_bkg_color
            radius: 10
            Image {
                id: settings_icon
                anchors.centerIn: parent
                width: parent.width/5*3
                height: parent.height/5*3
                source: settingGridView.model.getIcon(index)
            }
            Text {
                anchors{
                    top: settings_icon.bottom; bottomMargin: 10
                    left: settings_icon.left; leftMargin: 10
                }
                font.pixelSize: theme.theme_font_size + 3
                font.bold: true
                color: theme.theme_font_color
                text: settingGridView.model.getItemName(index)
            }
            MouseArea{
                anchors.fill: parent
                hoverEnabled: true
                onClicked: {
                    switch (index){
                    case 0:
                        settings_hintdialog_text.text = "Desktop is exiting, Please wait a moment"
                        settings_hintdialog.open()
                        settings_status = 1
                        dialogTimer.start()
                        break;
                    case 1:
                        settings_hintdialog_text.text = "Rebooting, Please wait a moment"
                        settings_hintdialog.open()
                        settings_status = 2
                        dialogTimer.start()
                        break;
                    case 2:
                        settings_hintdialog_text.text = "Theme color switching, Please wait a moment"
                        settings_hintdialog.open()
                        settings_status = 3
                        dialogTimer.start()
                        break;
                    }
                }
                onEntered: {
                    parent.opacity = 0.5
                }
                onExited: {
                    parent.opacity = 1
                }
            }
        }
    }
    GridView{
        id: settingGridView
        visible: true
        anchors.bottom: parent.bottom
        width: parent.width; height: parent.height / 2
        cellWidth: settingGridView.width/3
        cellHeight: settingGridView.height
        model: settingListModel
        delegate: settingListDelegate
    }
    Dialog{
        id: settings_hintdialog
        modal: true
        closePolicy: Popup.CloseOnPressOutside
        anchors.centerIn: parent
        width: parent.width/2; height: parent.height/5
        background:Rectangle{
            anchors.fill: parent
            color: theme.theme_bkg_color
            radius: 10
            Text {
                id: settings_hintdialog_text
                anchors.centerIn: parent
                color: "red"
                font.pixelSize: theme.theme_font_size + 10
                font.bold: true
            }
        }
    }

}
