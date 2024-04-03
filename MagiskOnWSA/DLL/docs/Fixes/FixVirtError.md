## Issues:

<img src="https://user-images.githubusercontent.com/68629435/213985345-a6fc6e97-63f3-4741-8965-8d62a0d6b824.png"/>

## Solution: 

You may encounter this problem, even if Virtualization is enabled on your PC (in the BIOS) and shows up as enabled in Task Manager (as seen below) and Virtual Machine Platform + Windows Hypervisor Platform is Enabled. The solution is:

1. ***Remove WSA***: Right clicking on "Windows Subsystem for Android™ Settings" and pressing uninstall + Deleting the extracted WSA (MagiskOnWSA/WSABuilds) folder that you extracted and installed from.

2. ***Go to "Turn Windows features on and off" and if any of these features below are enabled, DISABLE THEM.***

- Hyper-V
- Virtual Machine Platform
- Windows Hypervisor Platform
- Windows Subsystem for Linux

3. ***Restart your PC***

4. ***Boot into your BIOS, and DISABLE Virtualization.***

    - ***[Click here for a guide for Windows 11](https://support.microsoft.com/en-us/windows/enable-virtualization-on-windows-11-pcs-c5578302-6e43-4b4b-a449-8ced115f58e1)***
    - ***[Click here for a guide for Windows 10](https://support.microsoft.com/en-us/windows/enable-virtualization-on-windows-10-pcs-c5578302-6e43-4b4b-a449-8ced115f58e1)***

5. ***Ensure that you have Control Flow Guard enabled in Windows Security > Apps & browser control > Exploit protection.*** This is a known issue that can prevent WSA from starting

6.  ***In registry editor (regedit), go to “\HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\FsDepends"***

    Change the value of “Start” from “3” to “0”

> **Note**
> You can change it back to 3, if it makes no difference

7. ***Then in CMD (Run as Adminstrator), paste:***

```cmd
bcdedit /set hypervisorlaunchtype auto
```

8. ***ENABLE the features that you disabled in ``Step 2`` and restart a second time.*** 

9. ***Boot into your BIOS, and ENABLE Virtualization.***

    - ***[Click here for a guide for Windows 11](https://support.microsoft.com/en-us/windows/enable-virtualization-on-windows-11-pcs-c5578302-6e43-4b4b-a449-8ced115f58e1)***
    - ***[Click here for a guide for Windows 10](https://support.microsoft.com/en-us/windows/enable-virtualization-on-windows-10-pcs-c5578302-6e43-4b4b-a449-8ced115f58e1)***

10. ***Restart the Computer***

11. ***Reinstall WSA by running `Run.bat`***

**Hope this works for you!**
