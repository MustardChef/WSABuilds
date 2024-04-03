## Issue: </br> Error 0x80073CFB when "Run.bat" is executed to install Windows Subystem for Android (WSA)
### Preface:
##### This issue can arise due to the fact that "the provided package is already installed, and reinstallation of the package was blocked. Check the AppXDeployment-Server event log for details." 


![imageCFB](https://github.com/MustardChef/WSABuilds/assets/68516357/7e78c472-2b61-49d5-a01f-814cf20e1458)


---
## Solution

**1. Go to ``%LOCALAPPDATA%/Packages/``, and make sure that the folder ``MicrosoftCorporationII.WindowsSubsystemForAndroid_8wekyb3d8bbwe`` is deleted. (If it does not exist, move on to Step **2**.)**

<br>

**2. Open Powershell (as Admin) and run the following command:**

```powershell
Get-AppxPackage -Name "MicrosoftCorporationII.WindowsSubsystemForAndroid" -AllUsers | Remove-AppxPackage -AllUsers
```
<br>

**3. Delete all folders related to WSA (expect the .zip files for WSA Builds), which include folders extracted for WSA installation.**

<br>

**4. Re-extract and re-run ``Run.bat``**

<br>

***The issue should now be fixed***

---
