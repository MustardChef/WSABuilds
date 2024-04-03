## Issue: </br> Error stating that "Path is too long" when extracting files from .zip archive, needed to install Windows Subystem for Android (WSA)
### Preface:
##### This issue is caused if the folder name is too long. This is the typically the case as MagiskOnWSALocal script tends to generate a long string for the .zip file and the folder within the archive.

<img src="https://user-images.githubusercontent.com/68516357/219853616-154615b8-125c-4b68-b2f7-43fc2f7b1f74.png" style="width: 600px;"/>  

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
