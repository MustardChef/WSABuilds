## Issue: Icons have disappeared or have turned white after updating WSA or after restarting your computer

### Preface:
##### This looks like a bug in the WSA itself and the icons can be restored by the following steps.

## Solution
 
**1.** Backup `userdata.vhdx` from `%LOCALAPPDATA%\Packages\MicrosoftCorporationII.WindowsSubsystemForAndroid_8wekyb3d8bbwe\LocalCache\userdata.vhdx`

**2.** Uninstall WSA by [Following this guide](https://github.com/YT-Advanced/WSA-Script#--uninstallation)
 
**3.** Remove the two lines in `Install.ps1` that automatically launches Magisk and Play Store after the installation is finished

```powershell
function Finish {
    Clear-Host
    Start-Process "wsa://com.topjohnwu.magisk"
    Start-Process "wsa://com.android.vending"
}
```

**4.** Install WSA
 
**5.** Restore `userdata.vhdx`  to `%LOCALAPPDATA%\Packages\MicrosoftCorporationII.WindowsSubsystemForAndroid_8wekyb3d8bbwe\LocalCache\userdata.vhdx`

**6.** Start WSA

</br>

> **Warning**
>**Do not start WSA before restoring user data.**

</br>
