# WSABuilds &nbsp; &nbsp; <img src="https://img.shields.io/github/downloads/MustardChef/WSABuilds/total?label=Total%20Downloads&style=for-the-badge"/> &nbsp;

<picture><img style="float: left;" src="https://img.icons8.com/external-flaticons-flat-flat-icons/64/null/external-updating-tools-and-material-ecommerce-flaticons-flat-flat-icons.png" width="60" height="60"/></picture><h1> &nbsp; Updating</h1>

### How do I update without losing any of my apps and data on Windows Subsystem for Android (WSA)

> [!IMPORTANT]
> Make sure that WSA has been turned off from the settings and that tools such has WSA-System-Control, WSA-Sideloader, WSAPacman etc are not running.

1. [Download the latest build](https://github.com/MustardChef/WSABuilds#downloads) (that you want to update to)

2. Make sure Windows Subsystem For Android is not running (Click on "Turn off" in the WSA Settings and wait for the spinning loader to disappear)

2. Using 7-Zip, WinRAR or any other tool of choice, open the .7z archive 

3. Within the .7z archive, open the subfolder 
    - Example: 
        - WSA_2xxx.xxxxx.xx.x_xx 
        
        or 
        
        - WSA_2xxx.xxxxx.xx.x_xx_Release-Nightly-with-magisk-xxxxxxx-MindTheGapps-xx.x-RemovedAmazon)

4. Select all the files that are within this subfolder and extract them to the current folder where the file for Windows Subsystem For Android (the folder you extracted, and installed WSA from) are located 

5. When prompted to replace folders, select "Do this for all current items" and click on "Yes" 

6. When prompted to replace files, click on "Replace the files in the destination"

7. Run  the ``Run.bat`` file

8. Launch Windows Subsystem For Android Settings app and go to the ``About`` tab using the sidebar

9. Check if the WSA version matches the latest version/ the version number that you want to update to

---

### **Join the Discord if you are having any difficulties**

[<img align="left" src="https://invidget.switchblade.xyz/2thee7zzHZ" style="width: 400px;"/>](https://discord.gg/2thee7zzHZ)
