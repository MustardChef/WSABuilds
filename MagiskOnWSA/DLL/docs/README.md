# WSA-Script
## MagiskOnWSA (For Windows™ 10 and 11) by [@YT-Advanced](https://github.com/YT-Advanced/)
### Windows Subsystem For Android™ (WSA) with Google Play Services and Magisk 

<details>     
   <summary><h3> &nbsp; ❓Want to build your custom build❓ <h3></summary>
      

| :exclamation: **Important:**  &nbsp;  `⚠️DO NOT FORK⚠️`               |
|------------------------------------------------------------------------|
|**This repository is designed specifically not to be forked. MagiskOnWSA and some of the various forks and clones that have sprung up on the platform (***potentially***) violate GitHub's Terms of Service due to abuse of GitHub Actions and have been ultimately warned, disabled or banned.**| 
|**Therefore, don't fork this repository unless you're a developer and want to modify the code itself and/or want to contribute to this Github repository.**|
|**If you want to create your Custom Build, please follow the instructions set out clearly, to avoid the repo from being taken down as a result of a misuse of Github Actions due to the large number of forks. AND ALSO if you want to build with Latest Insider version, please skip the first 7 steps**|
      
#### **1. Star this repos (I will happy if you do that)**

#### **2. Check the version from [Releases](https://github.com/YT-Advanced/WSA-Script/releases/) first. If it does not have the version you want, continue to follow this guide. If it does, then feel free to use those prebuild WSA builds**

#### **3. Open [this page directly](https://YT-Advanced.github.io/WSA-Script) then choose the option that you want to build**

