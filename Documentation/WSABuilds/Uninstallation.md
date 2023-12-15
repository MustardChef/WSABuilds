# WSABuilds &nbsp; &nbsp; <img src="https://img.shields.io/github/downloads/MustardChef/WSABuilds/total?label=Total%20Downloads&style=for-the-badge"/> &nbsp;

<picture><img style="float: left;" src="https://img.icons8.com/color/96/null/uninstall-programs.png" width="60" height="60"/></picture><h1> &nbsp; Uninstallation</h1>


&nbsp;

> [!NOTE]   
>
> If you want to preseve your data, make a backup of the `%LOCALAPPDATA%\Packages\MicrosoftCorporationII.WindowsSubsystemForAndroid_8wekyb3d8bbwe\LocalCache\userdata.vhdx` file. After uninstalling, copy the VHDX file back to the `%LOCALAPPDATA%\Package\MicrosoftCorporationII.WindowsSubsystemForAndroid_8wekyb3d8bbwe\LocalCache` folder. For a more comprehensive and detailed guide, take a look at the **Backup and Restore section** in this README markdown

### To remove WSA installed through WSABuild:

- **1.)** Make sure that Windows Subsystem For Android™ is not running
<br/>

- **2.)** Search for ``Windows Subsystem For Android™ Settings`` using the built-in Windows Search, or through Add and Remove Programs and press uninstall
  
<br/>

- **3.)** Delete the WSA folder that extracted you extracted and Run.bat was run from to install WSA (MagiskOnWSA folder)

<br/>

- **4.)** Go to ``%LOCALAPPDATA%/Packages/`` and check if the folder: ``MicrosoftCorporationII.WindowsSubsystemForAndroid_8wekyb3d8bbwe`` is still present:
   - If the folder is still present: ****Delete it****
      - If you get an error that states that the file(s) could not be deleted, make sure that WSA is turned off
   - If the folder does not exist: ****Skip this step****
           
<br/>

### To remove WSA installed from the Microsoft Store: 
        
   - **1.)** Search for ``Windows Subsystem For Android™ Settings`` using the built-in Windows Search, or through Add and Remove Programs and press uninstall