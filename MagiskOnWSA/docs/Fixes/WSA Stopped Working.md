## Issues: WSA Stopped Working! 


![1091802599323336722(1)](https://github.com/MustardChef/WSABuilds/assets/68516357/fea3404d-cac6-4bd8-8ef4-2431d7aa34c4)

##### ***You may encounter this problem. WSA has been working fine for you, but all of a sudden, it breaks/ stops working. You are distraught. What do you do, when WSA beloved had been borked.*** 

## Solution: 

1. ***Go to "Turn Windows features on and off" and if any of these features below are enabled, DISABLE THEM.***

- Hyper-V
- Virtual Machine Platform
- Windows Hypervisor Platform
- Windows Subsystem for Linux

2. ***Restart your PC***

3. ***Boot into your BIOS, and DISABLE Virtualization.***

  - ***[Click here for a guide for Windows 11](https://support.microsoft.com/en-us/windows/enable-virtualization-on-windows-11-pcs-c5578302-6e43-4b4b-a449-8ced115f58e1)***
  - ***[Click here for a guide for Windows 10](https://support.microsoft.com/en-us/windows/enable-virtualization-on-windows-10-pcs-c5578302-6e43-4b4b-a449-8ced115f58e1)***

4. ***Ensure that you have Control Flow Guard enabled in Windows Security > Apps & browser control > Exploit protection.*** This is a known issue that can prevent WSA from starting

5.  ***In registry editor (regedit), go to “\HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\FsDepends"***

    Change the value of “Start” from “3” to “0”

> **Note**
> You can change it back to 3, if it makes no difference


6. ***Then in CMD (Run as Adminstrator), paste:***

```cmd
bcdedit /set hypervisorlaunchtype auto
```

7. ***ENABLE the features that you disabled in ``Step 1`` and restart a second time.*** 

8. ***Boot into your BIOS, and ENABLE Virtualization.***

  - ***[Click here for a guide for Windows 11](https://support.microsoft.com/en-us/windows/enable-virtualization-on-windows-11-pcs-c5578302-6e43-4b4b-a449-8ced115f58e1)***
  - ***[Click here for a guide for Windows 10](https://support.microsoft.com/en-us/windows/enable-virtualization-on-windows-10-pcs-c5578302-6e43-4b4b-a449-8ced115f58e1)***

9. ***Restart the Computer***

10. ***Try re-running WSA by running `Run.bat` or via the Windows Subsystem for Android Settings app***

**Hope this works for you!**
