cmake_minimum_required(VERSION 3.20)
project(kontainer)

find_package(ECM 6.0.0 REQUIRED NO_MODULE)
set(CMAKE_MODULE_PATH ${ECM_MODULE_PATH})

include(KDEInstallDirs)
include(KDECMakeSettings)
include(KDECompilerSettings NO_POLICY_SCOPE)
include(ECMFindQmlModule)
include(ECMQmlModule)

find_package(Qt6 REQUIRED COMPONENTS
    Core
    Quick
    Test
    Gui
    QuickControls2
    Widgets
)

find_package(KF6 REQUIRED COMPONENTS
    Kirigami
    I18n
    CoreAddons
    QQC2DesktopStyle
    IconThemes
)

ecm_find_qmlmodule(org.kde.kirigami REQUIRED)

add_subdirectory(src)

# Install desktop file
install(PROGRAMS io.github.DenysMb.Kontainer.desktop DESTINATION ${KDE_INSTALL_APPDIR})

# Install metainfo file
install(FILES io.github.DenysMb.Kontainer.metainfo.xml DESTINATION ${KDE_INSTALL_METAINFODIR})

# Install icon
install(FILES src/assets/io.github.DenysMb.Kontainer.svg DESTINATION ${KDE_INSTALL_ICONDIR}/hicolor/scalable/apps)

feature_summary(WHAT ALL INCLUDE_QUIET_PACKAGES FATAL_ON_MISSING_REQUIRED_PACKAGES)
