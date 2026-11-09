# Hyper-V baseline

Observed: Windows Server 2025 Host, Generation 2 Windows 10 Pro guest, RTX 4070 Ti SUPER. Earlier experiments involved a Generation 1 VM and VHDX conversion; these destructive migration steps are not reproduced.

Run on **Host** (read-only):

```powershell
Get-VM -Name '新增虛擬機器-G2' | Select-Object Name,State,Status,Generation
Get-VMGpuPartitionAdapter -VMName '新增虛擬機器-G2' | Format-List *
Get-VMHostPartitionableGpu | Format-List *
```

To identify Guest versus Host:

```powershell
Get-CimInstance Win32_ComputerSystem | Select-Object Name,Manufacturer,Model
```

Do not copy another machine's GPU partition resource limits without verifying support.