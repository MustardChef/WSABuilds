## Issue: </br> Error 0x80073CF9 when "Run.bat" is executed to install Windows Subystem for Android (WSA)
### Preface:
##### This issue can arise due to many factors such as corruption of files when downloading the .zip files or extracting from the .zip files. This can be also caused if the folder name is too long (This is the case as MagiskOnWSA tends to generate a long string for the .zip file and the folder within the archive.)

<img src="https://user-images.githubusercontent.com/68516357/219852713-fde4520d-9fa8-4c8b-80e6-ac2adecbeae9.png" style="width: 600px;"/>  

---
## Solution

**1. Ensure the partition/drive you are installing from is NTFS**

**2. Redownload WSA .zip file on [Release page](https://github.com/YT-Advanced/WSA-Script/releases/latest) (sometime the files can be corrupted during download and extraction)**

**3. Rename the .zip folder to a shorter name, which can be anything to your choosing </br> (WSA_2xxx.xxxxx.xx.x_x64_Release-Nightly-with-magisk-xxxxxxx-MindTheGapps-13.0-as-Pixel-5-RemovedAmazon ----> WSAArchive2XXX)**

**4. Extract the .zip using WinRAR or a proper archive tool and not the built in Windows .zip extractor** 

**5. Rename the extracted folder(s) to a shorter name, which can be anything to your choosing** 

#### For example: 
- **Before:** WSA_2XXX.XXXXX.X.X_XXXX_Release-Nightly-with-magisk-XXXXXXX-XXXXXX-MindTheGapps-XX.X-RemovedAmazon
- **After:** WSAExtracted2XXX

**6. Ensure that 'Run.bat' is run as Administrator**

**Hope this works for you!**
