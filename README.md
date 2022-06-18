# MagiskOnWSA (also includes Google Play Services)

## Installation

> Note: If you have a non-MagiskOnWSA WSA installed, you must [completely uninstall](#uninstallation) it to use MagiskOnWSA

> Note: If you have MagiskOnWSA Android 11 installed, you must [completely uninstall](#uninstallation) it to update to Android 12.1

> Note: If you have MagiskOnWSA Android 12.1 installed, you must delete the WSA folder you extracted for it. This will not remove user data

1. Go to the [Releases page](https://github.com/PeterNjeim/MagiskOnWSA/releases)
2. In the latest release, go to the Assets section and download the WSA version of your choosing (do not download "Source code")
3. Extract the zip file
4. Delete the zip file
5. Move the newly extracted folder to a suitable location (Documents folder is a good choice), as you will need to keep the folder on your PC to use MagiskOnWSA
6. Rename the folder to `WSA`
7. Open the WSA folder and right-click `Install.ps1`, then select `Run with PowerShell`
8. Once the installation process completes, WSA will launch (if this is a first-time install, a window asking for consent to diagnositic information will be shown instead. Sometimes two identical windows will show, this is fine and nothing bad happens if you click OK in both windows)
9. Click on the PowerShell window, then press any key on the keyboard, the PowerShell window should close
10. Close File Explorer

## Uninstallation

> Note: If you want to preseve your data, make a backup of the `%LOCALAPPDATA%\Packages\MicrosoftCorporationII.WindowsSubsystemForAndroid_8wekyb3d8bbwe\LocalCache\userdata.vhdx` file. After uninstalling, copy the VHDX file back to the `%LOCALAPPDATA%\Packages\MicrosoftCorporationII.WindowsSubsystemForAndroid_8wekyb3d8bbwe\LocalCache` folder. To then restore your app icons to the start menu, install [WSAHelper](https://github.com/LSPosed/WSAHelper/releases/latest) and follow their instructions

1. Go to the Start Menu
2. Type `Windows Subsystem for Android`
3. Once the WSA app shows, click `App settings` in the right pane
4. In the Settings window that opens, scroll down and click `Terminate`
5. Click `Repair`
6. Click `Reset`
7. Close the Settings app
8. Go to the Start Menu
9. Type `Windows Subsystem for Android`
10. Once the WSA app shows, click `Uninstall` in the right pane

## Help

How can I get a logcat?

-   `adb logcat`

or

-   `%LOCALAPPDATA%\Packages\MicrosoftCorporationII.WindowsSubsystemForAndroid_8wekyb3d8bbwe\LocalState\diagnostics\logcat`

How can I update Magisk?

-   Wait for a new MagiskOnWSA release that includes the newer Magisk version, then follow the [Installation instructions](#installation) to update

Can I pass SafetyNet/Play Integrity?

-   No. Virtual machines like WSA cannot pass these mechanisms on their own due to the lack of signing by Google. Passing requires more exotic (and untested) solutions: https://github.com/kdrag0n/safetynet-fix/discussions/145#discussioncomment-2170917

Virtualization?

-   Virtualization is required to run virtual machines like WSA. `Install.ps1` helps you enable it. After rebooting, re-run `Install.ps1` to install WSA. If it's still not working, you have to enable virtualization in your BIOS/UEFI. Instructions vary by PC vendor, look for help online

Can I remount system partition as read-write?

-   No. WSA is mounted as read-only by Hyper-V. You can, however, modify the system partition by creating a Magisk module, or by directly modifying the system.img file

How can I uninstall Magisk?

-   Download a WSA version that doesn't include Magisk from the [Releases page](https://github.com/PeterNjeim/MagiskOnWSA/releases). Then follow the [Installation instructions](#installation)

## Credits

-   [Magisk](https://github.com/topjohnwu/Magisk): The Magic Mask for Android
-   [The Open Google Apps Project](https://opengapps.org): Script the automatic generation of up-to-date Google Apps packages
-   [WSA-Kernel-SU](https://github.com/LSPosed/WSA-Kernel-SU): A kernel module to provide /system/xbin/su to Android Kernel
-   [Kernel Assisted Superuser](https://git.zx2c4.com/kernel-assisted-superuser): Kernel assisted means of gaining a root shell for Android
-   [MagiskOnWSA](https://github.com/LSPosed/MagiskOnWSA): Integrate Magisk root and Google Apps into WSA
