# NVIDIA guest driver repair: Code 43 / DxgKrnl 549

**Symptoms:** GPU-P guest NVIDIA device showed Code 43 and DxgKrnl Event 549 (`StartAdapter_AddAdapterFailed`).

**Observed resolution:** Copying the matching Host NVIDIA 591.59 DriverStore package into the Guest and correcting the Guest driver installation resolved the errors in this particular lab.

The Host package used was:

```text
C:\Windows\System32\DriverStore\FileRepository\nv_dispi.inf_amd64_4646b47d9477048e
```

This package directory name is machine- and driver-specific. Proprietary driver files are not included. The procedure is experimental and not guaranteed on other systems; verify licensing, compatibility and backups.

Read-only Guest checks:

```powershell
Get-PnpDevice -Class Display | Select-Object FriendlyName,Status
Get-WinEvent -FilterHashtable @{LogName='System'; Id=549} -MaxEvents 10 -ErrorAction SilentlyContinue
```