#保存ファイル名
$SaveImgeFile = 'ImageFile.png'
$CurrentDir = Convert-Path .
$DesktopPath = [System.Environment]::GetFolderPath("Desktop")
if ($CurrentDir -match "^C:\\Program[ \t]Files\\PowerShell\\[0-9]+") {
    $CurrentDir = $DesktopPath
}

if ((Get-Host).Version.Major -le 5) {   #WindowsPowerShell
        (Get-Clipboard -Format Image).Save($CurrentDir + "\" + $SaveImgeFile)
    echo ($SaveImgeFile + " 名で保存されました。\n" + "Windows PowerShell")
} elseif ((Get-Host).Version.Major -le 7) {
    Add-Type -AssemblyName System.Windows.Forms
    $clip = [Windows.Forms.Clipboard]::GetImage()
    if ($null -ne $clip) {
        $clip.Save($CurrentDir + "\" + $SaveImgeFile)
    }
}
#pause
