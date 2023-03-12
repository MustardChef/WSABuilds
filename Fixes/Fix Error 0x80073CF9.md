# WSABuilds &nbsp; &nbsp; <img src="https://img.shields.io/github/downloads/MustardChef/WSABuilds/total?label=Total%20Downloads&style=for-the-badge"/> &nbsp; 

---
## Issue: </br> Error 0x80073CF9 when "Run.bat" is executed to install Windows Subystem for Android (WSA)
### Preface:
##### This issue can arise due to many factors such as corruption of files when downloading the .zip files or extracting from the .zip files. This can be also caused if the folder name is too long (This is the case as MagiskOnWSA tends to generate a long string for the .zip file and the folder within the archive.)

<img src="https://user-images.githubusercontent.com/68516357/219852713-fde4520d-9fa8-4c8b-80e6-ac2adecbeae9.png" style="width: 600px;"/>  

---
## Solution

**1. Ensure the partition/drive you are installing from is NTFS**

**2. Redownload WSA Build .zip file from the [Releases page](https://github.com/MustardChef/WSABuilds/releases) (sometime the files can be corrupted during download and extraction)**

**3. Rename the .zip folder to a shorter name, which can be anything to your choosing </br> (For example: WSA_2XXX.XXXXX.X.X_XXXX_Release-Nightly-with-magisk-XXXXXXX-XXXXXX-MindTheGapps-XX.X-RemovedAmazon ----> WSAArchive2XXX)**

**4. Extract the .zip using WinRAR or a proper archive tool and not the built in Windows .zip extractor** 

**5. Rename the extracted folder to a shorter name, which can be anything to your choosing </br> (For example: WSA_2XXX.XXXXX.X.X_XXXX_Release-Nightly-with-magisk-XXXXXXX-XXXXXX-MindTheGapps-XX.X-RemovedAmazon ----> WSAExtracted2XXX)**

**6. Ensure that 'Run.bat' is run as Administrator**

**Hope this works for you!**

---

### Have futher question or need help?

Join the Discord if you have any other questions or need help!

[<img src="https://invidget.switchblade.xyz/2thee7zzHZ" style="width: 400px;"/>](https://discord.gg/2thee7zzHZ)



