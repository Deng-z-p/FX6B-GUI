import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.4
import Package.desktop 1.0
Item {
    id: desktop_Item
    Desktop {
        id: desktop
        onCpurate_Changed: {
            cpu0_Rate_Text.text = desktop.cpurate0 + '%'
            cpu1_Rate_Text.text = desktop.cpurate1 + '%'
            cpu0_Rate.percent = desktop.cpurate0 / 100
            cpu1_Rate.percent = desktop.cpurate1 / 100
        }
    }
    Timer {
        id: desktop_Timer
        interval: 1000
        repeat: true
        running: desktop_view.currentIndex == 0 ? true : false
        onTriggered: {
            desktop.read_meminfo()
            memUsed_text.text = desktop.MemUsed + "KB"
            memTotal_text.text = desktop.MemTotal + "KB"
            sram_Rate.percent = desktop.MemUsed/desktop.MemTotal

            uptime_Text.text = desktop.read_uptime()+'S'
            desktop.read_cpurate()
        }
    }
    SwipeView{
        id: desktop_view
        anchors.fill: parent
        currentIndex: 1
        interactive: true
        Item{
            id: page0
            Rectangle{
                id: cpu_Rate_Area
                anchors {
                    top: page0.top; topMargin: 20
                    left: page0.left; leftMargin: 20
                    right: page0.right; rightMargin: 20
                }
                width: page0.width-40; height: page0.height/2
                color: "transparent"
                border.width: 10
                border.color: (theme.theme_bkg_color == "#1F1E58") ? "#2F2D84" : "#F0F0CD"
                radius: 20
                Rectangle{
                    id: cpu0_Rate
                    anchors {
                        top: parent.top; topMargin: 30
                        left: parent.left; leftMargin: 30
                    }
                    width:parent.height - 60; height: width
                    radius: width/2
                    color: "transparent"
                    border.width: 10
                    border.color: (theme.theme_bkg_color == "#1F1E58") ? "#2F2D84" : "#F0F0CD"
                    property var percent: 0
                    gradient: Gradient{
                        GradientStop {position: 0; color: "transparent"}
                        GradientStop {position: 1-cpu0_Rate.percent; color: "transparent"}
                        GradientStop {position: 1-cpu0_Rate.percent+0.01; color: "lightcoral"}
                    }
                    Text {
                        id: cpu0_Rate_Text
                        anchors.centerIn: parent
                        font.pixelSize: theme.theme_font_size + 20
                        color: theme.theme_font_color
                        font.bold: true
                    }
                    Text {
                        anchors.bottom: parent.bottom
                        font.pixelSize: theme.theme_font_size + 10
                        font.bold: true
                        color: theme.theme_font_color
                        text: "CPU0"
                    }
                }
                Rectangle{
                    id: cpu1_Rate
                    anchors {
                        top: parent.top; topMargin: 30
                        left: cpu0_Rate.right; leftMargin: 30
                    }
                    width: parent.height - 60; height: width
                    radius: width/2
                    color: "transparent"
                    border.width: 10
                    border.color: (theme.theme_bkg_color == "#1F1E58") ? "#2F2D84" : "#F0F0CD"
                    property var percent: 0
                    gradient: Gradient{
                        GradientStop {position: 0; color: "transparent"}
                        GradientStop {position: 1-cpu1_Rate.percent; color: "transparent"}
                        GradientStop {position: 1-cpu1_Rate.percent+0.01; color: "lightcoral"}
                    }
                    Text {
                        id: cpu1_Rate_Text
                        anchors.centerIn: parent
                        font.pixelSize: theme.theme_font_size + 20
                        color: theme.theme_font_color
                        font.bold: true
                    }
                    Text {
                        anchors.bottom: parent.bottom
                        font.pixelSize: theme.theme_font_size + 10
                        font.bold: true
                        color: theme.theme_font_color
                        text: "CPU1"
                    }
                }
                Rectangle{
                    id: sram_Rate
                    anchors {
                        top: parent.top; topMargin: 30
                        left: cpu1_Rate.right; leftMargin: 30
                    }
                    width: parent.height - 60; height: width
                    radius: width/2
                    color: "transparent"
                    border.width: 10
                    border.color: (theme.theme_bkg_color == "#1F1E58") ? "#2F2D84" : "#F0F0CD"
                    property var percent: 0
                    gradient: Gradient{
                        GradientStop {position: 0; color: "transparent"}
                        GradientStop {position: 1-sram_Rate.percent; color: "transparent"}
                        GradientStop {position: 1-sram_Rate.percent+0.01; color: "lightcoral"}
                    }
                    Rectangle {
                        anchors.centerIn: parent
                        width: parent.width / 2; height: parent.height /2
                        color: "transparent"
                        Text {
                            id: memUsed_text
                            anchors {
                                centerIn: parent
                                horizontalCenterOffset: -40
                                verticalCenterOffset: -40
                            }
                           font.pixelSize: theme.theme_font_size + 10
                           font.bold: true
                           color: theme.theme_font_color
                        }
                        Text {
                            id: memTotal_text
                            anchors {
                                centerIn: parent
                                horizontalCenterOffset: 40
                                verticalCenterOffset: 40
                            }
                            font.pixelSize: theme.theme_font_size + 10
                            font.bold: true
                            color: theme.theme_font_color
                        }
                        Canvas {
                            id: sram_canvas
                            anchors.fill: parent
                            onPaint: {
                                var ctx = getContext("2d")
                                draw(ctx)
                            }
                            function draw(ctx) {
                                ctx.strokeStyle = "red"
                                ctx.lineWidth = 10
                                ctx.beginPath()
                                ctx.moveTo(0, parent.height)
                                ctx.lineTo(parent.width, 0)
                                ctx.stroke()
                            }
                        }
                    }
                }
            }
            Rectangle{
                id: uptime_Area
                anchors{
                    top: cpu_Rate_Area.bottom; topMargin: 20
                    left: page0.left; leftMargin: 20
                    right: page0.right; rightMargin: 20
                }
                width: page0.width-40; height: page0.height/2-80
                color: "transparent"
                border.width: 10
                border.color: (theme.theme_bkg_color == "#1F1E58") ? "#2F2D84" : "#F0F0CD"
                radius: 20
                Text {
                    id: uptime_Text
                    anchors.centerIn: parent
                    font.pixelSize: theme.theme_font_size + 30
                    font.bold: true
                    color: theme.theme_font_color
                }
            }
        }
        Item{
            id: page1
            Text {
                text: "App"
                color: theme.theme_font_color
                font.pixelSize: theme.theme_font_size + 3
                font.bold: true
                anchors.bottom: calculator_app.top
                anchors.bottomMargin: 10
                anchors.left: calculator_app.left
            }
            Text {
                text: "Test"
                color: theme.theme_font_color
                font.pixelSize: theme.theme_font_size + 3
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
                    color: theme.theme_font_color
                    font.pixelSize: theme.theme_font_size
                    font.bold: true
                    anchors{
                        left: parent.left; leftMargin: 3
                        bottom: parent.bottom;
                    }

                }
                style:ButtonStyle{
                    background: Rectangle{
                        color: (theme.theme_bkg_color == "#1F1E58") ? "#2F2D84" : "#F0F0CD"
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
                    text: "BenchMark"
                    color: theme.theme_font_color
                    font.pixelSize: theme.theme_font_size
                    font.bold: true
                    anchors{
                        left: parent.left; leftMargin: 3
                        bottom: parent.bottom;
                    }
                }
                style: ButtonStyle{
                    background: Rectangle{
                        color: (theme.theme_bkg_color == "#1F1E58") ? "#2F2D84" : "#F0F0CD"
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
                    text: "video"
                    color: theme.theme_font_color
                    font.pixelSize: theme.theme_font_size
                    font.bold: true
                    anchors{
                        left: parent.left; leftMargin: 3
                        bottom: parent.bottom
                    }
                }
                style: ButtonStyle{
                    background: Rectangle{
                        color: (theme.theme_bkg_color == "#1F1E58") ? "#2F2D84" : "#F0F0CD"
                        border.color: "white"
                        border.width: control.hovered ? 1 : 0
                        radius: 10
                    }
                }
            }
            Button{
                id: album_app
                anchors{
                    top:video_app.bottom; topMargin: parent.height/30
                    left: calculator_app.left
                }
                width: parent.width/3 + parent.width/45
                height: parent.height/4
                onClicked: {mainSwipeView.setCurrentIndex(5)}
                Image {
                    anchors.centerIn: parent
                    width: album_app.width/5*3; height: album_app.height/5*4
                    source: "qrc:/desktop/icons/album.png"
                }
                Text {
                    text: "Album"
                    color: theme.theme_font_color
                    font.pixelSize: theme.theme_font_size
                    font.bold: true
                    anchors{
                        left: parent.left; leftMargin: 3
                        bottom: parent.bottom
                    }
                }
                style: ButtonStyle{
                    background: Rectangle{
                        color: (theme.theme_bkg_color == "#1F1E58") ? "#2F2D84" : "#F0F0CD"
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
                    text: "File"
                    color: theme.theme_font_color
                    font.pixelSize: theme.theme_font_size
                    font.bold: true
                    anchors{
                        left: parent.left; leftMargin: 3
                        bottom: parent.bottom;
                    }
                }
                style: ButtonStyle{
                    background: Rectangle{
                        color: (theme.theme_bkg_color == "#1F1E58") ? "#2F2D84" : "#F0F0CD"
                        border.color: "white"
                        border.width: control.hovered ? 1 : 0
                        radius: 10
                    }
                }
            }
        }
        Item{
            id: page2
            Text {
                anchors.bottom: settings_app.top
                anchors.bottomMargin: 10
                anchors.left: settings_app.left
                color: theme.theme_font_color
                font.pixelSize: theme.theme_font_size + 3
                font.bold: true
                text: "system"
            }
            Button{
                id: settings_app
                anchors{
                    top: parent.top; topMargin: parent.height/10
                    left: parent.left; leftMargin: parent.width/25
                }
                width: parent.width/6
                height: parent.height/4
                onClicked: {mainSwipeView.setCurrentIndex(6)}
                Image {
                    anchors.centerIn: parent
                    width: settings_app.width/5*4; height: settings_app.height/5*4
                    source: "qrc:/desktop/icons/settings.png"
                }
                Text {
                    text: "settings"
                    color: theme.theme_font_color
                    font.pixelSize: theme.theme_font_size
                    font.bold: true
                    anchors{
                        left: parent.left; leftMargin: 3
                        bottom: parent.bottom
                    }
                }
                style: ButtonStyle{
                    background: Rectangle{
                        color: (theme.theme_bkg_color == "#1F1E58") ? "#2F2D84" : "#F0F0CD"
                        border.color: "white"
                        border.width: control.hovered ? 1 : 0
                        radius: 10
                    }
                }
            }
            Button{
                id: system_app
                anchors{
                    top: settings_app.bottom; topMargin: parent.height/30
                    left: settings_app.left
                }
                width: parent.width/6
                height: parent.height/4
                onClicked: {mainSwipeView.setCurrentIndex(7)}
                Image {
                    anchors.centerIn: parent
                    width: video_app.width/5*4; height: video_app.height/5*4
                    source: "qrc:/desktop/icons/system.png"
                }
                Text {
                    text: "system"
                    color: theme.theme_font_color
                    font.pixelSize: theme.theme_font_size
                    font.bold: true
                    anchors{
                        left: parent.left; leftMargin: 3
                        bottom: parent.bottom
                    }
                }
                style: ButtonStyle{
                    background: Rectangle{
                        color: (theme.theme_bkg_color == "#1F1E58") ? "#2F2D84" : "#F0F0CD"
                        border.color: "white"
                        border.width: control.hovered ? 1 : 0
                        radius: 10
                    }
                }
            }
        }
    }

    PageIndicator {
        id: indicator
        anchors.bottom: desktop_view.bottom
        anchors.horizontalCenter: desktop_view.horizontalCenter
        count: desktop_view.count
        currentIndex: desktop_view.currentIndex
        delegate: Rectangle{
            implicitWidth: 8
            implicitHeight: 8
            radius: width / 2
            color: "#21BE2B"
            opacity: index === indicator.currentIndex ? 0.95 : pressed ? 0.7 : 0.45
            Behavior on opacity {
                OpacityAnimator{
                    duration: 1000
                }
            }
        }
    }
}
