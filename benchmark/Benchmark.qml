import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
import Package.benchmark 1.0

Item {
    id: benmarkItem
    Benchmark {
        id: benchmark
        onBenchmark_resulttext_Changed:{
            benmarkText.append(benchmark_resulttext)
            /*move cursor position to the end, Make sure that the following information will be disaplay*/
            benmarkText.moveCursorSelection(benmarkText.cursorPosition)
        }
        onBenchmark_test_finised: {
            control_btn.text = "Start"
        }
    }
    Rectangle {
        id: choice_Area
        width: 200; height: parent.height
        color: "#1f1e58"
        ButtonGroup {id: radioGroup}
        /*Add all RadioButton to one ButtonGroup,
        for easy to management and to get the text which cheched one*/
        ColumnLayout {
            anchors.fill: parent
            RadioButton {
                id: coremark
                text: "coremark"
                checked: true
                contentItem: Text {
                    text: coremark.text
                    color: "red"
                    leftPadding: coremark.indicator.width + coremark.spacing
                }
                ButtonGroup.group: radioGroup
            }
            RadioButton {
                id: dhrystone
                text: "dhrystone"
                contentItem: Text {
                    text: dhrystone.text
                    color: "red"
                    leftPadding: dhrystone.indicator.width + dhrystone.spacing
                }
                ButtonGroup.group: radioGroup
            }
            RadioButton {
                id: stream
                text: "stream"
                contentItem: Text {
                    text: stream.text
                    color: "red"
                    leftPadding: stream.indicator.width + stream.spacing
                }
                ButtonGroup.group: radioGroup
            }
            RadioButton {
                id: whetstone
                text: "whetstone"
                contentItem: Text {
                    text: whetstone.text
                    color: "red"
                    leftPadding: whetstone.indicator.width + whetstone.spacing
                }
                ButtonGroup.group: radioGroup
            }
            Button {
                id: control_btn
                text: "Start"
                Layout.alignment: Qt.AlignCenter
                onClicked: {
                    fun_Item.btn_start()
                }
                background: Rectangle{
                    implicitWidth: 150; implicitHeight: 40
                    radius: 10
                    border.width: control_btn.hovered ? 1 : 0
                }
            }
        }
    }
    Rectangle {
        id: text_Area
        width: parent.width - choice_Area.width; height: parent.height
        anchors.right: parent.right
        color: "darkslategray"
        Flickable {
            id: flick
            width: parent.width; height: parent.height
            contentWidth: parent.width; contentHeight: benmarkText.height
            anchors.right: parent.right
            clip: true
            function ensureVisible(r)
            {
                if (contentX >= r.x)
                  contentX = r.x;
                else if (contentX+width <= r.x+r.width)
                  contentX = r.x+r.width-width;
                if (contentY >= r.y)
                  contentY = r.y;
                else if (contentY+height <= r.y+r.height)
                  contentY = r.y+r.height-height;
            }
            TextEdit {
              id: benmarkText
              width: text_Area.width
              focus: true
              readOnly: true
              onCursorRectangleChanged: {
                  flick.ensureVisible(cursorRectangle)
              }
            }
            ScrollBar.vertical: ScrollBar {
                anchors.right: parent.right
                hoverEnabled: true
            }
        }
    }
    Item {
        id: fun_Item
        function choice_test()
        {
            return radioGroup.checkedButton.text
        }
        function btn_start()
        {
            if(control_btn.text == 'Start'){
                var arguments
                switch (radioGroup.checkedButton.text){
                    case("coremark"):
                        break
                    case("dhrystone"):
                        arguments="10000000"
                        break
                    case("stream"):
                        break
                    case("whetstone"):
                        arguments="500000"
                        break
                }
                benmarkText.clear()
                control_btn.text = "Stop"
                benchmark.benchmark_test_start(fun_Item.choice_test(), arguments)
            }else if(control_btn.text == 'Stop'){
                control_btn.text = 'Start'
                benchmark.benchmark_test_stop()
            }
        }
    }
}
