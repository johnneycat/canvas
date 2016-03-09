import QtQuick 2.0
import Ubuntu.Components 1.1

/*!
    \brief MainView with a Label and Button elements.
*/

MainView {
    // objectName for functional testing purposes (autopilot-qt5)
    objectName: "mainView"

    // Note! applicationName needs to match the "name" field of the click manifest
    applicationName: "canvas.liu-xiao-guo"

    /*
     This property enables the application to change orientation
     when the device is rotated. The default is false.
    */
    //automaticOrientation: true

    // Removes the old toolbar and enables new features of the new header.
    useDeprecatedToolbar: false

    width: units.gu(60)
    height: units.gu(85)

    Page {
        title: i18n.tr("canvas")

        Row {
            id: colorTools
            anchors {
                horizontalCenter: parent.horizontalCenter
                top: parent.top
                topMargin: 8
            }
            property color paintColor: "#33B5E5"
            spacing: 4
            Repeater {
                model: ["#33B5E5", "#99CC00", "#FFBB33", "#FF4444"]
                ColorSquare {
                    id: red
                    color: modelData
                    active: parent.paintColor == color
                    onClicked: {
                        parent.paintColor = color
                    }
                }
            }
        }
        // <<M1

        Rectangle {
            anchors.fill: canvas
            border.color: "#666666"
            border.width: 4
        }

        // M2>>
        Canvas {
            id: canvas
            anchors {
                left: parent.left
                right: parent.right
                top: colorTools.bottom
                bottom: parent.bottom
                margins: 8
            }
            property real lastX
            property real lastY
            property color color: colorTools.paintColor

            onPaint: {
                var ctx = getContext('2d')
                ctx.lineWidth = 5.0
                ctx.strokeStyle = canvas.color
                ctx.beginPath()
                ctx.moveTo(lastX, lastY)
                lastX = area.mouseX
                lastY = area.mouseY
                ctx.lineTo(lastX, lastY)
                ctx.stroke()
            }
            MouseArea {
                id: area
                anchors.fill: parent
                onPressed: {
                    canvas.lastX = mouseX
                    canvas.lastY = mouseY
                }
                onPositionChanged: {
                    canvas.requestPaint()
                }
            }

        }
    }
}
