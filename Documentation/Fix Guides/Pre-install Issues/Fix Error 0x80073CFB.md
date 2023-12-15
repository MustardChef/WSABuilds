# WSABuilds &nbsp; &nbsp; <img src="https://img.shields.io/github/downloads/MustardChef/WSABuilds/total?label=Total%20Downloads&style=for-the-badge"/> &nbsp; 

---
## Issue: <br /> Error 0x80073CFB when "Run.bat" is executed to install Windows Subystem for Android (WSA)
### Preface:
##### This issue can arise due to the fact that "the provided package is already installed, and reinstallation of the package was blocked. Check the AppXDeployment-Server event log for details." 


![imageCFB](https://github.com/MustardChef/WSABuilds/assets/68516357/7e78c472-2b61-49d5-a01f-814cf20e1458)


---
## Solution

**1. Go to ``%LOCALAPPDATA%/Packages/``, and make sure that the folder ``MicrosoftCorporationII.WindowsSubsystemForAndroid_8wekyb3d8bbwe`` is deleted. (If it does not exist, move on to Step **2**.)**

<br />

**2. Open Powershell (as Admin) and run the following command:**

```powershell
Get-AppxPackage -Name "MicrosoftCorporationII.WindowsSubsystemForAndroid" -AllUsers | Remove-AppxPackage -AllUsers
```
<br />

**3. Delete all folders related to WSA (except the .zip or .7z files (depends on the release ) for WSA Builds), which include folders extracted for WSA installation.**

<br />

**4. Rextract and re-run ``Run.bat``**

<br />

***The issue should now be fixed***


<br />

---

## Have futher question or need help?

#### Join the Discord if you have any other questions or need help!

[<img src="https://invidget.switchblade.xyz/2thee7zzHZ" style="width: 400px;"/>](https://discord.gg/2thee7zzHZ)
