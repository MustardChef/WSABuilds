## Issue: </br> Error 0x80073CF6 when "Run.bat" is executed to install Windows Subystem for Android (WSA)
### Preface:
##### This issue can arise due to many factors that is preventing the app from being registered. Although there is no definite solution, we can try these steps to try to fix the problem
##### This installation issue may also arise in systems that are using Modified Windows OSes such as ReviOS, Tiny10/11, etc. This is due to the fact that these OSes have been modified to remove certain features that are deemed unnecessary. This may cause issues with the installation of WSA.
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
## Prequisite Steps:

**1. Ensure the partition/drive you are installing from is NTFS**

**2. Redownload WSA Build .zip (sometime the files can be corrupted during download and extraction)**

**3. If you have installed WSA prior, make sure that it has been uninstalled and delete all folders containing "WindowsSubsystemForAndroid" from the following directories/paths and the subdirectories within:** 

   - *C:\ProgramData\Microsoft\Windows\AppRepository*
   
   - *C:\ProgramData\Microsoft\Windows\WindowsApps*
   
   - *%localappdata\ProgramData\Packages*

<br>

**4. Restart your Computer**

If the issue has been fixed, then there is no need to follow through the rest of the guide.
However, if you have the same issue, it is vital that you obtain the logs and try to decipher what is causing the error

To obtain the logs (admin privilege required):

1. Open a PowerShell window and change working directory to your Windows Subsystem For Android™ directory.
    
2. Run the command below in PowerShell. This should fail with an ActivityID, which is a UUID required for the next step.
      ```Powershell
       Add-AppxPackage -ForceApplicationShutdown -ForceUpdateFromAnyVersion -Register .\AppxManifest.xml
      ```   
3. Run the command below in PowerShell. This should print the log of the failed operation.
      
      ```Powershell
       Get-AppPackageLog -ActivityID <UUID>
      ```
      
</br>


---

### There are various causes that lead to error 0x80073CF6 </br> Find the fix that matches the error presented in the logs obtained from the instructions above

---
## Issue 1: 0x800706D9 "There are no more endpoints avaliable from endpoint mapper"

<img src="https://user-images.githubusercontent.com/68516357/227363632-7270ee01-9a98-44c2-9ccc-1fb2ef24897c.jpg" style="width: 900px;"/>

### **Windows Firewall**

**1. Ensure that Windows Firewall is on and is working with "Recommended Settings" being enabled**

**2. Ensure that Windows Firewall service is running. If not, enable it.**

**3. Restart your PC**

### Other Firewalls

**1. Ensure that your Firewall is on and is working with "Recommended Settings" being enabled**

**2. Ensure that your Firewall is not blocking or preventing new entries**

**3. Restart your PC**

<br>

---
## Issue 2: 0x80073B06 "Initial screen image for the current application context cannot be recognized"

```powershell
Installing MagiskOnWSA...
Add AppxPackage: Deployment failed due to HRESULT: 0x80073CF6, unable to register the package.
AppxManifest.xml (24,27): Error 0x80073B06: Unable to install or update package MicrosoftCorporateII.WindowsSubsystemForAndroid_ 8wekyb 3d8bbwe because the initial screen image for the current application context cannot be recognized. The application context may include specific language, DPI, contrast, or other special conditions. If you cannot recognize a context specific splash screen image, add a splash screen image to use as the default setting. Note: For additional information, look for [ActivityId] 94c065bb-5a2a-0004-129b-c1942a5ad901 in the event log, or use the command line Get AppPackageLo g - ActivityID 94c065bb-5a2a-0004-129b-c1942a5ad901 in the location D:  WSA  WSA  Install.ps1:106 Character: 1
+ Add-AppxPackage -ForceApplicationShutdown -ForceUpdateFromAnyVersion  ...
+ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ CategoryInfo          : WriteError: (D:\WSA\WSA\AppxManifest.xml:String) [Add-AppxPackage], IOException
+ FullyQualifiedErrorId : DeploymentError,Microsoft.Windows.Appx.PackageManager.Commands.AddAppxPackageCommand
```
### Solution:

**1.** If you encounter this problem when installing from a build built using [MagiskOnWSALocal](https://github.com/LSPosed/MagiskOnWSALocal) or [WSA-Script](https://github.com/YT-Advanced/WSA-Script), try deleting the previously built builds and rebuild. Make sure to delete and reclone the git repo if you are building using MagiskOnWSALocal.

***Or***

**2.** If you encounter this problem when installing using prebuilt builds from [Releases](https://github.com/YT-Advanced/WSA-Script/releases/latest) from this repo, try redownloading the latest build. If the issue persists, report to the [Issues](https://github.com/YT-Advanced/WSA-Script/issues) and I will be happy to assist you


---

**Hope these fixes work for you!**
