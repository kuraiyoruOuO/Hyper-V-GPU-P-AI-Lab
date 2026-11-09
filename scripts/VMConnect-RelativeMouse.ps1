# EXPERIMENTAL: Host VMConnect relative-mouse launcher.
# Uses undocumented internals; may break on Windows updates.
$ErrorActionPreference = 'Stop'
if ([Threading.Thread]::CurrentThread.ApartmentState -ne 'STA') {
    Start-Process powershell.exe -ArgumentList @('-NoProfile','-STA','-NoExit','-ExecutionPolicy','Bypass','-File',('"' + $PSCommandPath + '"'))
    exit
}
$vmName = '新增虛擬機器-G2'
$vm = Get-VM -Name $vmName -ErrorAction Stop
if ($vm.State -ne 'Running') { Start-VM -Name $vmName -ErrorAction Stop }
$vmId = $vm.Id.ToString()
$vmconnectPath = Join-Path $env:windir 'System32\vmconnect.exe'
if (-not (Test-Path -LiteralPath $vmconnectPath)) { throw "VMConnect not found: $vmconnectPath" }
$assembly = [Reflection.Assembly]::LoadFrom($vmconnectPath)
try { $types = $assembly.GetTypes() } catch [Reflection.ReflectionTypeLoadException] { $types = $_.Exception.Types | Where-Object { $_ } }
$formType = $types | Where-Object FullName -eq 'Microsoft.Virtualization.Client.InteractiveSession.InteractiveSessionForm' | Select-Object -First 1
$viewerType = $types | Where-Object FullName -eq 'Microsoft.Virtualization.Client.InteractiveSession.RdpViewerControl' | Select-Object -First 1
$appType = $types | Where-Object FullName -eq 'Microsoft.Virtualization.Client.InteractiveSession.VmisApplicationContext' | Select-Object -First 1
if (-not ($formType -and $viewerType -and $appType)) { throw 'VMConnect internal types unavailable on this Windows build.' }
$flags = [Reflection.BindingFlags]'Instance,Public,NonPublic'
$parse = $appType.GetMethod('TryParseCommandLine',$flags)
$viewerField = $formType.GetField('m_RdpViewer',$flags)
$clientField = $viewerType.GetField('m_RdpClient',$flags)
if (-not ($parse -and $viewerField -and $clientField)) { throw 'VMConnect internal members unavailable.' }
$ctor = $appType.GetConstructors($flags) | Select-Object -First 1
$context = $ctor.Invoke([object[]]@())
$argsForVmc = [string[]]@('localhost','/g',$vmId)
$ok = $parse.Invoke($context,[object[]]@($argsForVmc))
if (-not $ok) { throw 'VMConnect argument parser rejected the VM ID.' }
$form = $context.MainForm
$viewer = $viewerField.GetValue($form)
$rdp = $clientField.GetValue($viewer)
$ocx = $rdp.GetOcx()
$interface = $null
foreach ($a in [AppDomain]::CurrentDomain.GetAssemblies()) {
    $t = $a.GetType('Microsoft.Virtualization.Client.Interop.IMsRdpExtendedSettings',$false)
    if ($t) { $interface = $t; break }
}
if (-not $interface) { throw 'IMsRdpExtendedSettings type unavailable.' }
$property = $interface.GetProperty('Property')
$guid = [guid]'302d8188-0052-4807-806a-362b628f9ac5'
$unknown = [Runtime.InteropServices.Marshal]::GetIUnknownForObject($ocx)
$ptr = [IntPtr]::Zero
try {
    $hr = [Runtime.InteropServices.Marshal]::QueryInterface($unknown,[ref]$guid,[ref]$ptr)
    if ($hr -ne 0 -or $ptr -eq [IntPtr]::Zero) { throw "Extended settings QueryInterface failed: $hr" }
    $ext = [Runtime.InteropServices.Marshal]::GetObjectForIUnknown($ptr)
    $rdp.AdvancedSettings7.RelativeMouseMode = $true
    $property.SetValue($ext,$true,[object[]]@('AllowRelativeMouseMode'))
    Write-Host 'RelativeMouseMode:' $rdp.AdvancedSettings7.RelativeMouseMode
    Write-Host 'AllowRelativeMouseMode:' $property.GetValue($ext,[object[]]@('AllowRelativeMouseMode'))
} finally {
    if ($ptr -ne [IntPtr]::Zero) { [void][Runtime.InteropServices.Marshal]::Release($ptr) }
    if ($unknown -ne [IntPtr]::Zero) { [void][Runtime.InteropServices.Marshal]::Release($unknown) }
}
[System.Windows.Forms.Application]::Run($context)