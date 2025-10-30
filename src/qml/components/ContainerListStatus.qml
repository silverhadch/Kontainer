/*
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

import QtQuick
import QtQuick.Controls as Controls
import org.kde.kirigami as Kirigami

Item {
    id: status

    property bool isEmpty: true
    property bool isRefreshing: false

    signal createRequested()

    anchors.fill: parent

    Kirigami.PlaceholderMessage {
        anchors.centerIn: parent
        visible: status.isEmpty && !status.isRefreshing
        text: i18n("No containers found. Create a new container now?")
        helpfulAction: Kirigami.Action {
            text: i18n("Create Container")
            icon.name: "list-add"
            onTriggered: status.createRequested()
        }
    }

    Controls.BusyIndicator {
        anchors.centerIn: parent
        visible: status.isEmpty && status.isRefreshing && !loadingTimer.running
    }

    Timer {
        id: loadingTimer
        interval: 100
        repeat: false
    }

    Component.onCompleted: loadingTimer.start()
}
