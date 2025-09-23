/*
 *    SPDX-License-Identifier: GPL-3.0-or-later
 *    SPDX-FileCopyrightText: 2025 Hadi Chokr <hadichokr@icloud.com>
 */

#include "distroicons.h"

#include "distroboxcli.h"
#include <QDir>
#include <QSettings>
#include <QStandardPaths>

using namespace Qt::Literals::StringLiterals;

namespace DistroIcons
{
QString resolveDistroboxIcon(const QString container)
{
    bool isFlatpakRuntime = DistroboxCli::isFlatpak();
    QStringList searchPaths;

    if (isFlatpakRuntime) {
        // In Flatpak, search multiple possible locations for exported desktop files
        searchPaths = {QDir::homePath() + QStringLiteral("/.var/app/io.github.DenysMb.Kontainer/data/applications"),
                       QDir::homePath() + QStringLiteral("/.var/app/io.github.DenysMb.Kontainer/.local/share/applications"),
                       QStringLiteral("/var/lib/flatpak/exports/share/applications"),
                       QDir::homePath() + QStringLiteral("/.local/share/flatpak/exports/share/applications"),
                       QDir::homePath() + QStringLiteral("/.local/share/applications")};
    } else {
        searchPaths = {QStandardPaths::writableLocation(QStandardPaths::ApplicationsLocation)};
    }

    QStringList patterns;
    patterns << QStringLiteral("%1.desktop").arg(container);

    // Search in all possible paths
    for (const QString &searchPath : searchPaths) {
        QDir dir(searchPath);
        if (!dir.exists())
            continue;

        for (const QFileInfo &file : dir.entryInfoList(patterns, QDir::Files)) {
            if (!file.fileName().endsWith(QStringLiteral(".desktop")))
                continue;

            QSettings desktop(file.filePath(), QSettings::IniFormat);
            QString foundIcon = desktop.value(QStringLiteral("Desktop Entry/Icon"), QString()).toString();

            // Stop at first .desktop (even if no icon is set)
            if (!foundIcon.isEmpty())
                return foundIcon;
            else
                return QStringLiteral("preferences-virtualization-container");
        }
    }

    // Fallback if no .desktop file was found at all
    return QStringLiteral("preferences-virtualization-container");
}

}
