# Run on Host after testing the VMConnect launcher.
$ErrorActionPreference = 'Stop'
$script = 'C:\VMConnect-RelativeMouse.ps1'
if (-not (Test-Path -LiteralPath $script)) { throw "Missing launcher: $script" }
$desktop = [Environment]::GetFolderPath('Desktop')
$path = Join-Path $desktop 'G2-RelativeMouse.lnk'
$shell = New-Object -ComObject WScript.Shell
$link = $shell.CreateShortcut($path)
$link.TargetPath = "$env:windir\System32\WindowsPowerShell\v1.0\powershell.exe"
$link.Arguments = '-NoProfile -STA -NoExit -ExecutionPolicy Bypass -File "C:\VMConnect-RelativeMouse.ps1"'
$link.WorkingDirectory = 'C:\'
$link.IconLocation = "$env:windir\System32\vmconnect.exe,0"
$link.Save()
Write-Host "Created: $path"