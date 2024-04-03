## Guide: LocalHost Loopback
#### Preface: You want to connect WSA to the localhost (Windows 11 hosting machine) or to a development server I run on Windows 11 or any such scenario where you would want to connect to the Windows 11 localhost, but are unable to 

### Note: Localhost Loopback has now been officially added to the update 2308 of WSA, and so this guide is probably outdated now.

---

## Process:

**1.** Run PowerShell as administrator

**2.** Execute 
```powershell
Set-NetFirewallHyperVVMSetting -VMCreatorId '{9E288F02-CE00-4D9E-BE2B-14CE463B0298}' -LoopbackEnabled True
``` 

3.Execute 
```powershell
New-NetFirewallHyperVRule -DisplayName LoopbackAllow -VMCreatorId '{9E288F02-CE00-4D9E-BE2B-14CE463B0298}' -Direction Inbound -Action Allow -LocalPorts [PORT]
```
(replacing [PORT] with the port you're trying to expose)
