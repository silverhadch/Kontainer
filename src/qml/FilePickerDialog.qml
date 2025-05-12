import QtQuick
import QtQuick.Dialogs

FileDialog {
    id: packageFileDialog
    title: i18n("Choose Package File")
    nameFilters: ["Package files (*.deb *.rpm *.pkg.tar.zst *.apk *.xbps)"]
    
    property string containerName
    property string containerImage
    
    onAccepted: {
        distroBoxManager.installPackageInContainer(containerName, selectedFile, containerImage)
    }
}
