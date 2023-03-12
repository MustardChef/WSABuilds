# WSABuilds &nbsp; &nbsp; <img src="https://img.shields.io/github/downloads/MustardChef/WSABuilds/total?label=Total%20Downloads&style=for-the-badge"/> &nbsp; 

---
## Issue: </br> Error 0x80073CF6 when "Run.bat" is executed to install Windows Subystem for Android (WSA)
### Preface:
##### This issue can arise due to many factors. Although there is no definite solution, we can try these steps to try to fix the problem 

</br>

```Powershell
Add-AppxPackage : Deployment failed with HRESULT: 0x80073CF6, Package could not be registered
In E:\WSA\Install.ps1:102 Character:1
+ Add-AppxPackage -ForceApplicationShutdown -ForceUpdateFromAnyVersion

   + CategoryInfo          : WriteError: (E:\WSA\AppxManifest.xml:String) [Add-AppxPackage], IOException
    + FullyQualifiedErrorId : DeploymentError,Microsoft.Windows.Appx.PackageManager.Commands.AddAppxPackageCommand
```


</br>

---
## Solution

**1. Ensure the partition/drive you are installing from is NTFS**

**2. Redownload WSA Build .zip (sometime the files can be corrupted during download and extraction)**

**3. Delete all folders containing "WindowsSubsystemForAndroid" in the following directories:** 

<br>

   - *C:\ProgramData\Microsoft\Windows\AppRepository*
   
   - *C:\ProgramData\Microsoft\Windows\WindowsApps*
   
   - *%localappdata\ProgramData\Packages*

<br>

**4. Restart your Computer**

<br>

**Hope this works for you!**

---

### Have futher question or need help?

Join the Discord if you have any other questions or need help!

[<img src="https://invidget.switchblade.xyz/2thee7zzHZ" style="width: 400px;"/>](https://discord.gg/2thee7zzHZ)
