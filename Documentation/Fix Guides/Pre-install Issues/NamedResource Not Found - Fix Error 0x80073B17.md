# WSABuilds &nbsp; &nbsp; <img src="https://img.shields.io/github/downloads/MustardChef/WSABuilds/total?label=Total%20Downloads&style=for-the-badge"/> &nbsp; 

---
## Issue: <br /> Error 0x80073B17 when "Run.bat" is executed to install Windows Subystem for Android (WSA)
### Preface:
##### This issue is caused/ associated with the Language Resource creation step which has moved from being processed within the Linux Bash script to a Windows PowerShell script ``MakePri.ps1/MakePri.exe``. Hence this may be caused by ``MakePri.ps1`` failing to run, and the reason for your installation failure is that the content of ``resources.pri`` is incorrect.

<img src="https://user-images.githubusercontent.com/68516357/227787886-ab415c59-38b5-481a-ac16-65d8fed67c81.png" style="width: 800px;"/>  

---

<details>     
   <summary><h2>Main Solution:<h2></summary>

#### This issue should have been fix as of the latest builds on the WSABuild releases and [this commit](https://github.com/LSPosed/MagiskOnWSALocal/commit/975bdcf4d82ef6fbca53ad5b7ea20380fcd94fdd) for [MagiskOnWSALocal](https://github.com/LSPosed/MagiskOnWSALocal/) 

#### Make sure that you delete the extracted WSA folder and download the latest build from [Releases](https://github.com/MustardChef/WSABuilds/releases). Or make sure to reclone the [MagiskOnWSALocal Repo](https://github.com/LSPosed/MagiskOnWSALocal/) and rebuild. If the issue still persists, report this in [the GitHub Issues of this repo](https://github.com/MustardChef/WSABuilds/issues) or to the [Github Issues of the MagiskOnWSALocal Repo](https://github.com/LSPosed/MagiskOnWSALocal/issues)
     
</details>     



<details>     
   <summary><h2>Temporary Solution 1 (if the above permanent fixes do not work):<h2></summary>

---
### If you don't need localization and only English for WSA Settings you can follow the steps below
1. You'll will need to delete the folder for this failed installation and regenerate it (rebuild and reextract)
2. Delete ``resources.pri`` before running the install script, ``Run.bat or Install.ps1``
3. Delete it form filelist.txt to skip the check

---

</details>
     
<details>     
   <summary><h2>Temporary Solution 2 (if the above permanent fixes do not work):<h2></summary>

---
### If you do need localization and language other than English for WSA Settings you can follow the steps below:
### Get the latest build with Language resources already merged and follow the normal [installation process](https://github.com/MustardChef/WSABuilds#--installation):
   

</details> 



<br />

---

## Have futher question or need help?

#### Join the Discord if you have any other questions or need help!

[<img src="https://invidget.switchblade.xyz/2thee7zzHZ" style="width: 400px;"/>](https://discord.gg/2thee7zzHZ)
