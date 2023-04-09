# WSABuilds &nbsp; &nbsp; <img src="https://img.shields.io/github/downloads/MustardChef/WSABuilds/total?label=Total%20Downloads&style=for-the-badge"/> &nbsp; 

---
## Issue: </br> Error: No connection could be made because the target machine actively refused it (10061)
### Preface:
##### This issue occurs when you are either using a sideloading application such as [WSA-Sideloader](https://github.com/infinitepower18/WSA-Sideloader) or [WSAPacman](https://github.com/alesimula/wsa_pacman), or when you try to connect to a device using ``adb.exe`` via [Android SDK Platform Tools](https://developer.android.com/tools/releases/platform-tools). This issue arises due to an issue with the inability of Hyper V to reserve port 58526 causing the issue, as seen below.

![image](https://user-images.githubusercontent.com/68516357/230793765-6c72a7d7-796f-4cb9-8a45-3d40b4f1d38f.png)

```
cannot connect to ||127.0.0.1:58526:|| No connection could be made because the target machine actively refused it. (10061)
```
---

## Solution

This is a [bug](https://github.com/microsoft/WSA/issues/136) with the subsystem itself, restarting the PC will usually fix it.

If you still get this error, try these steps:

1. Make sure WSA is turned off and disable WSA autostart in Task Manager ---> Startup Apps before proceeding

2. Disable Hyper-V using the command ``dism.exe /Online /Disable-Feature:Microsoft-Hyper-V`` and reboot your PC

3. Reserve port 58526 so Hyper-V doesn't reserve it back using the command `netsh int ipv4 add excludedportrange protocol=tcp startport=58526 numberofports=1`

4. Re-enable Hyper-V using the command `dism.exe /Online /Enable-Feature:Microsoft-Hyper-V /All` and reboot your PC

Your issue should be fixed now!

<br/>
<br/>

**Hope this works for you!**

Join the Discord if you have any other questions or need help!

[<img src="https://invidget.switchblade.xyz/2thee7zzHZ" style="width: 400px;"/>](https://discord.gg/2thee7zzHZ)

