Set-StrictMode -Version Latest

#コマンド存在チェック
#true or falseで返る
function IsExistCommand([string]$command) {
    Get-Command $command SilentlyContinue | Out-Null
    return $?
}
