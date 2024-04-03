## Issue: </br> Error 0x80073CF0 when "Run.bat" is executed to install Windows Subystem for Android (WSA)
### Preface:
##### This issue can arise due to many factors such as corruption of files when downloading the .zip/.7z files or extracting from the .zip/.7z files. This can be also caused if the folder name is too long (This is the case as MagiskOnWSA tends to generate a long string for the .zip/.7z file and the folder within the archive.)

![imageCF0](https://user-images.githubusercontent.com/68516357/232593575-20db5482-a0e3-472d-875c-37d248ccfca2.png)


---
## Solution

**1. Ensure the partition/drive you are installing from is NTFS**

<br>

**2. Redownload WSA Build .zip/.7z file from the [Releases page](https://github.com/MustardChef/WSABuilds/releases) (sometime the files can be corrupted during download and extraction)**

<br>

**3. Rename the .zip/.7z  file to a shorter name, which can be anything to your choosing </br> (For example: WSA_2XXX.XXXXX.X.X_XXXX_Release-Nightly-with-magisk-XXXXXXX-XXXXXX-MindTheGapps-XX.X-RemovedAmazon ----> WSAArchive2XXX)**

<br>

**4. Extract the .zip or .7z archive (depends on the release) using 7-zip or a proper archive tool and not the built in Windows archive extractor** 

<br>

**5. Rename the extracted folder(s) to a shorter name, which can be anything to your choosing** 

#### For example: 
- **Before:** WSA_2XXX.XXXXX.X.X_XXXX_Release-Nightly-with-magisk-XXXXXXX-XXXXXX-MindTheGapps-XX.X-RemovedAmazon
- **After:** WSAExtracted2XXX

<br>

**6. Ensure that 'Run.bat' is run as Administrator**

**Hope this works for you!**

