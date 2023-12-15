# WSABuilds &nbsp; &nbsp; <img src="https://img.shields.io/github/downloads/MustardChef/WSABuilds/total?label=Total%20Downloads&style=for-the-badge"/> &nbsp; 


## Issue: Icons have disappeared or have turned white after updating WSA or after restarting your computer

<br />

### Preface:
##### This looks like a bug in the WSA itself and the icons can be restored by the following steps.

<br />
<br />

## Solution
 
**1.** Backup `userdata.vhdx` from `%LOCALAPPDATA%\Packages\MicrosoftCorporationII.WindowsSubsystemForAndroid_8wekyb3d8bbwe\LocalCache\` folder

<br />

**2.** Uninstall WSA by [following this guide](https://github.com/MustardChef/WSABuilds#--uninstallation)

<br />
 
**3.** Remove the two lines in `Install.ps1` that automatically launches Magisk and Play Store after the installation is finished

```powershell
function Finish {
    Clear-Host
    Start-Process "wsa://com.topjohnwu.magisk"
    Start-Process "wsa://com.android.vending"
}
```

<br />

**4.** Install WSA by running `Run.bat` or `Install.ps1`
 
<br />

**5.** Restore `userdata.vhdx`  to `%LOCALAPPDATA%\Packages\MicrosoftCorporationII.WindowsSubsystemForAndroid_8wekyb3d8bbwe\LocalCache\userdata.vhdx`

<br />

**6.** Start WSA

<br />

> [!WARNING]
> **Do not start WSA before restoring user data.**

<br />


<br />

---

## Have futher question or need help?

#### Join the Discord if you have any other questions or need help!

[<img src="https://invidget.switchblade.xyz/2thee7zzHZ" style="width: 400px;"/>](https://discord.gg/2thee7zzHZ)
