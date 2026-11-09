# GPU-P configuration and verification

GPU-P shares a physical GPU with the Host; it is not full device assignment.

On **Host**:

```powershell
Get-VMHostPartitionableGpu | Format-List *
Get-VMGpuPartitionAdapter -VMName '新增虛擬機器-G2' | Format-List *
```

The lab previously encountered `0x800705AA` and Hyper-V VMMS event 34520 relating to GPU partition allocation and policy. There is no verified universal resource quota or policy fix.

On **Guest**:

```powershell
Get-PnpDevice -Class Display | Select-Object FriendlyName,Status,InstanceId
Get-CimInstance Win32_VideoController | Select-Object Name,DriverVersion,Status
```

An NVIDIA device appeared as OK while another enumerated as Unknown. Do not delete devices based on this observation alone.