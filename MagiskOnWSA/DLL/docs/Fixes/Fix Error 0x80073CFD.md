## Issue: </br> Error 0x80073CFD when "Run.bat" is executed to install Windows Subystem for Android (WSA)
### Preface:
##### This issue is caused by having a Windows 10 Build that is too old to run WSA and hence the installer halts and presents the error, as shown below 

</br>

```Powershell
Registering AppxManifest.xml... 
Add-AppxPackage : Deployment failed with HRESULT: 0x80073CFD, 
Prerequisite for an install could not be satisfied. Windows cannot install package MicrosoftCorporationII.WindowsSubsystemForAndroid_2301.40000.7.0_x64__8wekyb3d8bbwe because this package is not compatible with the device. 
The package requires OS version 10.0.19044.2604 or higher on the Windows.Desktop device family. 
The device is currently running OS version 10.0.19043.2364. 
NOTE: For additional information, look for [ActivityId] 8b8599fb-55c1-0002-338b-868bc155d901 in the Event Log or use the command line 
Get-AppPackageLog -ActivityID 8b8599fb-55c1-0002-338b-868bc155d901
```


</br>

---
## Solution:

### The Solution is simple:

Using the [Microsoft Guide](https://support.microsoft.com/en-gb/windows/update-windows-3c5ae7fc-9fb6-9af1-1984-b5e0412c556a#WindowsVersion=Windows_10), update Windows 10 to the latest version

***Or***

Using the [Windows 10 Update Assistant](https://support.microsoft.com/en-us/topic/windows-10-update-assistant-3550dfb2-a015-7765-12ea-fba2ac36fb3f), update Windows 10 to the latest version
