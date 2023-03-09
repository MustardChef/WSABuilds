# WSABuilds &nbsp; &nbsp; <img src="https://img.shields.io/github/downloads/MustardChef/WSABuilds/total?label=Total%20Downloads&style=for-the-badge"/> &nbsp; 

&nbsp;
&nbsp;

## Issues:

&nbsp;
&nbsp;

<img src="https://user-images.githubusercontent.com/68629435/213985345-a6fc6e97-63f3-4741-8965-8d62a0d6b824.png"/>

## Solution: 

You may encounter this problem, even if Virtualization is enabled on your PC (in the BIOS) and shows up as enabled in Task Manager (as seen below) and Virtual Machine Platform + Windows Hypervisor Platform is Enabled. The solution is:

&nbsp;

1. ***Remove WSA***: Right clicking on "Windows Subsystem for Android™ Settings" and pressing uninstall + Deleting the extracted WSA (MagiskOnWSA folder that you extracted and installed from) + Go to %LOCALAPPDATA%/Packages/ and delete the folder: MicrosoftCorporationII.WindowsSubsystemForAndroid_8wekyb3d8bbwe

2. ***Go to "Turn Windows features on and off" and disable Hyper-V, Virtual Machine Platform, Windows Hypervisor Platform, and Windows Subsystem for Linux, then restart.****

3. ***Reenable these features and restart a second time.*** 

4. ***Ensure that you have Control Flow Guard enabled in Windows Security > Apps & browser control > Exploit protection.*** This is a known issue that can prevent WSA from starting

5.  ***In registry editor (regedit), go to “\HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\FsDepends"***

    Change the value of “Start” from “3” to “0”

> **Note**
> You can change it back to 3, if it makes no difference

6. ***Then in CMD (Run as Adminstrator), paste:*** 
```cmd
bcdedit /set hypervisorlaunchtype auto
```

7. ***Restart the Computer***

8. ***Reinstall WSA by running `Run.bat`***


&nbsp;

**Hope this works for you!**

Join the Discord if you have any other questions or need help!

[<img src="https://invidget.switchblade.xyz/2thee7zzHZ" style="width: 400px;"/>](https://discord.gg/2thee7zzHZ)
