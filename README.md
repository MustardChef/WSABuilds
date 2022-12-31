# MagiskOnWSA 
## (Google Play Services and Magisk on Windows Subsystem For Android)

| :exclamation: **Important:**  &nbsp;  `⚠️DO NOT FORK⚠️`               |
|------------------------------------------------------------------------|
**This repository is designed specifically not to be forked. This does not use the same mechanism as the original MagiskOnWSA, as the original mechanism is slow and unreliable, and also violates GitHub's Terms of Service due to abuse of GitHub Actions in forks. Don't fork this repository unless you're a developer and want to modify the code itself or want to download a specific configuration of WSA not already available in the [Releases page](https://github.com/MustardChef/WSABuilds/releases/latest).**

## Requirements
|     ![win11](https://cdn.discordapp.com/emojis/939533197425913868.webp) &nbsp; Windows 11        |     ![win10](https://img.icons8.com/color/512/windows-10.png) &nbsp; **Windows 10**       |
|-------------------------|-----------------------|
| - RAM: 8 GB (minimum) and 16 GB (recommended).|- RAM: 8 GB (minimum) and 16 GB (recommended).|
|- Processor: Your PC should meet the basic Windows 11 requirements i.e Core i3 8th Gen, Ryzen 3000, Snapdragon 8c, or above.| - Processor: N/A (This is a bit of a hit or miss)
|- Processor type: x64 or ARM64.| - Processor type: x64 or ARM64.|
|- Virtual Machine Platform Enabled: This optional setting is for virtualization and you can enable the setting from Control Panel/ Optional Features.| - Virtual Machine Platform Enabled: This optional setting is for virtualization and you can enable the setting from Control Panel/ Optional Features.|
|- Storage: Solid-state drive (SSD) or Hard Disk Drive (HDD) (NOT RECOMMENDED).| - Storage: Solid-state drive (SSD) or Hard Disk Drive (HDD) (NOT RECOMMENDED).|
|- Windows 11: Build 22000.526 or higher.| - Windows 10: 22H2 10.0.19045.2311 or higher.|
|- The Computer must support virtualization and be enabled in BIOS/UEFI and Optional Features. ![Guide]("https://support.microsoft.com/en-us/windows/enable-virtualization-on-windows-11-pcs-c5578302-6e43-4b4b-a449-8ced115f58e1")|- The Computer must support virtualization and be enabled in BIOS/UEFI and Optional Features. ![Guide]("https://support.microsoft.com/en-us/windows/enable-virtualization-on-windows-11-pcs-c5578302-6e43-4b4b-a449-8ced115f58e1")|

## Installation

> Note: If you have the official WSA installed, you must [completely uninstall](#uninstallation) it to use MagiskOnWSA

1. Go to the [Releases page](https://github.com/PeterNjeim/MagiskOnWSA/releases/latest)
2. In the latest release, go to the Assets section and download the WSA version of your choosing (do not download "Source code")
3. Extract the zip file
4. Delete the zip file
5. Move the newly extracted folder to a suitable location (Documents folder is a good choice), as you will need to keep the folder on your PC to use MagiskOnWSA
> Note: If you're updating WSA, merge the folders and replace the files for all items when asked

6. Open the WSA folder and double-click `Run.bat`
7. Once the installation process completes, WSA will launch (if this is a first-time install, a window asking for consent to diagnositic information will be shown instead. Sometimes two identical windows will show, this is fine and nothing bad happens if you click OK in both windows)
8. Click on the PowerShell window, then press any key on the keyboard, the PowerShell window should close
9. Close File Explorer

## Uninstallation

> Note: If you want to preseve your data, make a backup of the `%LOCALAPPDATA%\Packages\MicrosoftCorporationII.WindowsSubsystemForAndroid_8wekyb3d8bbwe\LocalCache\userdata.vhdx` file. After uninstalling, copy the VHDX file back to the `%LOCALAPPDATA%\Packages\MicrosoftCorporationII.WindowsSubsystemForAndroid_8wekyb3d8bbwe\LocalCache` folder.

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

How do I get a logcat?

- `adb logcat`

or

- `%LOCALAPPDATA%\Packages\MicrosoftCorporationII.WindowsSubsystemForAndroid_8wekyb3d8bbwe\LocalState\diagnostics\logcat`

How do I update Magisk?

- Wait for a new MagiskOnWSA release that includes the newer Magisk version, then follow the [Installation instructions](#installation) to update

Can I pass SafetyNet/Play Integrity?

- No. Virtual machines like WSA cannot pass these mechanisms on their own due to the lack of signing by Google. Passing requires more exotic (and untested) solutions: <https://github.com/kdrag0n/safetynet-fix/discussions/145#discussioncomment-2170917>

What is virtualization?

- Virtualization is required to run virtual machines like WSA. `Run.bat` helps you enable it. After rebooting, re-run `Run.bat` to install WSA. If it's still not working, you have to enable virtualization in your BIOS/UEFI. Instructions vary by PC vendor, look for help online

Can I remount system partition as read-write?

- No. WSA is mounted as read-only by Hyper-V. You can, however, modify the system partition by creating a Magisk module, or by directly modifying the system.img file

How do I uninstall Magisk?

- Download a WSA version that doesn't include Magisk from the [Releases page](https://github.com/MustardChef/WSABuilds/releases/latest). Then follow the [Installation instructions](#installation)

Can I switch between OpenGApps and MindTheGapps?

- No. GApps will no longer function. Do a [complete uninstallation](#uninstallation) before switching

How do I install custom Magisk or GApps?

1. Fork this repository
2. **A)** Magisk
   1. **a)** Via local file:
      1. Create a folder named `download` in the root
      2. Move your custom Magisk APK/ZIP file to the `download` folder and rename it to `magisk-debug.zip`
   2. In GitHub Actions, click on `Build MagiskOnWSA`
   3. Choose `Custom` in the `Magisk Version` field
   4. **b)** Via URL:
      1. Input the URL pointing to your custom Magisk APK/ZIP file in the `Custom Magisk APK/ZIP URL` field
3. **B)** GApps
   1. **a)** Via local file:
      1. Create a folder named `download` in the root
      2. Move your custom OpenGApps or MindTheGapps ZIP file to the `download` folder and rename it to `OpenGApps-{arch}-{variant}.zip` or `MindTheGapps-{arch}.zip` *(e.g. `OpenGApps-x64-pico.zip` or `MindTheGapps-arm64.zip`)*
   2. In GitHub Actions, click on `Build MagiskOnWSA`
   3. Choose `Custom (OpenGApps)` or `Custom (MindTheGapps)` in the `GApps Variant` field
   4. **b)** Via URL:
      1. Input the URL pointing to your custom OpenGApps or MindTheGapps ZIP file in the `Custom GApps ZIP URL` field

