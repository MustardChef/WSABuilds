# Check integrity of downloaded file


### **1. Press Win + X on your keyboard and select Windows™ Terminal (Admin) or Powershell (Admin) depending on the version of Windows™ you are running**

|||
|--------|------|
|<img src="https://upload.wikimedia.org/wikipedia/commons/e/e6/Windows_11_logo.svg" style="width: 200px;"/> |<img src="https://upload.wikimedia.org/wikipedia/commons/0/05/Windows_10_Logo.svg" style="width: 200px;"/> |
|![215262254-7466d964-3956-4d71-8014-e2c5869ca4d4](https://user-images.githubusercontent.com/68516357/215263173-500591dd-c6d5-4c2d-9d38-58bc065fff28.png)|![winx_editor-1](https://user-images.githubusercontent.com/68516357/215263348-022dc031-802f-4e93-8999-05d0aa6744b9.png)|

&nbsp;    
### **2. Input the command below and press enter, replacing {X:\path\to\your\downloaded\archive\package} including the {} with the path of the downloaded archive package**
    
```Powershell
  cd "{X:\path\to\your\downloaded\archive\package}"
```
&nbsp; 
### **3. Input the command below and press enter, replacing WSA_2XXX.XXXXX.X.X_XXXX_Release-Nightly-with-magisk-XXXXXXX-XXXXXX-MindTheGapps-XX.X-RemovedAmazon with the name of the archive package** 
    
```Powershell
  certutil -hashfile "WSA_2XXX.XXXXX.X.X_XXXX_Release-Nightly-with-magisk-XXXXXXX-XXXXXX-MindTheGapps-XX.X-RemovedAmazon" SHA256
```
For PowerShell:
```PowerShell
  (Get-FileHash -Path "WSA_2XXX.XXXXX.X.X_XXXX_Release-Nightly-with-magisk-XXXXXXX-XXXXXX-MindTheGapps-XX.X-RemovedAmazon" -Algorithm SHA256).Hash
```
&nbsp;  

### **4. Compare the SHA256 output with ones at [Release](https://github.com/YT-Advanced/WSA-Script/releases/latest) or in the `sha256-checksum.txt` (if you download artifact from the Custom Build task).** 
- If package don't have the same SHA-256 Hash, please download then check again.
- If package have the same SHA-256, install it by [Following this guide](https://github.com/YT-Advanced/WSA-Script#--installation)
