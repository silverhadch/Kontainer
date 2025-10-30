/*
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

import QtQuick
import QtQuick.Controls as Controls
import QtQuick.Layouts
import org.kde.kirigami as Kirigami

Kirigami.AbstractCard {
    id: card

    property var container: ({})
    property bool fallbackToDistroColors: false

    signal installPackageRequested(string containerName, string containerImage)
    signal manageApplicationsRequested(string containerName)
    signal openTerminalRequested(string containerName)
    signal upgradeContainerRequested(string containerName)
    signal cloneContainerRequested(string containerName)
    signal removeContainerRequested(string containerName)

    contentItem: RowLayout {
        spacing: Kirigami.Units.smallSpacing

        ContainerBadge {
            fallbackToDistroColors: card.fallbackToDistroColors
            containerName: card.container.name || ""
            containerImage: card.container.image || ""
        }

        RowLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.margins: Kirigami.Units.smallSpacing

            ColumnLayout {
                spacing: Kirigami.Units.smallSpacing
                Layout.maximumWidth: implicitWidth

                Controls.Label {
                    text: card.container.name ? card.container.name.charAt(0).toUpperCase() + card.container.name.slice(1) : ""
                    elide: Text.ElideRight
                    Layout.fillWidth: true
                    font.pointSize: Kirigami.Theme.defaultFont.pointSize * 1.1
                    font.bold: true
                }

                Controls.Label {
                    text: card.container.image || ""
                    elide: Text.ElideRight
                    Layout.fillWidth: true
                    font.pointSize: Kirigami.Theme.smallFont.pointSize
                    opacity: 0.7
                }
            }

            ContainerActionsToolbar {
                containerName: card.container.name || ""
                containerImage: card.container.image || ""
                onInstallPackageRequested: card.installPackageRequested(containerName, containerImage)
                onManageApplicationsRequested: card.manageApplicationsRequested(containerName)
                onOpenTerminalRequested: card.openTerminalRequested(containerName)
                onUpgradeContainerRequested: card.upgradeContainerRequested(containerName)
                onCloneContainerRequested: card.cloneContainerRequested(containerName)
                onRemoveContainerRequested: card.removeContainerRequested(containerName)
            }
        }
    }
}
