# VMConnect Enhanced Session relative mouse

**Goal:** Open G2 VMConnect with relative mouse input; this is **not** a Windows startup task.

The experimental PowerShell STA launcher used VMConnect internal types and enabled:
- `AdvancedSettings7.RelativeMouseMode = $true`
- `IMsRdpExtendedSettings.Property['AllowRelativeMouseMode'] = $true`

The desktop shortcut was reported to launch successfully. Final in-game unlimited rotation was not separately reconfirmed. Internal reflection APIs are undocumented and Windows updates can break this.

On **Host**, review and test [the experimental launcher](../scripts/VMConnect-RelativeMouse.ps1). Put a tested copy at `C:\VMConnect-RelativeMouse.ps1`, then run [shortcut installer](../scripts/Install-G2-Shortcut.ps1). The shortcut uses an ASCII filename `G2-RelativeMouse.lnk` because WScript.Shell failed to save a Chinese filename. Rename it afterward in Explorer if desired.

An earlier scheduled task named `RunVMRelativeMouse` was disabled; this procedure does not enable startup tasks.