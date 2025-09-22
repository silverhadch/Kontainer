/*
    SPDX-License-Identifier: GPL-3.0-or-later
    SPDX-FileCopyrightText: 2025 Denys Madureira <denysmb@zoho.com>
*/

import QtQuick
import QtQuick.Layouts
import QtQuick.Controls as Controls

import org.kde.kirigami as Kirigami

Kirigami.Dialog {
    id: cloneDialog
    title: i18n("Clone container")
    padding: Kirigami.Units.largeSpacing
    standardButtons: Kirigami.Dialog.Ok | Kirigami.Dialog.Cancel

    property var containersList: []
    property string selectedContainer: ""
    property bool nameManuallyEdited: false
    property string errorMessage: ""

    function defaultCloneName(sourceName) {
        if (!sourceName) {
            return "";
        }
        return sourceName + "-clone";
    }

    function openWithContainer(containerName) {
        if (!containersList || containersList.length === 0) {
            errorMessage = i18n("No containers available to clone.");
            return;
        }

        var index = 0;
        if (containerName && containerName.length > 0) {
            for (var i = 0; i < containersList.length; ++i) {
                if (containersList[i].name === containerName) {
                    index = i;
                    break;
                }
            }
        }

        containerCombo.currentIndex = index;
        selectedContainer = containersList[index].name;
        nameManuallyEdited = false;
        nameField.text = defaultCloneName(selectedContainer);
        errorMessage = "";
        open();
        nameField.forceActiveFocus();
        nameField.selectAll();
    }

    onRejected: {
        close();
    }

    onAccepted: {
        if (!selectedContainer || selectedContainer.length === 0) {
            errorMessage = i18n("Select a container to clone.");
            return;
        }

        var cloneName = nameField.text.trim();
        if (!cloneName) {
            errorMessage = i18n("Choose a name for the cloned container.");
            return;
        }

        var launched = distroBoxManager.cloneContainer(selectedContainer, cloneName);
        if (!launched) {
            errorMessage = i18n("Failed to launch clone command. Check your setup and try again.");
            return;
        }

        close();
    }

    ColumnLayout {
        spacing: Kirigami.Units.largeSpacing

        Kirigami.FormLayout {
            Layout.fillWidth: true

            Controls.ComboBox {
                id: containerCombo
                Kirigami.FormData.label: i18n("Container")
                model: cloneDialog.containersList
                textRole: "name"
                Layout.fillWidth: true

                onCurrentIndexChanged: {
                    if (currentIndex < 0 || currentIndex >= cloneDialog.containersList.length) {
                        return;
                    }
                    selectedContainer = cloneDialog.containersList[currentIndex].name;
                    if (!nameManuallyEdited) {
                        nameField.text = defaultCloneName(selectedContainer);
                    }
                }
            }

            Controls.TextField {
                id: nameField
                Kirigami.FormData.label: i18n("Name")
                placeholderText: i18n("fedora-clone")
                Layout.fillWidth: true

                onTextEdited: {
                    nameManuallyEdited = true;
                }
            }
        }

        Kirigami.InlineMessage {
            Layout.fillWidth: true
            visible: errorMessage.length > 0
            text: errorMessage
            type: Kirigami.MessageType.Error
        }
    }
}
