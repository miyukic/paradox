#保存ファイル名
[string]$SaveImageFile = 'ImageFile.png'
[string]$CurrentDir = Convert-Path .
[string]$DesktopPath = [System.Environment]::GetFolderPath("Desktop")

if ($CurrentDir -match "^C:\\Program[ \t]Files\\PowerShell\\[0-9]+") {
    $CurrentDir = $DesktopPath
}

function SaveImage([string]$path, [string]$fileName) {
    if ((Get-Host).Version.Major -le 5) {   #WindowsPowerShell
            (Get-Clipboard -Format Image).Save($path + "\" + $fileName)
        Write-Output ($fileName + " 名で保存されました。\n" + "Windows PowerShell")
    } elseif ((Get-Host).Version.Major -le 7) {
        Add-Type -AssemblyName System.Windows.Forms
        $clip = [Windows.Forms.Clipboard]::GetImage()
        if ($null -ne $clip) {
            $clip.Save($path + "\" + $fileName)
        }
    }
}

#function NextFileName([string]$fileName, ) {
#    $args+
#}

# ファイル名が存在するならサフィックスを2番からつけて作成可能なファイル名を返す
function GetCreatableFileName([string]$Path, [string]$fileName, [int]$suffix) {
    $result = $fileName + "-" + $suffix
    Write-Host $result
    $filePathName = $Path + "\" + $result
    if($suffix -eq 1) {
        return $result
    }
    if (Test-Path $filePathName) {
        return GetCreatableFileName($Path, $fileNmae, ++$suffix)
    } else {
        return $result
    }
}


#Test-Path($CurrentDir+"\"+$SaveImageFile | % { Write-Host $_ }


$re = GetCreatableFileName($CurrentDir, $SaveImageFile, 1)
Write-Host $re
SaveImage($CurrentDir, $re)

pause
