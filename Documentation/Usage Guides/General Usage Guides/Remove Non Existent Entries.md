# WSABuilds &nbsp; &nbsp; <img src="https://img.shields.io/github/downloads/MustardChef/WSABuilds/total?label=Total%20Downloads&style=for-the-badge"/> &nbsp; 

## Guide: Removing entries of apps that do not exist

### Preface:
##### Sometimes, switching from a WSA Build with Amazon Appstore to a build with "Removed Amazon Appstore" or a build with "MindTheGapps" to a build with "No-Gapps" etc., the system apps that were installed (either Google Play Store and related apps and/or the Amazon Appstore) from the previous build may still show up in the WSA Settings's "Apps" section. This guide goes through a method by which you can remove these entries from the WSA Settings's "Apps" section.

##### Sometimes after uninstalling WSA completely, apps still show up on Add and Remove programs or third-party uninstallers/app managers

<br />
<br />

### Example:
<img src="https://github.com/MustardChef/WSABuilds/assets/68516357/695fc699-3ee9-4687-98a7-905ae9f6a3ec">

![image](https://github.com/MustardChef/WSABuilds/assets/68516357/0d214864-9d46-48e0-8c57-17ccdcefb2e7)

---

<br />


## Steps:

#### 1. Open Registry Editor (regedit.exe) as Administrator
#### 2. Navigate to `Computer\HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall`
#### 3. You will find all the entries from WSA apps here. Search for the app you want to remove from the WSA Settings's "Apps" section.
#### 4. Once you find the entry, delete it.
#### 5. Repeat steps 3 and 4 for all the apps you want to remove from the WSA Settings's "Apps" section.
#### 6. Restart your PC.
#### 7. The apps you deleted the entries of should no longer show up in the WSA Settings's "Apps" section.

<br />

### Hope this helps!

<br />

---

## Have futher question or need help?

#### Join the Discord if you have any other questions or need help!

[<img src="https://invidget.switchblade.xyz/2thee7zzHZ" style="width: 400px;"/>](https://discord.gg/2thee7zzHZ)
