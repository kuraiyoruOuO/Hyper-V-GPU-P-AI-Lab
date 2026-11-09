# Hyper-V GPU-P AI Lab

Public technical notebook for Hyper-V GPU partitioning (GPU-P), NVIDIA driver troubleshooting, VMConnect relative mouse, CUDA checks and Ollama local AI.

> **Status:** GPU-P graphics and CUDA device enumeration succeeded in a Windows 10 G2 guest. Ollama GPU inference, training and portability to other systems have **not yet been verified**.

## Environment
- Host: Windows Server 2025 Standard Evaluation
- GPU: NVIDIA GeForce RTX 4070 Ti SUPER (16 GB)
- Guest: Hyper-V Generation 2, Windows 10 Pro 19045
- Guest CUDA: `cuDeviceGetCount` returned success (0), device count 1
- `nvidia-smi.exe` missing in guest, but `nvcuda.dll` and `nvml.dll` present

## Guides
1. [Hyper-V setup](docs/01-hyper-v-setup.md)
2. [GPU-P](docs/02-gpu-p-setup.md)
3. [NVIDIA Code 43 repair](docs/03-nvidia-driver-fix.md)
4. [Relative mouse](docs/04-relative-mouse.md)
5. [CUDA verification](docs/05-cuda-test.md)
6. [Ollama](docs/06-ollama.md)
7. [Troubleshooting](docs/07-troubleshooting.md)

## Scripts
- [GPU diagnostics](scripts/Check-GPU.ps1)
- [CUDA probe](scripts/Test-CUDA.ps1)
- [Experimental VMConnect relative-mouse launcher](scripts/VMConnect-RelativeMouse.ps1)
- [Shortcut installer](scripts/Install-G2-Shortcut.ps1)

**Safety:** No VM disks, proprietary driver binaries, AI model weights, personal files, game files or credentials are included. Experimental reflection-based VMConnect code relies on undocumented internals and must be reviewed and tested locally. GPU-P is not a means of bypassing anti-cheat systems.

MIT license; see [LICENSE](LICENSE).