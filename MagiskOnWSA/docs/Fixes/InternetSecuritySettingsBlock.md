## Issue: </br> Error stating that "Your Internet security settings prevented one or more files from opening" when trying to run `Install.ps1` or `Run.bat` to install Windows Subystem for Android (WSA)

### Preface:
##### This issue is caused if the folder name is too long. This is the typically the case as MagiskOnWSALocal script tends to generate a long string for the .zip file and the folder within the archive.

<img src="https://github.com/MustardChef/WSABuilds/assets/68516357/b17308cb-6b99-419d-ba79-3119bdbacd9d" style="width: 400px;"/>  

---
## Solution

The solution is simple, all you have to do is:

**1. Rename the .zip/.7z file to a shorter name, which can be anything to your choosing** </br> 

- For example: 

    - **Before:** WSA_2XXX.XXXXX.X.X_XXXX_Release-Nightly-with-magisk-XXXXXXX-XXXXXX-MindTheGapps-XX.X-RemovedAmazon

    - **After:** WSAArchive2XXX

**2. Rename the extracted folder to a shorter name, which can be anything to your choosing** </br> 

- For example:

   - **Before:** WSA_2XXX.XXXXXXX_XXXX_Release-Nightly-with-magisk-XXXXXXX-XXXXXX-MindTheGapps-XX.X-RemovedAmazon 

   - **After:** WSAArchive2XXX

---
