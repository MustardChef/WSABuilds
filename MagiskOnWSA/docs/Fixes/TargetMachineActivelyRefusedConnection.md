## Issue: </br> Error: No connection could be made because the target machine actively refused it (10061)
### Preface:
##### This issue occurs when you are either using a sideloading application such as [WSA-Sideloader](https://github.com/infinitepower18/WSA-Sideloader) or [WSAPacman](https://github.com/alesimula/wsa_pacman), or when you try to connect to a device using ``adb.exe`` via [Android SDK Platform Tools](https://developer.android.com/tools/releases/platform-tools). This issue arises due to an issue with the inability of Hyper V to reserve port 58526 causing the issue, as seen below.

![image](https://user-images.githubusercontent.com/68516357/230793765-6c72a7d7-796f-4cb9-8a45-3d40b4f1d38f.png)

```
cannot connect to ||127.0.0.1:58526:|| No connection could be made because the target machine actively refused it. (10061)
```
---

## Solution

This is a [bug](https://github.com/microsoft/WSA/issues/136) with the subsystem itself, restarting the PC will usually fix it. But, if you still get this error, try these steps:

- ##### _**1. Make sure WSA is turned off and disable WSA autostart in Task Manager ---> Startup Apps before proceeding**_

- ##### _**2. Disable Hyper-V (if it is enabled) using the command**_

```powershell
dism.exe /Online /Disable-Feature:Microsoft-Hyper-V
```

- ##### **3. Reboot your PC**
 
- ##### _**4. Reserve port 58526 so Hyper-V doesn't reserve it back using the command**_
```cmd
netsh int ipv4 add excludedportrange protocol=tcp startport=58526 numberofports=1
```

- ##### _**5. Re-enable Hyper-V (if it was previously enabled) using the command `dism.exe /Online /Enable-Feature:Microsoft-Hyper-V /All` and reboot your PC**_

**Hope this works for you!**
