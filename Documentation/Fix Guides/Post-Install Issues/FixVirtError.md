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

1. ***Remove WSA***: Right clicking on "Windows Subsystem for Android™ Settings" and pressing uninstall + Deleting the extracted WSA (MagiskOnWSA/WSABuilds) folder that you extracted and installed from.

2. ***Go to "Turn Windows features on and off" and if any of these features below are enabled, DISABLE THEM.***

- Hyper-V
- Virtual Machine Platform
- Windows Hypervisor Platform
- Windows Subsystem for Linux

&nbsp;

3. ***Restart your PC***

&nbsp;

4. ***Boot into your BIOS, and DISABLE Virtualization.***

    - ***[Click here for a guide for Windows 11](https://support.microsoft.com/en-us/windows/enable-virtualization-on-windows-11-pcs-c5578302-6e43-4b4b-a449-8ced115f58e1)***
    - ***[Click here for a guide for Windows 10](https://support.microsoft.com/en-us/windows/enable-virtualization-on-windows-10-pcs-c5578302-6e43-4b4b-a449-8ced115f58e1)***

&nbsp;

5. ***Ensure that you have Control Flow Guard enabled in Windows Security > Apps & browser control > Exploit protection.*** This is a known issue that can prevent WSA from starting

&nbsp;

6.  ***In registry editor (regedit), go to “\HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\FsDepends"***

    Change the value of “Start” from “3” to “0”

> **Note**
> You can change it back to 3, if it makes no difference

&nbsp;

7. ***Then in CMD (Run as Adminstrator), paste:***

```cmd
bcdedit /set hypervisorlaunchtype auto
```

&nbsp;

8. ***ENABLE the features that you disabled in ``Step 2`` and restart a second time.*** 

&nbsp;


9. ***Boot into your BIOS, and ENABLE Virtualization.***

    - ***[Click here for a guide for Windows 11](https://support.microsoft.com/en-us/windows/enable-virtualization-on-windows-11-pcs-c5578302-6e43-4b4b-a449-8ced115f58e1)***
    - ***[Click here for a guide for Windows 10](https://support.microsoft.com/en-us/windows/enable-virtualization-on-windows-10-pcs-c5578302-6e43-4b4b-a449-8ced115f58e1)***

&nbsp;

10. ***Restart the Computer***

&nbsp;

11. ***Reinstall WSA by running `Run.bat`***


&nbsp;

**Hope this works for you!**

<br />
<br />

- ### For AtlasOS Users:


    - #### If the steps above still do not fix your issue, go to the AtlasOS configuration folder and run the "Enable Hyper-V and VBS" CMD file. Then restart your PC and try running WSA again  


        <img src="https://github.com/MustardChef/WSABuilds/assets/68516357/1c8ec5b1-b071-4923-9c00-2f7449adf75c" width=70% height=70%>

        <img src="https://github.com/MustardChef/WSABuilds/assets/68516357/738d4850-f7da-4408-b2f5-8483c30e1a9f" alt="Image description">

<br />
<br />

---

## Have futher question or need help?

#### Join the Discord if you have any other questions or need help!

[<img src="https://invidget.switchblade.xyz/2thee7zzHZ" style="width: 400px;"/>](https://discord.gg/2thee7zzHZ)
