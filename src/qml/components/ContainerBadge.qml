/*
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

import QtQuick
import QtQuick.Layouts
import org.kde.kirigami as Kirigami

Item {
    id: badge

    property bool fallbackToDistroColors: false
    property string containerName: ""
    property string containerImage: ""

    Layout.fillHeight: true
    implicitWidth: fallbackToDistroColors ? fallbackColorStrip.implicitWidth : iconContainer.implicitWidth
    implicitHeight: iconContainer.implicitHeight

    Rectangle {
        id: fallbackColorStrip
        visible: badge.fallbackToDistroColors
        width: Kirigami.Units.smallSpacing
        implicitWidth: width
        anchors.fill: parent
        color: distroBoxManager.getDistroColor(badge.containerImage)
        radius: 4
    }

    Rectangle {
        id: iconContainer
        visible: !badge.fallbackToDistroColors
        width: Kirigami.Units.iconSizes.medium + Kirigami.Units.smallSpacing * 2
        implicitWidth: width
        height: Kirigami.Units.iconSizes.medium + Kirigami.Units.smallSpacing * 2
        implicitHeight: height
        anchors.verticalCenter: parent.verticalCenter
        color: {
            const baseColor = distroBoxManager.getDistroColor(badge.containerImage);
            if (typeof baseColor === "string" && baseColor.startsWith("#")) {
                const hex = baseColor.slice(1);
                const alphaHex = Math.round(0.15 * 255).toString(16).padStart(2, "0");
                if (hex.length === 6) {
                    return "#" + alphaHex + hex;
                }
                if (hex.length === 8) {
                    return "#" + alphaHex + hex.slice(2);
                }
            }
            return Qt.rgba(0, 0, 0, 0.15);
        }
        radius: 4

        Kirigami.Icon {
            anchors.centerIn: parent
            source: distroBoxManager.getDistroIcon(badge.containerName)
            width: Kirigami.Units.iconSizes.medium
            height: Kirigami.Units.iconSizes.medium
        }
    }
}