## Credits

- [Microsoft](https://apps.microsoft.com/store/detail/windows-subsystem-for-android%E2%84%A2-with-amazon-appstore/9P3395VX91NR): For providing Windows Subsystem For Android™ and related files. Windows Subsystem For Android™ and Windows Subsystem For Android™ Logo are trademarks of Microsoft Corporation. Microsoft Corporation reserves all rights to these trademarks. By downloading and installing Windows Subsystem For Android™, you agree to the [Terms and Conditions](https://support.microsoft.com/en-gb/windows/microsoft-software-license-terms-microsoft-windows-subsystem-for-android-cf8dfb03-ba62-4daa-b7f3-e2cb18f968ad) and [Privacy Policy](https://privacy.microsoft.com/en-gb/privacystatement)
- [PeterNjeim](https://github.com/PeterNjeim/MagiskOnWSA): For providing and continuing the development of the script
- [StoreLib](https://github.com/StoreDev/StoreLib): API for downloading WSA
- [Magisk](https://github.com/topjohnwu/Magisk): The Magic Mask for Android
- [The Open Google Apps Project](https://opengapps.org): Script the automatic generation of up-to-date Google Apps packages
- [WSA-Kernel-SU](https://github.com/LSPosed/WSA-Kernel-SU): A kernel module to provide /system/xbin/su to Android Kernel
- [Kernel Assisted Superuser](https://git.zx2c4.com/kernel-assisted-superuser): Kernel assisted means of gaining a root shell for Android
- [WSAGAScript](https://github.com/ADeltaX/WSAGAScript): The first GApps integration script for WSA
- [MagiskOnWSA](https://github.com/LSPosed/MagiskOnWSA): `Deprecated` Integrate Magisk root and Google Apps into WSA
- [MagiskOnWSALocal](https://github.com/LSPosed/MagiskOnWSALocal): Integrate Magisk root and Google Apps into WSA
