# WSABuilds &nbsp; &nbsp; <img src="https://img.shields.io/github/downloads/MustardChef/WSABuilds/total?label=Total%20Downloads&style=for-the-badge"/> &nbsp; 

## Issue: A Specified Logon Session Does Not Exist

### Preface: 
##### This issue occurs when you are not installing WSA from an admin account. This is due to the [limitations of installing unsigned MSIX on non-Admin accounts](https://github.com/LSPosed/MagiskOnWSALocal/issues/276#issuecomment-1492594872). 
---
### Example:
![image](https://github.com/MustardChef/WSABuilds/assets/68516357/bfe330c2-ddb0-4fd1-98ce-fc1f1ec60a29)

---

## Solution:

<br />

### Make sure that the account that you are installing from is a Windows Administrator account.

#### To check:
- ##### 1. Open CMD
- ##### 2. Type ```net localgroup administrators``` and press enter
- ##### 3. Check if the account you are installing from, exists in the list of accounts in the  "administrators" localgroup.
- ##### 4. If it does not, then you are not installing from an admin account.

<br />

### Make sure that you run ```run.bat``` as Administrator.

### Make sure that you run ```Install.ps1``` as Administrator.
