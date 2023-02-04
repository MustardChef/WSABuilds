# WSABuilds &nbsp; &nbsp; <img src="https://img.shields.io/github/downloads/MustardChef/WSABuilds/total?label=Total%20Downloads&style=for-the-badge"/> &nbsp; 


## Guide: Moving/Installing Windows Subsystem For Android™ (WSA) to another partition or disk 

### Preface: 
##### WSA can take up a lot of storage space, hence you want to move it to another partition or disk with more space. <br> This guide goes through a method by which you can install WSA from another disk and to store the data in that drive (instead of "%LOCALAPPDATA%\Packages\MicrosoftCorporationII.WindowsSubsystemForAndroid_8wekyb3d8bbwe"). 

### Prerequisites:
- The partition/ disk that you want to install Windows Subsystem For Android™ ****MUST**** be **NTFS**
- Recommended that both disks, C:/ and the disk/partition that you want to install (move) WSA on (to), are SSDs 
    - HDDs may work, but performance issues may arise
- Basic knowledge on Command Prompt (CMD) usage
- There must be enough space on the disk/partiton that you are installing/moving WSA to (recommended 20GB as the VHDX can become very large in size)
