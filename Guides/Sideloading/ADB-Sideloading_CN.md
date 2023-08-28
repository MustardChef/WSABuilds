# WSABuilds &nbsp; &nbsp; <img src="https://img.shields.io/github/downloads/MustardChef/WSABuilds/total?label=Total%20Downloads&style=for-the-badge"/> &nbsp; 

# 在 Windows 子系统中进行 APK 侧载
-------------

## 设置 ADB 与 WSA 连接

-启动 **Windows Subsystem for Android**。

-在此处启用 **开发者模式**，然后点击 **管理开发者设置**。

-使用鼠标左键向下滚动，直到找到 **无线调试**。点击打开它并启用。

-点击 **使用配对码配对设备**。

-注意 Wi-Fi **配对码** 和 **IP 地址和端口**。

-启动 Windows 终端并确保已安装 ADB ([安装 ADB](https://www.xda-developers.com/install-adb-windows-macos-linux/#adbsetupwindows))。

-使用命令 ``adb pair <IP:port>`` 将 ADB 与 WSA 配对。

-在无线调试窗口中，查看 **设备名称** 和下面的 **IP 地址和端口**。

-使用命令 ``adb connect <IP:port>`` 连接 WSA 和 ADB。

完成后，使用命令 ``adb devices`` 确认 WSA 已连接。


## 使用 ADB 安装 APK
现在，您可以安装任何您想要的应用程序，但我个人建议首先安装一个网页浏览器和一个文件管理器。
这是最新的 Bromite x64 版本的 [直接下载链接](https://github.com/bromite/bromite/releases/latest/download/x64_ChromePublic.apk)。

- 下载 APK。
- 打开文件资源管理器，在下载的 APK 上右键单击，然后点击 “复制为路径” 。
- 启动 Windows 终端。
- 使用 ``adb install <file path>`` 命令安装 APK。  
[**P.S.** 可以右键在终端中粘贴]
- 重复此过程以安装文件管理器应用程序。我建议使用 FX File Explorer，您可以使用您喜欢的应用程序。

## 在使用 ADB 安装后
您现在可以在 Android 中打开您安装的网页浏览器，并像在任何 Android 设备上一样下载和安装 Aurora Store - 即通过侧载 APK 而不是使用 ADB。

***
&nbsp; 

### 推荐在 WSA 上安装的应用程序列表：
- [microG](https://microg.org/): A free-as-in-freedom re-implementation of Google’s proprietary Android user space apps and libraries.
- [Aurora Store](https://files.auroraoss.com/AuroraStore/Stable/): an app store that lets you download apps from Google Play without a Google account.
- [FX File Explorer](https://www.nextapp.com/fx/): FX File Explorer is a mix of explorers (SD, FTP, Lan, Cloud and other storage explorers) and is a fast, smooth, beautiful, reliable and full-featured file manager with a simple and intuitive user interface.
- [Bromite](https://github.com/bromite/bromite): A Chromium fork with support for ad blocking and enhanced privacy.
