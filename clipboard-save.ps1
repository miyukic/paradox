#保存ファイル名
$SaveImgeFile = 'ImageFile.png'

if ((Get-Host).Version.Major -le 5) {   #WindowsPowerShell
    (Get-Clipboard -Format Image).Save($SaveImgeFile)

} elseif ((Get-Host).Version.Major -gt 6) {
    Add-Type -AssemblyName System.Windows.Forms
    $DesktopPath = [System.Environment]::GetFolderPath("Desktop")
    $clip = [Windows.Forms.Clipboard]::GetImage()
    if ($null -ne $clip) { $clip.Save($DesktopPath + '\' + $SaveImgeFile) }
}
