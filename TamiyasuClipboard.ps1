#TamiyasuClipboard 1.0
#クリップボードに変更があった時、そのテキストを 民安★TALK で読み上げます
#民安★TALK のプログラムを設置したフォルダにこのスクリプトも配置してください

#ショートカット作成
#作業フォルダは下記に設定
#C:\Windows\System32\WindowsPowerShell\v1.0
#リンク先はpowershell <本スクリプトの場所>


### 環境設定

#クリップボードを確認する間隔（秒）
$INTERVAL = 3

### 環境設定ここまで


$path = (Split-Path $MyInvocation.MyCommand.Path -parent) 
#民安★TALK のパス
$TAMIYASU_PATH = $path + "\vrx.exe"

[bool]$IsSpeak=$true

Add-Type -AssemblyName system.Windows.Forms
$cp = [Windows.Forms.Clipboard]

#コマンドラインオプションを使用するために一旦エイリアスにする
set-alias tamiyasu $TAMIYASU_PATH

$counter = 0;
echo "while外"
while ($true) {
    $counter++
    #echo $counter

    if ($cp::ContainsText()) {
        #ClipBoardから取得
        $text = $cp::GetText() 

        if (($oldText -ne $text) -and $IsSpeak) {
            echo "IsSpeak + ${text}"
            tamiyasu $text
            
            $oldText = $text;
        }
    }

    if ([Console]::KeyAvailable) {
        echo "[Console]::KeyAvailable"
        $keyinfo = [Console]::ReadKey($true);
        if ($keyinfo.Key -eq "Enter") {
            if ($IsSpeak) {
                [bool]$IsSpeak = $false;
                echo 読み上げません。
            } else {
                [bool]$IsSpeak = $true;
                echo 読み上げます。
            }
        }
    }
    
    # 一定時間待つ（秒）
    Sleep -s $INTERVAL
    
}
