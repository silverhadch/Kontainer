#pragma once

#include <QObject>
#include <QString>
#include <QProcess>

class DistroboxManager : public QObject
{
    Q_OBJECT

public:
    explicit DistroboxManager(QObject *parent = nullptr);

public Q_SLOTS:
    QString listContainers();
    QString listAvailableImages();
    bool createContainer(const QString &name, const QString &image, const QString &args);
    bool enterContainer(const QString &name);
    bool removeContainer(const QString &name);
    bool upgradeContainer(const QString &name);
    QString getDistroColor(const QString &image);
    bool generateEntry(const QString &name = QString());
    bool installPackageInContainer(const QString &name, const QString &packagePath, const QString &image);

private:
    QStringList m_availableImages;
    QStringList m_fullImageNames;
    
    QString runCommand(const QString &command, bool &success) const;
    QStringList getAvailableImages() const;
    QStringList getFullImageNames() const;
};