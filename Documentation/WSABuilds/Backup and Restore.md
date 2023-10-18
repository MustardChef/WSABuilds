# WSABuilds &nbsp; &nbsp; <img src="https://img.shields.io/github/downloads/MustardChef/WSABuilds/total?label=Total%20Downloads&style=for-the-badge"/> &nbsp; 

<picture><img style="float: left;" src="https://img.icons8.com/fluency/96/cloud-backup-restore.png" width="60" height="60"/></picture><h1> &nbsp; Backup and Restore Userdata</h1>

## Backing Up Your Userdata
      
In order to make a backup of your WSA data you must copy the ``Userdata.vhdx`` (which includes, but is not limited Android Apps and their data, settings etc.), located at ``%LOCALAPPDATA%\Packages\MicrosoftCorporationII.WindowsSubsystemForAndroid_8wekyb3d8bbwe\LocalCache\userdata.vhdx``, to a safe location     
      
## Restoring Your Backup

Before attempting to restore your backup, you must remove WSA if installed. Then before you run the ``Run.bat`` script (to reinstall WSA after removing it), you need to remove these lines from ``Install.ps1``, located in the your extracted WSA folder:
      
&nbsp;
      
> <picture>
>   <source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/Mqxx/GitHub-Markdown/main/blockquotes/badge/light-theme/tip.svg">
>   <img alt="Tip" src="https://raw.githubusercontent.com/Mqxx/GitHub-Markdown/main/blockquotes/badge/dark-theme/tip.svg">
> </picture><br />
>     
> The Lines (as shown below) that you need to remove in ``Install.ps1`` may vary depending on the type of WSA Build that you are trying to install.    
      
&nbsp;

Android Settings:
```pwsh
Start-Process "wsa://com.android.settings"
```
Official Magisk:
```pwsh
Start-Process "wsa://com.topjohnwu.magisk"
```
Magisk Delta:
```pwsh
Start-Process "wsa://io.github.huskydg.magisk"
```
Magisk Alpha:
```pwsh
Start-Process "wsa://io.github.vvb2060.magisk"
```
Google Play Store:
```pwsh
Start-Process "wsa://com.android.vending"
```
Amazon Appstore:
```pwsh
Start-Process "wsa://com.amazon.venezia"
``` 

After removing the lines above, run the script. 

When the Powershell window states "Press any key to quit", at that time multiple dialogue boxes will open:

<-- <add Images here> -->

> [!IMPORTANT]
> ****Ignore these and do not click on anything or close these popups****

Go to ``%localappdata%\Packages`` and (if these folders/directory do not exist, create them) in ``MicrosoftCorporationII.WindowsSubsystemForAndroid_8wekyb3d8bbwe\LocalCache\`` paste the userdata.vhdx

Now close the popups and run WSA and your userdata should hopefully be restored