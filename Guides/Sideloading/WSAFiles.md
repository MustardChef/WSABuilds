# Sideloading using the Files app
Starting with WSA version 2305, you can sideload APK files using the Files app. This guide will show you how.

**NOTE:** This guide is only applicable for WSA versions 2305 and above. If you're using an older version, you will need to use [ADB](https://github.com/MustardChef/WSABuilds/blob/master/Guides/ADB-Sideloading.md) or one of the [listed APK installers](https://github.com/MustardChef/WSABuilds/blob/master/Guides/Sideloading.md).

Also note that APK files will need to be stored somewhere in your user directory. As of now, it's not possible to install APKs from another partition or external storage device. So you will need to copy them to your user folder before installing.

1. Open the Windows Subsystem for Android app, advanced settings and enable share user folders found under experimental features.

<img width="623" alt="image" src="https://github.com/MustardChef/WSABuilds/assets/44692189/d39ddbd3-20fd-462c-bf95-a193be045427">

2. Go to the system section and open the Files app.
3. Click on Subsystem for Android, followed by Windows to browse through your Windows files.

<img width="962" alt="image" src="https://github.com/MustardChef/WSABuilds/assets/44692189/95885809-deb2-4ac4-b468-7447fb84dde0">

4. Click the APK you want to install and choose package installer if it asks. Agree to the warnings and then click install.

<img width="443" alt="image" src="https://github.com/MustardChef/WSABuilds/assets/44692189/9e0698de-e47e-45c9-83a0-8c8ea1297cd4">

Once installed, you can launch the sideloaded app from the Start Menu.

If you're facing problems, try disabling `Block installation of malicious apps` in the WSA app.

If you want to install bundle files, such as .apkm or .xapk, you can install [SAI](https://apkpure.com/split-apks-installer-sai/com.aefyr.sai) and use that to install bundle files, as well as regular APKs.
