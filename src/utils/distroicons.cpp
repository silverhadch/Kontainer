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

    // 1. Try to resolve from .desktop file
    for (const QString &searchPath : searchPaths) {
        QDir dir(searchPath);
        if (!dir.exists())
            continue;

        for (const QFileInfo &file : dir.entryInfoList(patterns, QDir::Files)) {
            if (!file.fileName().endsWith(QStringLiteral(".desktop")))
                continue;

            QSettings desktop(file.filePath(), QSettings::IniFormat);
            QString foundIcon = desktop.value(QStringLiteral("Desktop Entry/Icon"), QString()).toString();

            if (!foundIcon.isEmpty())
                return foundIcon;
        }
    }

    // 2. Fallback to distrobox terminal icon
    QString customIconPath = QDir::homePath() + QStringLiteral("/.local/share/icons/distrobox/terminal-distrobox-icon.svg");
    if (QFile::exists(customIconPath)) {
        return customIconPath;
    }

    // 3. Super final fallback
    return QStringLiteral("preferences-virtualization-container");
}
}
