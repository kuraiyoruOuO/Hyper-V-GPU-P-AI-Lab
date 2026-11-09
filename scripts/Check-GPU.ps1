# Read-only diagnostics; run inside Hyper-V Guest.
Get-CimInstance Win32_VideoController | Select-Object Name,DriverVersion,Status
Get-PnpDevice -Class Display | Select-Object FriendlyName,Status,InstanceId
'C:\Windows\System32\nvcuda.dll','C:\Windows\System32\nvml.dll','C:\Windows\System32\nvidia-smi.exe' | ForEach-Object {
    [pscustomobject]@{ File = $_; Exists = Test-Path -LiteralPath $_ }
}