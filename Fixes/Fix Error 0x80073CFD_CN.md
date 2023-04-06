# WSABuilds &nbsp; &nbsp; <img src="https://img.shields.io/github/downloads/MustardChef/WSABuilds/total?label=Total%20Downloads&style=for-the-badge"/> &nbsp; 

---

## 问题: </br> 运行“Run.bat”安装Windows子系统Android (WSA) 时出现0x80073CFD错误
### 前言:
##### 这个问题是由于Windows 10 Build版本过老，无法运行WSA，因此安装程序会停止并出现错误，如下所示

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
## 解决方法:

### 解决方法很简单:

使用[微软指南](https://support.microsoft.com/en-gb/windows/update-windows-3c5ae7fc-9fb6-9af1-1984-b5e0412c556a#WindowsVersion=Windows_10)更新Windows 10到最新版本

***或***

使用[Windows 10 更新助手](https://support.microsoft.com/en-us/topic/windows-10-update-assistant-3550dfb2-a015-7765-12ea-fba2ac36fb3f)
