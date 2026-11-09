# CUDA verification in Guest

Guest contained `C:\Windows\System32\nvcuda.dll` and `nvml.dll`, but not `nvidia-smi.exe`. Missing the command does not prove CUDA is unavailable.

Run [Test-CUDA.ps1](../scripts/Test-CUDA.ps1) inside the Guest.

Observed: `cuDeviceGetCount` returned `0` (CUDA_SUCCESS), with one CUDA device.

**Limit:** Enumeration does not establish successful CUDA kernel execution, PyTorch compatibility, performance or AI training. Test an actual workload separately.