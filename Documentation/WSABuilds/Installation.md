# WSABuilds &nbsp; &nbsp; <img src="https://img.shields.io/github/downloads/MustardChef/WSABuilds/total?label=Total%20Downloads&style=for-the-badge"/> &nbsp; 


<picture><img style="float: left;" src="https://img.icons8.com/color/96/null/software-installer.png" width="60" height="60"/></picture><h1> &nbsp; Installation</h1>

<br/>


> [!NOTE]
> 
> If you have the official Windows Subsystem For Android™ installed, you must [completely uninstall](#uninstallation) it to use MagiskOnWSA. 

> [!IMPORTANT]
> 
> In case you want to preserve your data from the previous installation (official or MagiskOnWSA), you can backup Userdata.vhdx, located at ``%LOCALAPPDATA%\Packages\MicrosoftCorporationII.WindowsSubsystemForAndroid_8wekyb3d8bbwe\LocalCache\userdata.vhdx`` before uninstallation and restore it after installation. A guide for this process is located further down in this README.

---

### Video Guide:
##### Special Thanks to kilObit (creator of the video)
<a href="https://www.youtube.com/watch?v=11lw-IHPH3A"><img src="https://github.com/MustardChef/WSABuilds/assets/68516357/68874bad-9f71-436b-a35b-f06eb7f9fa57" style="float: left;" height="40%" width="40%"/>

---

### Text Guide:
1. Go to the [Releases page](https://github.com/MustardChef/WSABuilds/releases/latest)
2. In the latest release, go to the Assets section and download the Windows Subsystem For Android™ version of your choosing (do not download "Source code")
3. Extract the .7z archive and rename the folder (that you extracted) to ``WSA``
4. Delete the .7z archive
5. Move the newly extracted folder to a suitable location (Documents folder is a good choice), as you will need to keep the folder on your PC to use MagiskOnWSA

> [!NOTE]   
> If you're updating WSA, merge the folders and replace the files for all items when asked

6. Open the Windows Subsystem For Android™ folder: Search for and double-click `Run.bat`
   - If you previously have a MagiskOnWSA installation, it will automatically uninstall the previous one while preserving all user data and install the new one, so don't worry about your data.
   - If the popup windows disappear without asking administrative permission and Windows Subsystem For Android™ is not installed successfully, you should manually run Install.ps1 as administrator:
      
      - Press Win+x and select Windows™ Terminal (Admin)
      
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
      
7. Once the installation process completes, Windows Subsystem For Android™ will launch (if this is a first-time install, a window asking for consent to diagnositic information will be shown instead. Sometimes two identical windows will show, this is fine and nothing bad happens if you click OK in both windows)
8. Click on the PowerShell window, then press any key on the keyboard, the PowerShell window should close
9. Close File Explorer
10. **Enjoy**

--- 

### Notice (Applicable for both Windows 10 and 11):

1. You can NOT delete the Windows Subsystem For Android™ installation folder.
   What `Add-AppxPackage -Register .\AppxManifest.xml` does is to register an appx package with some existing unpackaged files,
   so you need to keep them as long as you want to use Windows Subsystem For Android™. 
   Check https://learn.microsoft.com/en-us/powershell/module/appx/add-appxpackage?view=windowsserver2022-ps for more details.
2. You need to register your Windows Subsystem For Android™ appx package before you can run Windows Subsystem For Android™. 
   For [WSABuilds](https://github.com/MustardChef/WSABuilds) and [MagiskOnWSALocal](https://github.com/LSPosed/MagiskOnWSALocal) users, you need to run `Run.bat` in the extracted dir.
   If the script fails, you can take the following steps for diagnosis (admin privilege required):
    1. Open a PowerShell window and change working directory to your Windows Subsystem For Android™ directory.
    
    2. Run the command below in PowerShell. This should fail with an ActivityID, which is a UUID required for the next step.
       ```Powershell
       Add-AppxPackage -ForceApplicationShutdown -ForceUpdateFromAnyVersion -Register .\AppxManifest.xml
       ```
       
    3. Run the command below in PowerShell. This should print the log of the failed operation.
       ```Powershell
       Get-AppPackageLog -ActivityID <uuid>
       ```
    4. Check the log for the reason of failure and fix it.
