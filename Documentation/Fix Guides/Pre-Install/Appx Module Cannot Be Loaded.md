# WSABuilds &nbsp; &nbsp; <img src="https://img.shields.io/github/downloads/MustardChef/WSABuilds/total?label=Total%20Downloads&style=for-the-badge"/> &nbsp; 

## Error: 
#### The 'Get-AppxPackage' command was found in the module 'Appx', but the module could not be loaded due to the following error: [Operation is not supported on this platform. (0x80131539)] For more information, run 'Import-Module Appx'

<br />

---


## Preface:
#### This issue mainly occurs on the LTSC and non official builds of Windows. 

<br />

---



## Solution:

#### 1. Open PowerShell as Administrator
#### 2. Run the following command: 
```powershell
cd <lLocation of the folder with the WSA files>
Import-Module -Name Appx -UseWindowsPowerShell
PowerShell.exe -ExecutionPolicy Bypass -File .\Install.ps1
```

<br />
<br />

---

## Have futher question or need help?

#### Join the Discord if you have any other questions or need help!

[<img src="https://invidget.switchblade.xyz/2thee7zzHZ" style="width: 400px;"/>](https://discord.gg/2thee7zzHZ)


