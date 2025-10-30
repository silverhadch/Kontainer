/*
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

import QtQuick
import QtQuick.Controls as Controls
import QtQuick.Layouts
import org.kde.kirigami as Kirigami

Kirigami.ActionToolBar {
    id: toolbar

    property string containerName: ""
    property string containerImage: ""

    signal installPackageRequested(string containerName, string containerImage)
    signal manageApplicationsRequested(string containerName)
    signal openTerminalRequested(string containerName)
    signal upgradeContainerRequested(string containerName)
    signal cloneContainerRequested(string containerName)
    signal removeContainerRequested(string containerName)

    Layout.fillWidth: true
    Layout.fillHeight: true
    spacing: Kirigami.Units.smallSpacing
    alignment: Qt.AlignRight
    display: Controls.Button.IconOnly
    flat: false

    actions: [
        Kirigami.Action {
            icon.name: "package-x-generic"
            text: i18n("Install Package")
            onTriggered: toolbar.installPackageRequested(toolbar.containerName, toolbar.containerImage)
        },
        Kirigami.Action {
            icon.name: "applications-all-symbolic"
            text: i18n("Manage Applications")
            onTriggered: toolbar.manageApplicationsRequested(toolbar.containerName)
        },
        Kirigami.Action {
            icon.name: "utilities-terminal-symbolic"
            text: i18n("Open Terminal")
            onTriggered: toolbar.openTerminalRequested(toolbar.containerName)
        },
        Kirigami.Action {
            text: i18n("More options")
            icon.name: "view-more-symbolic"
            Kirigami.Action {
                icon.name: "system-software-update"
                text: i18n("Upgrade Container")
                onTriggered: toolbar.upgradeContainerRequested(toolbar.containerName)
            }
            Kirigami.Action {
                icon.name: "edit-copy"
                text: i18n("Clone Container")
                onTriggered: toolbar.cloneContainerRequested(toolbar.containerName)
            }
            Kirigami.Action {
                icon.name: "delete"
                text: i18n("Remove Container")
                onTriggered: toolbar.removeContainerRequested(toolbar.containerName)
            }
        }
    ]
}