![](https://user-images.githubusercontent.com/70064328/236150011-191bf3a8-2efb-44a1-af44-202c6ea9fe66.png)

#### **4. Click "Create Issues" Button, the issues page will be generated and open. Then you click "Submit New Issues" (green button) and wait.**
![](https://user-images.githubusercontent.com/70064328/236150320-65fdd492-9fc4-4176-b3bd-a3cee8b7753d.png)

#### **5. After about 10 minutes, the bot will reply that the workflow have built successfully (like the picture below), OPEN THE LINK BELOW THE BOT COMMENT**
![](https://user-images.githubusercontent.com/70064328/236154819-75dd1997-1999-43fd-a482-050f21e34b72.png)

#### **6. Download the package as artifact**
**DO NOT download it via multithread downloaders like IDM**
![](https://user-images.githubusercontent.com/68516357/222224469-5748b78a-158e-46ff-9f65-317dbb519aac.png)

#### **7. Install like normal using [the instructions](https://github.com/YT-Advanced/WSA-Script#--installation) in this repository** and most important of all....

</details>

## Downloads

<table>
<thead>
  <tr>
    <th>Click to Download</th>
    <th>Differences</th>
    <th>Current Version</th>
    <th>Date</th>
  </tr>
</thead>
<tbody>
  <tr>
    <td><a href=https://github.com/YT-Advanced/WSA-Script/releases/tag/WSA-Insider-Version><img src="https://img.shields.io/badge/Pre--Release%20Builds-orange?style=for-the-badge" height="28"></a></td>
    <td>Follows the "WSA Preview Program Channel" </br> </br> Builds are generally newer than the "WSA Retail" and "Insider Fast Channel"</td>
    <td>2311.40000.5.0<br></td>
    <td>Builds Released: 05/01/2024</td>
  </tr>
  <tr>
    <td><a href=https://github.com/YT-Advanced/WSA-Script/releases/latest><img src="https://img.shields.io/badge/Stable%20Builds-blue?style=for-the-badge" alt="Image" height="28"></a></td>
    <td>Follows the "WSA Retail Channel" <br><br> Builds are generally more stable than the builds in the "WSA Preview Program Channel" </td>
    <td>2311.40000.5.0<br></td>
    <td>Builds Released: 05/01/2024</td>
  </tr>
  <tr>
    <td colspan="4"><h4>It is recommend to check this table regularly to see if there is a newer update avaliable for WSA for the Stable Builds and Pre-Release Builds<h4></td>
  </tr>
  </tbody>
</table>

## Requirements

<center><table>
<thead>
  <tr>
    <th></th>
    <th><img src="https://upload.wikimedia.org/wikipedia/commons/e/e6/Windows_11_logo.svg" style="width: 200px;"/></th>
    <th><img src="https://upload.wikimedia.org/wikipedia/commons/0/05/Windows_10_Logo.svg" style="width: 200px;"/></th>
  </tr>
</thead>
<tbody>
  <tr>
    <td><img style="float: right;" src="https://img.icons8.com/fluency/96/null/windows-update--v1.png" width="60" height="60"/><h4>Windows Build Number<h4></td>
    <td>Windows™ 11: Build 22000.526 or higher.</td>
    <td>Windows™ 10: 22H2 10.0.19042.2604 or higher. <br /><br /><b>To use WSA, you must install <a href="https://www.catalog.update.microsoft.com/Search.aspx?q=KB5014032" target="_blank" rel="noopener noreferrer">KB5014032</a> then install <a href="https://www.catalog.update.microsoft.com/Search.aspx?q=KB5022834" target="_blank" rel="noopener noreferrer">KB5022834</a> to use WSA on these Windows 10 builds<b><br /><br /><b></td>
  </tr>
  <tr>
    <td><img style="float: right;" src="https://img.icons8.com/external-smashingstocks-flat-smashing-stocks/66/null/external-RAM-technology-and-devices-smashingstocks-flat-smashing-stocks.png" width="60" height="60"/><h4>RAM<h4></td>
    <td colspan="2"><ul><li>4 to 6 GB (Not Recommended)</li><li>8 GB (Minimum)</li><li>16 GB (Recommended)</li></ul></td>
  </tr>
  <tr>
    <td><img style="float: right;" src="https://img.icons8.com/3d-fluency/94/null/electronics.png" width="60" height="60"/><h4>Processor<h4></td>
    <td>Your PC should meet the basic Windows™ 11 requirements i.e Core i3 8th Gen, Ryzen 3000, Snapdragon 8c, or above</td>
    <td>N/A </br></br> This is a bit of a hit or miss, but it is highly recommended that your processor is listed in the <a href="https://learn.microsoft.com/en-gb/windows-hardware/design/minimum/windows-processor-requirements" target="_blank" rel="noopener noreferrer">supported CPU lists for Windows 11 requirements</a></td>
  </tr>
  <tr>
    <td><img style="float: right;" src="https://img.icons8.com/3d-fluency/94/null/video-card.png" width="60" height="60"/><h4>GPU<h4></td>
      <td colspan="2">Any compatible Intel, AMD or Nvidia GPU. <br /> GPU Performance may vary depending on its compatibility with Windows Subsystem For Android™  <br /</td>
  </tr>
  <tr>
    <td rowspan="2"><img style="float: right;" src="https://img.icons8.com/3d-fluency/94/null/ssd.png" width="60" height="60"/><h4>Storage<h4></td>
    <td colspan="2">Solid-state drive (SSD) (RECOMMENDED) <br />OR</br> Hard Disk Drive (HDD)   (NOT RECOMMENDED)</td>
  </tr>
  <tr>
     <td colspan="2"><b><i>Minimum Storage Requirements: You must have at least 10GB free on the system drive (C:\)<b><i></td>
  </tr>
  <tr>
    <td><img style="float: right;" src="https://img.icons8.com/stickers/100/null/storage.png" width="60" height="60"/><h4>Partition<h4></td>
    <td colspan="2"><b><i>NTFS ONLY<b><i> <br /><br /> Windows Subsystem For Android™ can only be installed on a NTFS partition, not on an exFAT partition</td>
  </tr>
  <tr>
    <td rowspan="5"><img style="float: left;" src="https://user-images.githubusercontent.com/68516357/230764789-ad8f7361-4a3b-49a8-a8e9-24fdc87d5781.png" width="66" height="58"/><h4>Windows Features Needed<h4></td>
    <td colspan="2">Virtual Machine Platform Enabled : <b>Require!!</b></td>
  </tr>
  <tr>
    <td colspan="2">Windows Hypervisor Platform Enabled (Optional)</td>
  </tr>
  <tr>
    <td colspan="2">Windows Subsystem For Linux™ Enabled (Optional)</td>
  </tr>
  <tr>
    <td colspan="2">Hyper-V Enabled (Optional)</td>
  </tr>
  <tr>
    <td colspan="2"><b><i>These optional settings are for virtualization and provide components that are needed to run WSA. You can enable these settings by pressing the Windows Key + R on your keyboard and typing "OptionalFeatures.exe" into the box, pressing enter and selecting the features above followed by pressing apply<b><i></td>
  </tr>
  <tr>
    <td><img style="float: right;" src="https://user-images.githubusercontent.com/68516357/230759907-5d11950e-1b17-4811-8f4e-a0f82e598079.png" width="60" height="60"/><h4>Virtualization<h4></td>
    <td colspan="2">The Computer must support virtualization and be enabled in BIOS/UEFI and Optional Features. </br> <h3><a href="https://support.microsoft.com/en-us/windows/enable-virtualization-on-windows-11-pcs-c5578302-6e43-4b4b-a449-8ced115f58e1" target="_blank" rel="noopener noreferrer">Guide on how to enable</a><h3></td>
  </tr>
</tbody>
</table>


&nbsp;

<details>     
   <summary><picture><img style="float: right;" src="https://img.icons8.com/color/96/null/software-installer.png" width="60" height="60"/></picture><h1> &nbsp; Installation<h1></summary>

&nbsp;

> **Note** : 
> If you have the official Windows Subsystem For Android™ installed, you must [completely uninstall](#uninstallation) it to use MagiskOnWSA. 

> In case you want to preserve your data from the previous installation (official or MagiskOnWSA), you can backup `%LOCALAPPDATA%\Packages\MicrosoftCorporationII.WindowsSubsystemForAndroid_8wekyb3d8bbwe\LocalCache\userdata.vhdx` before uninstallation and restore it after installation.  For a more comprehensive and detailed guide, take a look at the **Backup and Restore section** in this README markdown

1. Go to the [Releases page](https://github.com/YT-Advanced/WSA-Script/releases/latest)
2. In the latest release, go to the Assets section and download the Windows Subsystem For Android™ version of your choosing (do not download "Source code")

> **Note** : 
> If you want to download WSA with Magisk Delta, please go to [![Action Tab](https://github.com/YT-Advanced/WSA-Script/actions/workflows/custom_build.yml/badge.svg)](https://github.com/YT-Advanced/WSA-Script/actions/workflows/custom_build.yml) and download the package from the Action. 

3. Check integrity of downloaded file by [Follow this guide](Guides/Checksum.md)
4. Extract the zip file
5. Delete the zip file
6. Move the newly extracted folder to a suitable location (Documents folder is a good choice), as you will need to keep the folder on your PC to use MagiskOnWSA

> **Note** :  
> If you're updating WSA, merge the folders and replace the files for all items when asked

7. Open the Windows Subsystem For Android™ folder: Search for and double-click `Run.bat`
   - If you previously have a MagiskOnWSA installation, it will automatically uninstall the previous one while preserving all user data and install the new one, so don't worry about your data.
   - If the popup windows disappear without asking administrative permission and Windows Subsystem For Android™ is not installed successfully, you should manually run Install.ps1 as administrator:
      
      - Press `Win+X` and select **Windows™ Terminal (Admin)**
      
      - Input the command below and press enter, replacing {X:\path\to\your\extracted\folder} including the {} with the path of the extracted folder
        ```Powershell
        cd "{X:\path\to\your\extracted\folder}"
        ```  
        
      - Input the command below and press enter   
        ```Powershell
        PowerShell.exe -ExecutionPolicy Bypass -File .\Install.ps1
        ```
        
      - The script will run and Windows Subsystem For Android™ will be installed
      - If this workaround does not work, your PC is not supported for WSA
      
8. Once the installation process completes, Windows Subsystem For Android™ will launch (if this is a first-time install, a window asking for consent to diagnositic information will be shown instead. Sometimes two identical windows will show, this is fine and nothing bad happens if you click OK in both windows)
9. Click on the PowerShell window, then press any key on the keyboard, the PowerShell window should close
10. Close File Explorer
11. **Enjoy**

&nbsp;

### Notice (Applicable for both Windows 10 and 11):

1. You can NOT delete the Windows Subsystem For Android™ installation folder.
   What `Add-AppxPackage -Register .\AppxManifest.xml` does is to register an appx package with some existing unpackaged files,
   so you need to keep them as long as you want to use Windows Subsystem For Android™. 
   Check https://learn.microsoft.com/en-us/powershell/module/appx/add-appxpackage?view=windowsserver2022-ps for more details.
2. You need to register your Windows Subsystem For Android™ appx package before you can run Windows Subsystem For Android™. 
   For [WSA-Script](https://github.com/YT-Advanced/WSA-Script) and [MagiskOnWSALocal](https://github.com/LSPosed/MagiskOnWSALocal) users, you need to run `Run.bat` in the extracted dir.
   If the script fails, you can take the following steps for diagnosis (admin privilege required):
    1. Open a PowerShell window and change working directory to your Windows Subsystem For Android™ directory.
    
    2. Run the command below in PowerShell. This should fail with an ActivityID, which is a UUID required for the next step.
       ```Powershell
       Add-AppxPackage -ForceApplicationShutdown -ForceUpdateFromAnyVersion -Register .\AppxManifest.xml
       ```
       
    3. Run the command below in PowerShell. This should print the log of the failed operation.
       ```Powershell
       Get-AppPackageLog -ActivityID <UUID>
       ```
    4. Check the log for the reason of failure and fix it.

</details> 

&nbsp;


<details>     
   <summary><picture><img style="float: right;" src="https://img.icons8.com/external-flaticons-flat-flat-icons/64/null/external-updating-tools-and-material-ecommerce-flaticons-flat-flat-icons.png" width="60" height="60"/></picture><h1> &nbsp; Updating<h1></summary>

### How do I update without losing any of my apps and data on Windows Subsystem for Android (WSA)

1. [Download the latest build](https://github.com/YT-Advanced/WSA-Script/releases/latest) (that you want to update to)
2. Make sure Windows Subsystem For Android is not running (Click on "Turn off" in the WSA Settings and wait for the spinning loader to disappear)
2. Using 7-Zip, WinRAR or any other tool of choice, open the .zip file 
3. Within the .zip archive open the subfolder (Example: WSA_2xxx.xxxxx.xx.x_x64_Release-Nightly-with-magisk-xxxxxxx-MindTheGapps-13.0-as-Pixel-5-RemovedAmazon)
4. Select all the files that are within this subfolder and extract them to the current folder where the file for Windows Subsystem For Android are (the folder you extracted, and installed WSA from)
5. When prompted to replace folders, select "Do this for all current items" and click on "Yes" 
6. When prompted to replace files, click on "Replace the files in the destination"
7. Run  the ``Run.bat`` file
8. Launch Windows Subsystem For Android Settings app and go to the ``About`` tab using the sidebar
9. Check if the WSA version matches the latest version/ the version number that you want to update to


</details>   

&nbsp;

<details>     
   <summary><picture><img style="float: right;" src="https://img.icons8.com/color/96/null/uninstall-programs.png" width="60" height="60"/></picture><h1> &nbsp; Uninstallation<h1></summary>

&nbsp;

> **Note**: 
> 
> If you want to preseve your data, make a backup of the `%LOCALAPPDATA%\Packages\MicrosoftCorporationII.WindowsSubsystemForAndroid_8wekyb3d8bbwe\LocalCache\userdata.vhdx` file. After uninstalling, copy the VHDX file back to the `%LOCALAPPDATA%\Package\MicrosoftCorporationII.WindowsSubsystemForAndroid_8wekyb3d8bbwe\LocalCache` folder. For a more comprehensive and detailed guide, take a look at the **Backup and Restore section** in this README markdown

- To remove WSA installed:

   - **1.)** Make sure that Windows Subsystem For Android™ is not running
   - **2.)** Search for ``Windows Subsystem For Android™ Settings`` using the built-in Windows Search, or through Add and Remove Programs and press uninstall
   - **3.)** Delete the WSA folder that extracted you extracted and Run.bat was run from to install WSA (MagiskOnWSA folder)
   - **4.)** Go to ``%LOCALAPPDATA%/Packages/`` and delete the folder named ``MicrosoftCorporationII.WindowsSubsystemForAndroid_8wekyb3d8bbwe``
            
      - If you get an error that states that the file(s) could not be deleted, make sure that WSA is turned off
     
- To remove WSA installed from the Microsoft Store: 
        
   - **1.)** Search for ``Windows Subsystem For Android™ Settings`` using the built-in Windows Search, or through Add and Remove Programs and press uninstall

</details>

&nbsp;
      
<details>     
   <summary><picture><img style="float: right;" src="https://img.icons8.com/fluency/96/cloud-backup-restore.png" width="60" height="60"/></picture><h1> &nbsp; Backup and Restore Userdata<h1></summary>

## Backing Up Your Userdata

In order to make a backup of your WSA data you must copy the Userdata.vhdx (which includes, but is not limited Android Apps and their data, settings etc.), located at `%LOCALAPPDATA%\Packages\MicrosoftCorporationII.WindowsSubsystemForAndroid_8wekyb3d8bbwe\LocalCache\userdata.vhdx`, to a safe location     

## Restoring Your Backup

Before attempting to restore your backup, you must remove WSA if installed. Then before you run the "Run.bat" script (to reinstall WSA after removing it), you need to remove these lines from Install.ps1: 

Official Magisk:
```pwsh
Start-Process "wsa://com.topjohnwu.magisk"
```
Magisk Alpha:
```pwsh
Start-Process "wsa://io.github.vvb2060.magisk"
```
Magisk Delta:
```pwsh
Start-Process "wsa://io.github.huskydg.magisk"
```
Google Play Store:
```pwsh
Start-Process "wsa://com.android.vending"
```
Amazon Appstore:
```pwsh
Start-Process "wsa://com.amazon.venezia"
``` 
After running the script, do not run WSA at all, and go to %localappdata%\Packages and (if the folders do not exist, create them) in MicrosoftCorporationII.WindowsSubsystemForAndroid_8wekyb3d8bbwe\LocalCache\ paste the userdata.vhdx

Now run WSA and your serdata should hopefully be restored
</details>
      
&nbsp;
      
<details>     
   <summary><picture><img style="float: right;" src="https://img.icons8.com/3d-fluency/94/null/help.png" width="60" height="60"/></picture><h1> &nbsp; FAQ<h1></summary>

&nbsp;
**Help me, I am having problems with the MagiskOnWSA Builds**

- Open an [issue in Github](https://github.com/YT-Advanced/WSA-Script/issues) and describe the issue with sufficent detail

**Help me, I am having problems with installing Windows Subsystem For Android™ on Windows™ 10**

- I am not working on the patch, and nor claim to.  Open an issue in Github, and I will try to assist you with the problem if possible. For full support visit the project homepage and open an issue there: https://github.com/cinit/WSAPatch/issues/

**How do I get a logcat?**
- There are two ways:
   ```
   adb logcat
   ```
   or

-  Location in Windows ---> <br/> `%LOCALAPPDATA%\Packages\MicrosoftCorporationII.WindowsSubsystemForAndroid_8wekyb3d8bbwe\LocalState\diagnostics\logcat`

**Can I delete the installed folder?**

- No.

**How can I update Windows Subsystem For Android™ to a new version?**

- As Explained [Installation instructions](#installation). Download the [latest Windows Subsystem For Android™ Version](#downloads) and replace the content of your previous installation and rerun Install.ps1. Don't worry, your data will be preserved

**How do I update Magisk?**

- Do the same as updating Windows Subsystem For Android™.  Wait for a new MagiskOnWSA release that includes the newer Magisk version, then follow the [Installation instructions](#installation) to update

**Can I pass SafetyNet/Play Integrity?**

- No. Virtual machines like Windows Subsystem For Android™ cannot pass these mechanisms on their own due to the lack of signing by Google. Passing requires more exotic (and untested) solutions like: <https://github.com/kdrag0n/safetynet-fix/discussions/145#discussioncomment-2170917>

**What is virtualization?**

- Virtualization is required to run virtual machines like Windows Subsystem For Android™.  `Run.bat` helps you enable it. After rebooting, re-run `Run.bat` to install Windows Subsystem For Android™.  If it's still not working, you have to enable virtualization in your BIOS/UEFI. Instructions vary by PC vendor, look for help online

**Can I remount system partition as read-write?**

- No. Windows Subsystem For Android™ is mounted as read-only by Hyper-V. You can, however, modify the system partition by creating a Magisk module, or by directly modifying the system.img file

**I cannot adb connect localhost:58526**

- Make sure developer mode is enabled. If the issue persists, check the IP address of Windows Subsystem For Android™ on the Settings ---> Developer page and try 

   ```
   adb connect ip:5555
   ```

**Magisk online module list is empty?**

- Magisk actively removes the online module repository. You can install the module locally or by 
  
   **Step 1** 
      
      adb push module.zip /data/local/tmp

   **Step 2**  

      adb shell su -c magisk --install-module /data/local/tmp/module.zip


**How do I uninstall Magisk?**

- Request, using [Issues](https://github.com/YT-Advanced/WSA-Script/issues), a Windows Subsystem For Android™ version that doesn't include Magisk from the [Releases page](https://github.com/YT-Advanced/WSA-Script/releases/latest). Then follow the [Installation instructions](#installation)
</details>

&nbsp;

<details>     
   <summary><picture><img style="float: right;" src="https://img.icons8.com/external-xnimrodx-lineal-color-xnimrodx/96/null/external-guide-education-xnimrodx-lineal-color-xnimrodx.png" width="60" height="60"/></picture><h1> &nbsp; Usage Guides<h1></summary>

&nbsp;

### Install KernelSU Manager:
[<img src="https://img.shields.io/badge/-How%20to%20install%20KernelSU%20Manager-474154?style=for-the-badge&logoColor=white&logo=github" />](Guides/KernelSU.md)

### Install BusyBox:
[<img src="https://img.shields.io/badge/-How%20to%20install%20BusyBox-474154?style=for-the-badge&logoColor=white&logo=github" />](Guides/BusyBox.md)

### Check Integrity Guide:
[<img src="https://img.shields.io/badge/-HOW%20TO%20CHECK%20INTEGRITY%20OF%20DOWNLOAD%20PACKAGES-474154?style=for-the-badge&logoColor=white&logo=github" />](Guides/Checksum.md)

### GPU Guide:
[<img src="https://img.shields.io/badge/-How%20to%20Change%20the%20GPU%20Used-474154?style=for-the-badge&logoColor=white&logo=github" />](Guides/ChangingGPU.md)

### Sideload Guide:
[<img src="https://img.shields.io/badge/-How%20to%20Sideload%20apps-474154?style=for-the-badge&logoColor=white&logo=github" />](Guides/Sideloading.md)

### Moving WSA to another drive or partition:
[<img src="https://img.shields.io/badge/-How%20to%20Move%20WSA%20to%20another%20drive%20or%20partition-474154?style=for-the-badge&logoColor=white&logo=github" />](Guides/MoveToExtDrive.md)

### LocalHost Loopback Guide:
[<img src="https://img.shields.io/badge/-How%20to%20connect%20WSA%20to%20the%20localhost-474154?style=for-the-badge&logoColor=white&logo=github" />](Guides/LocalHostLoopback.md)

</details> 

&nbsp;

<details>     
   <summary><picture><img style="float: right;" src="https://img.icons8.com/external-soft-fill-juicy-fish/96/null/external-bug-coding-and-development-soft-fill-soft-fill-juicy-fish-2.png" width="60" height="60"/></picture><h1> &nbsp; Having Issues?<h1></summary>

### Common Issues:

[<img src="https://img.shields.io/badge/-Fix%20Install.ps1%20Issue-%23EF2D5E?style=for-the-badge&logoColor=white&logo=Github" />](Fixes/FixInstallps1.md)

[<img src="https://img.shields.io/badge/-Fix%20Install.ps1%20Failed%20to%20update-%23EF2D5E?style=for-the-badge&logoColor=white&logo=Github" />](Fixes/nstallPs1FailedToUpdate.md)

[<img src="https://img.shields.io/badge/-Fix Virtualization and Virtual Machine Platform Error-%23EF2D5E?style=for-the-badge&logoColor=white&logo=github" />](Fixes/FixVirtError.md)

[<img src="https://img.shields.io/badge/-Fix%20Internet%20Issues-%23EF2D5E?style=for-the-badge&logoColor=white&logo=Github" />](Fixes/FixInternet.md)
      
[<img src="https://img.shields.io/badge/-Fix%20Error%200x80073CF0-%23EF2D5E?style=for-the-badge&logoColor=white&logo=Github" />](Fixes/Fix%20Error%200x80073CF0.md)

[<img src="https://img.shields.io/badge/-Fix%20Error%200x80073CFD-%23EF2D5E?style=for-the-badge&logoColor=white&logo=Github" />](Fixes/Fix%20Error%200x80073CFD.md)

[<img src="https://img.shields.io/badge/-Fix%20Error%200x80073CF6-%23EF2D5E?style=for-the-badge&logoColor=white&logo=Github" />](Fixes/Fix%20Error%200x80073CF6.md)

[<img src="https://img.shields.io/badge/-Fix%20Error%200x80073CF9-%23EF2D5E?style=for-the-badge&logoColor=white&logo=Github" />](Fixes/Fix%20Error%200x80073CF9.md)

[<img src="https://img.shields.io/badge/-Fix%20Error%200x80073D10-%23EF2D5E?style=for-the-badge&logoColor=white&logo=Github" />](Fixes/Fix%20Error%200x80073D10.md)

[<img src="https://img.shields.io/badge/-Fix%20Error%200x80073CFB-%23EF2D5E?style=for-the-badge&logoColor=white&logo=Github" />](Fixes/Fix%20Error%200x80073CFB.md)

[<img src="https://img.shields.io/badge/-Fix%20Path%20Too%20Long-%23EF2D5E?style=for-the-badge&logoColor=white&logo=Github" />](Fixes/FixPathTooLong.md)

[<img src="https://img.shields.io/badge/-Fix%20Missing%20Icons%20Issue-%23EF2D5E?style=for-the-badge&logoColor=white&logo=Github" />](Fixes/MissingIcons.md)

[<img src="https://img.shields.io/badge/-Fix%20Target%20Machine%20Actively%20Refused%20Connection-%23EF2D5E?style=for-the-badge&logoColor=white&logo=Github" />](Fixes/TargetMachineActivelyRefusedConnection.md)

[<img src="https://img.shields.io/badge/-Fix%20Target%20Machine%20Actively%20Refused%20Connection-%23EF2D5E?style=for-the-badge&logoColor=white&logo=Github" />](Fixes/TargetMachineActivelyRefusedConnection.md)

[<img src="https://img.shields.io/badge/-Fix%20Internet%20security%20settings%20blocked%20from%20opening-%23EF2D5E?style=for-the-badge&logoColor=white&logo=Github" />](Fixes/InternetSecuritySettingsBlock.md)

[<img src="https://img.shields.io/badge/-Cannot%20sign%20in%20to%20Google%20Account-%23EF2D5E?style=for-the-badge&logoColor=white&logo=Github" />](Fixes/Google%20Play%20Issues.md)

[<img src="https://img.shields.io/badge/-WSA%20Settings%20App%20Crashes%20%2B%20Android%20Apps%20Do%20Not%20Load%20After%20Installation-%23EF2D5E?style=for-the-badge&logoColor=white&logo=Github" />](Fixes/WSA%20Settings%20App%20Crashes%20%2B%20Android%20Apps%20Do%20Not%20Load%20After%20Installation.md
)

[<img src="https://img.shields.io/badge/-WSA Does Not Load After Install %2B No Splashscreen-%23EF2D5E?style=for-the-badge&logoColor=white&logo=Github" />](Fixes/WSA%20Does%20Not%20Load%20After%20Install%20%2B%20No%20Splashscreen.md)

[<img src="https://img.shields.io/badge/-Keyboard%20Is%20Not%20Working-%23EF2D5E?style=for-the-badge&logoColor=white&logo=Github" />](Fixes/Keyboard%20Is%20Not%20Working.md)   

</details>  

&nbsp;      
      
<details>     
   <summary><picture><img style="float: right;" src="https://img.icons8.com/external-flaticons-lineal-color-flat-icons/64/null/external-credits-movie-theater-flaticons-lineal-color-flat-icons.png" width="60" height="60"/></picture><h1> &nbsp; Credits<h1></summary>

- [Microsoft](https://apps.microsoft.com/store/detail/windows-subsystem-for-android%E2%84%A2-with-amazon-appstore/9P3395VX91NR): For providing Windows Subsystem For Android™ and related files. Windows Subsystem For Android™, Windows Subsystem For Android™ Logo, Windows™ 10 and Windows™ 11 Logos are trademarks of Microsoft Corporation. Microsoft Corporation reserves all rights to these trademarks. By downloading and installing Windows Subsystem For Android™, you agree to the [Terms and Conditions](https://support.microsoft.com/en-gb/windows/microsoft-software-license-terms-microsoft-windows-subsystem-for-android-cf8dfb03-ba62-4daa-b7f3-e2cb18f968ad) and [Privacy Policy](https://privacy.microsoft.com/en-gb/privacystatement)
- [Cinit and the WSAPatch Guide](https://github.com/cinit/WSAPatch): Many thanks for the comprehensive guide, files and support provided by Cinit and the contributers at the WSAPatch repository. Windows™ 10 Builds in this repo rely on the hard work of this project and  hence credit is given where due
- [StoreLib](https://github.com/StoreDev/StoreLib): API for downloading WSA
- [Magisk](https://github.com/topjohnwu/Magisk): The Magic Mask for Android
- [KernelSU](https://github.com/tiann/KernelSU): A Kernel based root solution for Android
- [MagiskOnWSALocal](https://github.com/LSPosed/MagiskOnWSALocal): Integrate Magisk root and Google Apps into WSA
- [WSAOnWin10](https://github.com/A-JiuA/WSAOnWin10): Integrate Magisk root and Google Apps into WSA (Windows Subsystem for Android) and make it run on **Windows 10** with GitHub Actions

***The repository is provided as a utility.***

***Android is a trademark of Google LLC. Windows™ is a trademark of Microsoft LLC.***

</details> 
