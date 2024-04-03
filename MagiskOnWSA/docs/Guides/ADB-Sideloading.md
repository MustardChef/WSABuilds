# Sideloading APKs in to Windows Subsystem for Android
-------------

## Setting up ADB to work with WSA
- Launch **Windows Subsystem for Android**.
- Here, click on **Advanced Settings** and then enable **Developer mode** by clicking on the toggle button.
- Take note of **IP address and port** shown in the Developer mode section.
- Launch Windows Terminal and make sure ADB is installed ([install ADB](https://www.xda-developers.com/install-adb-windows-macos-linux/#adbsetupwindows)).
- Use command ``adb pair 127.0.0.1:58526`` to pair ADB with WSA.
- In Wireless debugging window, see **Device name** and under it **IP address and port**.
- Use command ``adb connect 127.0.0.1:58526`` to connect WSA with ADB.

Once this is done, use command ``adb devices`` to make sure that WSA is connected.


## Installing APKs using ADB
Now you can install any app you want, but I personally suggest installing a web browser and a file manager first. 
- Download the APK.
- Open File Explorer, right click on downloaded APK and tap on Copy as path.
- Launch Windows Terminal.
- Use ``adb install <file path>`` to install the APK.   
[**P.S.** You can right click to paste in Terminal]

## After installation using ADB
You can now open the web browser you installed in Android, and download and install Aurora Store like you do on any Android device - normally sideloading APK without using ADB.
***
&nbsp; 

### A list of suggested apps to install on WSA:
- [microG](https://microg.org/): A free-as-in-freedom re-implementation of Google’s proprietary Android user space apps and libraries.
- [Aurora Store](https://files.auroraoss.com/AuroraStore/Stable/): an app store that lets you download apps from Google Play without a Google account.
- [MiX](https://forum.xda-developers.com/t/app-2-2-mixplorer-v6-x-released-fully-featured-file-manager.1523691/): MiXplorer mix of explorers (SD, FTP, Lan, Cloud and other storage explorers) is a fast, smooth, beautiful, reliable and full-featured file manager with a simple and intuitive user interface.
- [Bromite](https://github.com/bromite/bromite): A Chromium fork with support for ad blocking and enhanced privacy.
