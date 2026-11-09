# Troubleshooting and limitations

| Symptom | Safe next step |
| --- | --- |
| VMMS 34520 / 0x800705AA | Inspect Host policy, GPU allocation and event logs; do not copy resource quotas blindly |
| NVIDIA Code 43 / DxgKrnl 549 | Check matching Host/Guest driver package; see driver repair case study |
| nvidia-smi missing | Check nvcuda.dll and test CUDA Driver API before changing a working driver |
| WScript.Shell fails to save Chinese shortcut name | Create ASCII shortcut and rename afterward |
| Old GAC vmconnect.exe path missing | Check System32 vmconnect.exe; internal API compatibility is not guaranteed |
| PowerShell shows >> | Press Ctrl+C to cancel incomplete multiline input |
| ollama launch codex HTTP 402 | Distinguish cloud billing from local Ollama execution |

**Public repository caution:** Never commit passwords, tokens, private logs, personal files, VM disks, proprietary drivers, or copyrighted game assets.