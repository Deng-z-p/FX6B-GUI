import QtQuick 2.12

Item {
    visible: false
    Rectangle{
        id: coverflow
        anchors.fill: parent

        color: "black"
        property ListModel model
        property int itemCount: 3
        PathView{
            id: pathview
            anchors.fill: parent
            path: coverFlowPath
            pathItemCount: coverflow.itemCount
            preferredHighlightBegin: 0.5
            preferredHighlightEnd: 0.5
            model: myAlbum /*Reference to a C++ object registered in the context*/
            delegate: Item{
                id: delegateItem
                width: parent.width/5*4
                height: parent.height/5*4
                z: PathView.iconZ
                scale: PathView.iconScale
                Image {
                    id: image
                    anchors.fill: parent
                    fillMode: Image.PreserveAspectFit
                    opacity: pathview.currentIndex == index ? 1 : 0.5
                    enabled: pathview.currentIndex == index ? true : false
                    source: path
                    /*A reimplementation of the 'roleNames' function from the 'album' object*/
                    MouseArea{
                        anchors.fill: image
                        //onPressAndHold: drag.target = image
                        onWheel: {
                            var datla = wheel.angleDelta.y/120
                            if(datla > 0){
                                image.scale = image.scale/0.9
                            }
                            else{
                                image.scale = image.scale*0.9
                            }
                        }
                    }
                }
            }
        }
        Path{
            id:coverFlowPath
            startX: 0
            startY: 0

            PathAttribute{name:"iconZ";value: 0}
            PathAttribute{name:"iconAngle";value: 70}
            PathAttribute{name:"iconScale";value: 0.1}
            PathLine{x:coverflow.width/2;y:coverflow.height/2}

            PathAttribute{name:"iconZ";value: 100}
            PathAttribute{name:"iconAngle";value: 0}
            PathAttribute{name:"iconScale";value: 1.0}

            PathLine{x:coverflow.width;y:coverflow.height}
            PathAttribute{name:"iconZ";value: 0}
            PathAttribute{name:"iconAngle";value: -70}
            PathAttribute{name:"iconScale";value: 0.1}
            PathPercent{value:1}
        }
    }
}
