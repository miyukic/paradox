Set-StrictMode -Version Latest

#基本保存ファイル名
[string]$BaseFileName = 'ImageFile'
#保存ファイルの拡張子
[string]$filetype = "png"
#ショートカットから起動するなら作業フォルダーの位置になる
[string]$CurrentDir = Convert-Path .
[string]$DesktopPath = [System.Environment]::GetFolderPath("Desktop")

if ($CurrentDir -match "^C:\\Program[ \t]Files\\PowerShell\\[0-9]+") {
    $CurrentDir = $DesktopPath
}

function Hoge([int]$f) {
    if ($f -eq 1) {
        return 1
    }
    Write-Host($f)
    return Hoge($f - 1)
}

function SaveImage([string]$path, [string]$fileName) {
    if ((Get-Host).Version.Major -le 5) {   #WindowsPowerShell
            (Get-Clipboard -Format Image).Save($path + "\" + $fileName)
        Write-Output ($fileName + " 名で保存されました。\n" + "Windows PowerShell")
    } elseif ((Get-Host).Version.Major -le 7) {
        Add-Type -AssemblyName System.Windows.Forms
        $clip = [Windows.Forms.Clipboard]::GetImage()
        if ($null -ne $clip) {
            $clip.Save($path+"\"+$fileName)
        }
    }
}

#function NextFileName([string]$fileName, ) {
#    $args+
#}

# ファイル名が存在するならサフィックスを2番からつけて作成可能なファイル名を返す
function GetCreatableFileName {
    param([string]$Path, [string]$fileName, [int]$suffix)
    Write-Host("Path=" + $Path)
    $result = $fileName + "-" + $suffix
    Write-Host("result=" + $result)
    $filePathName = $Path + "\" + $result
    if (Test-Path($filePathName+"."+$filetype)) {
        return GetCreatableFileName $Path $fileName ($suffix+1)
    } else {
        return $result
    }
}


#Test-Path($CurrentDir+"\"+$BaseFileName | % { Write-Host $_ }
#Hoge($CurrentDir)
#Write-Host($CurrentDir.GetType())

$storeFileName = GetCreatableFileName $CurrentDir $BaseFileName 1
Write-Host("re=" + $storeFileName)
SaveImage $CurrentDir ($storeFileName+"."+$filetype)
#pause
