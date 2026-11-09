# Read-only CUDA Driver API test. Run inside Guest.
$ErrorActionPreference = 'Stop'
if (-not ('GpuP_CudaProbe' -as [type])) {
    Add-Type @'
using System;
using System.Runtime.InteropServices;
public static class GpuP_CudaProbe {
    [DllImport("nvcuda.dll", EntryPoint="cuInit")]
    public static extern int Init(uint flags);
    [DllImport("nvcuda.dll", EntryPoint="cuDeviceGetCount")]
    public static extern int DeviceGetCount(out int count);
}
'@
}
$code = [GpuP_CudaProbe]::Init(0)
Write-Host "CUDA Init Result: $code"
if ($code -eq 0) {
    $count = 0
    $query = [GpuP_CudaProbe]::DeviceGetCount([ref]$count)
    Write-Host "Device Query Result: $query"
    Write-Host "CUDA Device Count: $count"
}