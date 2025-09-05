import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
    id: root
    property var words: []

    Column {
        spacing: 8
        Repeater {
            model: Math.ceil(words.length / 3)
            Row {
                spacing: 16
                Repeater {
                    model: 3
                    Item {
                        width: 160; height: 36
                        property int idx: (index + (parent.parent.index * 3))
                        visible: idx < words.length
                        Rectangle {
                            anchors.fill: parent
                            radius: 6
                            border.width: 1
                            color: "#1e1e1e"
                            border.color: "#3a3a3a"
                        }
                        Text {
                            anchors.centerIn: parent
                            text: (idx+1) + ".  " + words[idx]
                            color: "#eaeaea"
                            font.pixelSize: 14
                        }
                    }
                }
            }
        }
    }
}