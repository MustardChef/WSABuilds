# WSABuilds &nbsp; &nbsp; <img src="https://img.shields.io/github/downloads/MustardChef/WSABuilds/total?label=Total%20Downloads&style=for-the-badge"/> &nbsp; 

# Sideloading APKs in to Windows Subsystem for Android
-------------

## Setting up ADB to work with WSA
- Launch **Windows Subsystem for Android**.
- Here, enable **Developer mode** then tap on **Manage developer settings**.
- Use your left mousebutton to scroll down until you find **Wireless debugging**. Tap to open it and enable it.
- Tap on **Pair device with pairing code**. 
- Take note of **Wi-Fi pairing code**, and **IP address and port**.
- Launch Windows Terminal and make sure ADB is installed ([install ADB](https://www.xda-developers.com/install-adb-windows-macos-linux/#adbsetupwindows)).
- Use command ``adb pair <IP:port>`` to pair ADB with WSA.
- In Wireless debugging window, see **Device name** and under it **IP address and port**.
- Use command ``adb connect <IP:port>`` to connect WSA with ADB.

Once this is done, use command ``adb devices`` to make sure that WSA is connected.


## Installing APKs using ADB
Now you can install any app you want, but I personally suggest installing a web browser and a file manager first. 
Here's the [direct download link](https://github.com/bromite/bromite/releases/latest/download/x64_ChromePublic.apk) to the latest Bromite x64 build.
- Download the APK.
- Open File Explorer, right click on downloaded APK and tap on Copy as path.
- Launch Windows Terminal.
- Use ``adb install <file path>`` to install the APK.   
[**P.S.** You can right click to paste in Terminal]
- Repeat this process for a file manager app. I recommend using FX File Explorer, you can use what you want.

## After installation using ADB
You can now open the web browser you installed in Android, and download and install Aurora Store like you do on any Android device - normally sideloading APK without using ADB.
***
&nbsp; 

### A list of suggested apps to install on WSA:
- [microG](https://microg.org/): A free-as-in-freedom re-implementation of Google’s proprietary Android user space apps and libraries.
- [Aurora Store](https://files.auroraoss.com/AuroraStore/Stable/): an app store that lets you download apps from Google Play without a Google account.
- [FX File Explorer](https://www.nextapp.com/fx/): FX File Explorer is a mix of explorers (SD, FTP, Lan, Cloud and other storage explorers) and is a fast, smooth, beautiful, reliable and full-featured file manager with a simple and intuitive user interface.
- [Bromite](https://github.com/bromite/bromite): A Chromium fork with support for ad blocking and enhanced privacy.
