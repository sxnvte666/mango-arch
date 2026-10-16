//@ pragma UseQApplication
//@ pragma NativeTextRendering
// Port of ~/mango-arch/config/waybar (workspaces | clock | volume | tray)
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import Quickshell.Services.Pipewire
import Quickshell.Services.SystemTray

ShellRoot {
    id: root

    readonly property color bg: "#15170F"
    readonly property color fg: "#E5E9D8"
    readonly property color dim: "#959999"
    readonly property color accent: "#9FD88A"
    readonly property color sepColor: "#A3B08F"
    readonly property string fontFamily: "Terminess Nerd Font"

    // monitor name -> tags array, fed by mango's IPC stream
    property var tagsByMonitor: ({})

    Process {
        running: true
        command: ["mmsg", "watch", "all-tags"]
        stdout: SplitParser {
            onRead: line => {
                try {
                    const m = {};
                    for (const mon of JSON.parse(line).all_tags) m[mon.monitor] = mon.tags;
                    root.tagsByMonitor = m;
                } catch (e) {
                    console.warn("mmsg: bad line", line);
                }
            }
        }
    }

    function run(cmd) {
        Quickshell.execDetached(cmd);
    }

    readonly property PwNode sink: Pipewire.defaultAudioSink
    PwObjectTracker { objects: [root.sink] }

    SystemClock { id: clock; precision: SystemClock.Minutes }

    Variants {
        model: Quickshell.screens

        PanelWindow {
            id: bar
            required property ShellScreen modelData
            screen: modelData
            anchors { top: true; left: true; right: true }
            implicitHeight: 26
            color: root.bg

            // left: tags
            Row {
                anchors { left: parent.left; top: parent.top; bottom: parent.bottom }
                Repeater {
                    model: root.tagsByMonitor[modelData.name] ?? []
                    Text {
                        required property var modelData
                        height: parent.height
                        leftPadding: 11; rightPadding: 11
                        verticalAlignment: Text.AlignVCenter
                        text: modelData.index
                        font { family: root.fontFamily; pixelSize: 14; hintingPreference: Font.PreferFullHinting }
                        antialiasing: false
                        color: tagMouse.containsMouse || modelData.is_active ? root.accent : root.dim
                        MouseArea {
                            id: tagMouse
                            anchors.fill: parent
                            hoverEnabled: true
                            acceptedButtons: Qt.LeftButton | Qt.RightButton
                            // shortcut: dispatches to the focused monitor, add focusmon first if you go multi-monitor
                            onClicked: e => root.run(["mmsg", "dispatch",
                                (e.button === Qt.RightButton ? "toggleview," : "view,") + parent.modelData.index + (e.button === Qt.RightButton ? "" : ",0")])
                        }
                    }
                }
            }

            // center: clock, left click toggles long format, right click toggles calendar
            Text {
                id: clockText
                property bool alt: false
                anchors.centerIn: parent
                text: Qt.formatDateTime(clock.date, alt ? "ddd, dd. MMM  HH:mm" : "HH:mm")
                font { family: root.fontFamily; pixelSize: 14; hintingPreference: Font.PreferFullHinting }
                antialiasing: false
                color: root.fg
                MouseArea {
                    anchors.fill: parent
                    acceptedButtons: Qt.LeftButton | Qt.RightButton
                    onClicked: e => e.button === Qt.RightButton ? calendar.visible = !calendar.visible : clockText.alt = !clockText.alt
                }
            }

            PopupWindow {
                id: calendar
                // month shown; resets to today each time it opens
                property date month: clock.date
                onVisibleChanged: if (visible) month = clock.date
                anchor.window: bar
                anchor.rect.x: bar.width / 2 - width / 2
                anchor.rect.y: bar.height
                implicitWidth: 230
                implicitHeight: calCol.implicitHeight + 16
                color: root.bg

                Column {
                    id: calCol
                    anchors { fill: parent; margins: 8 }
                    spacing: 4

                    Text {
                        width: parent.width
                        horizontalAlignment: Text.AlignHCenter
                        text: Qt.formatDate(calendar.month, "MMMM yyyy")
                        font { family: root.fontFamily; pixelSize: 14; hintingPreference: Font.PreferFullHinting }
                        antialiasing: false
                        color: root.accent
                    }
                    DayOfWeekRow {
                        width: parent.width
                        delegate: Text {
                            required property string shortName
                            horizontalAlignment: Text.AlignHCenter
                            text: shortName.slice(0, 2)
                            font { family: root.fontFamily; pixelSize: 14; hintingPreference: Font.PreferFullHinting }
                            antialiasing: false
                            color: root.sepColor
                        }
                    }
                    MonthGrid {
                        width: parent.width
                        month: calendar.month.getMonth()
                        year: calendar.month.getFullYear()
                        delegate: Text {
                            required property var model
                            horizontalAlignment: Text.AlignHCenter
                            text: model.day
                            font { family: root.fontFamily; pixelSize: 14; hintingPreference: Font.PreferFullHinting }
                            antialiasing: false
                            color: model.today ? root.accent : model.month === calendar.month.getMonth() ? root.fg : root.dim
                        }
                    }
                }

                // scroll changes month
                MouseArea {
                    anchors.fill: parent
                    onWheel: w => calendar.month = new Date(calendar.month.getFullYear(), calendar.month.getMonth() + (w.angleDelta.y > 0 ? -1 : 1), 1)
                }
            }

            // right: volume | tray
            RowLayout {
                anchors { right: parent.right; top: parent.top; bottom: parent.bottom }
                spacing: 0

                Text {
                    readonly property var audio: root.sink?.audio
                    text: !audio ? "" : audio.muted ? "muted "
                        : Math.round(audio.volume * 100) + "% " + (root.sink.name.startsWith("bluez") ? "bvol " : "vol ")
                    font { family: root.fontFamily; pixelSize: 14; hintingPreference: Font.PreferFullHinting }
                    antialiasing: false
                    color: root.fg
                    MouseArea {
                        anchors.fill: parent
                        acceptedButtons: Qt.LeftButton | Qt.RightButton
                        onClicked: e => e.button === Qt.RightButton
                            ? (parent.audio.muted = !parent.audio.muted)
                            : root.run(["kitty", "--class", "wiremix", "wiremix"])
                        onWheel: w => {
                            const a = parent.audio;
                            if (a) a.volume = Math.max(0, Math.min(1, a.volume + (w.angleDelta.y > 0 ? 0.01 : -0.01)));
                        }
                    }
                }

                Text {
                    text: "| "
                    font { family: root.fontFamily; pixelSize: 14; hintingPreference: Font.PreferFullHinting }
                    antialiasing: false
                    color: root.sepColor
                }

                Repeater {
                    model: SystemTray.items
                    MouseArea {
                        id: trayItem
                        required property SystemTrayItem modelData
                        Layout.preferredWidth: 21
                        Layout.preferredHeight: 21
                        Layout.rightMargin: 2
                        acceptedButtons: Qt.LeftButton | Qt.RightButton | Qt.MiddleButton
                        onClicked: e => {
                            if (e.button === Qt.MiddleButton) modelData.secondaryActivate();
                            else if (e.button === Qt.RightButton || modelData.onlyMenu) {
                                if (modelData.hasMenu) {
                                    const p = mapToItem(null, 0, height);
                                    modelData.display(QsWindow.window, p.x, p.y);
                                }
                            } else modelData.activate();
                        }
                        onWheel: w => modelData.scroll(w.angleDelta.y / 120, false)
                        Image {
                            anchors.fill: parent
                            source: trayItem.modelData.icon
                            sourceSize: Qt.size(21, 21)
                        }
                    }
                }
            }
        }
    }
}
