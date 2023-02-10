# WSABuilds &nbsp; &nbsp; <img src="https://img.shields.io/github/downloads/MustardChef/WSABuilds/total?label=Total%20Downloads&style=for-the-badge"/> &nbsp; 


## Guide: Moving/Installing Windows Subsystem For Android™ (WSA) to another partition or disk 

### Preface:
##### WSA can take up a lot of storage space, hence you want to move it to another partition or disk with more space. <br> This guide goes through a method by which you can install WSA from another disk and to store the data in that drive (instead of "%LOCALAPPDATA%\Packages\MicrosoftCorporationII.WindowsSubsystemForAndroid_8wekyb3d8bbwe"). 

### Prerequisites:
- The partition/ disk that you want to move/install Windows Subsystem For Android™ to, ****MUST**** be **NTFS**
- Recommended that both disks, C:/ and the disk/partition that you want to install (move) WSA on (to), are SSDs 
    - HDDs may work, but performance issues may arise
- Basic knowledge on Command Prompt (CMD) usage
- There must be enough space on the disk/partiton that you are installing/moving WSA to (recommended 20GB, as the VHDX can become very large in size)

> **Note** 
> 
> If you want to preseve your data, make a backup of the `%LOCALAPPDATA%\Packages\MicrosoftCorporationII.WindowsSubsystemForAndroid_8wekyb3d8bbwe\LocalCache\userdata.vhdx` file. After uninstalling, copy the VHDX file back to the `%LOCALAPPDATA%\Packages\MicrosoftCorporationII.WindowsSubsystemForAndroid_8wekyb3d8bbwe\LocalCache` folder.


## Process:


- ### Step 1: Remove all previous installations from WSABuilds or official WSA Releases
    - To remove WSA installed through WSABuild:

        - **1.)** Make sure that Windows Subsystem For Android™ is not running
        - **2.)** Search for ``Windows Subsystem For Android™ Settings`` using the built-in Windows Search, or through Add and Remove Programs and press uninstall
        - **3.)** Delete the WSA folder that you extracted and Run.bat was run from to install WSA (MagiskOnWSA folder)
        - **4.)** Go to ``%LOCALAPPDATA%/Packages/`` and delete the folder named ``MicrosoftCorporationII.WindowsSubsystemForAndroid_8wekyb3d8bbwe``
            
            - If you get an error that states that the file(s) could not be deleted, make sure that WSA is turned off
     
    - To remove WSA installed from the Microsoft Store: 
        
        - **1.)** Search for ``Windows Subsystem For Android™ Settings`` using the built-in Windows Search, or through Add and Remove Programs and press uninstall


- ### Step 2: Install WSA from the desired partition 
    - **1.)** Download the latest WSA Build according to Windows Version and CPU Archtecture from [Downloads](https://github.com/MustardChef/WSABuilds#downloads)
    - **2.)** Extract to the desired partition or drive
    -  Using the same process as detailed in [Installation](https://github.com/MustardChef/WSABuilds/edit/master/README.md#--installation)
    - **3.)** Open the extracted folder and run ``Run.bat``
 

- ### Step 3: Moving the AppData (VHDX + data) from your Windows drive (C:\) to the desired partition/drive
     - **1.)** Go to ``%LOCALAPPDATA%\Packages\`` and copy the folder named ``MicrosoftCorporationII.WindowsSubsystemForAndroid_8wekyb3d8bbwe`` to the desired drive/partition, making sure to delete the folder from ``%LOCALAPPDATA%\Packages\`` after copying
     
     - **2.)** Open Command Prompt (Admin) through Windows Terminal (Admin) or directly and run the command:
```shell
mklink /J "%LOCALAPPDATA%\Packages\MicrosoftCorporationII.WindowsSubsystemForAndroid_8wekyb3d8bbwe" "Location_Of_Folder_In_Other_Drive"
```
Replacing Location_Of_Folder_In_Other_Drive with the location of the folder named ``MicrosoftCorporationII.WindowsSubsystemForAndroid_8wekyb3d8bbwe``, copied to the desired to the drive/partition in 1st point of Step 3

- ### Step 4: Testing if everything is working
    - Run Windows Subsystem For Android™ Settings
        - If it crashes, you have made a mistake whilst following the guide. Try following it again. 
    
    
### If you find yourself stuck, or do not understand any steps in the guide, Join the Discord and ask here:
[<img src="https://invidget.switchblade.xyz/2thee7zzHZ" style="width: 400px;"/>](https://discord.gg/2thee7zzHZ) 
          
