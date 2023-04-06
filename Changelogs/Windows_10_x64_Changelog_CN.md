
<img src="https://upload.wikimedia.org/wikipedia/commons/0/05/Windows_10_Logo.svg" width=20% height=20%>

![win10downcpre](https://img.shields.io/github/downloads/MustardChef/WSABuilds/Windows_10_2302.40000.9.0/total?label=Downloads&style=for-the-badge)

## Builds Last Updated: 06/04/2023 12:27 GMT </br> (Reason: Initial Release)

> **警告**
> #### **在安装之前，请完全阅读[指南](https://github.com/MustardChef/WSABuilds/blob/master/README.md)，确保您满足安装Windows 10上WSA的全部[要求](https://github.com/MustardChef/WSABuilds#requirements)。**
> **注意** 
>#### **如果您正在更新WSA，请在被询问时合并文件夹并替换所有文件**
### 安装WSA时，请按照在Windows 11上安装WSA的相同步骤。

#### 包含Magisk和（或）MindTheGAPPS
> **注意** ： 
> 如果您已经安装了官方的WSA，则必须[完全卸载](https://github.com/MustardChef/WSABuilds#uninstallation)它才能使用MagiskOnWSA
1. 解压缩zip文件
2. 删除zip文件（建议在WSA安装并正常运行之前保留.zip文件）
3. 将新提取的文件夹移动到合适的位置（文档文件夹是一个很好的选择），因为您需要将文件夹保留在您的PC上以使用MagiskOnWSA。
4. 打开WSA文件夹，双击Run.bat

### 注意: 

1. 根据[要求](https://github.com/MustardChef/WSABuilds#requirements)所述，您只能在NTFS分区上安装WSA，不能在exFAT分区上安装。
2. 您不能删除WSA安装文件夹。
   `Add-AppxPackage -Register .\AppxManifest.xml`所做的是注册一个带有一些现有未打包文件的appx包，因此只要想要使用WSA，就需要保留它们。
   请参阅https://learn.microsoft.com/en-us/powershell/module/appx/add-appxpackage?view=windowsserver2022-ps获取更多详细信息。
3. 您需要在运行 WSA 之前注册您的 WSA appx 包。对于 [WSABuilds](https://github.com/MustardChef/WSABuilds) 和 [MagiskOnWSALocal](https://github.com/LSPosed/MagiskOnWSALocal) 用户，您需要在提取的目录中运行 `Run.bat`。如果脚本失败，您可以采取以下诊断步骤（需要管理员权限）：
    1. 打开 PowerShell 窗口并将工作目录更改为 WSA 目录。
    2. 在 PowerShell 中运行 `Add-AppxPackage -ForceApplicationShutdown -ForceUpdateFromAnyVersion -Register .\AppxManifest.xml`。
       这应该会失败，并显示一个 ActivityID，这是下一步所需的 UUID。
    3. 在 PowerShell 中运行 `Get-AppPackageLog -ActivityID <UUID>`。
       这应该会打印失败操作的日志。
    4. 检查日志以查找失败原因并修复它。
    
### 你可能会遇到的问题（可能不适用）：
#### 来源：**WSAPatch**
- 在使用 WSA 2209.40000.26.0 时，我可以运行 WSA 中的应用程序，但在启用开发人员模式后，我无法连接到 WSA ADB，因为 netstat 显示在端口 58526 上没有进程在侦听。当我升级到 WSA 2210.40000.7.0 时，我可以连接到 WSA ADB。
- WSA 设置窗口没有可拖动的标题，但是如果您在“最小化”按钮附近按住光标左键或按下 Alt+Space，然后在上下文菜单中单击“移动”，就可以移动 WSA 窗口。https://github.com/cinit/WSAPatch/issues/1 https://github.com/cinit/WSAPatch/issues/2
- 如果您的 WSA 在启动时崩溃（或突然消失），请尝试将 Windows 升级到 Windows 10 22H2 10.0.19045.2311。（有人报告说 WSA 在 22H2 19045.2251 上启动失败，但升级到 19045.2311 后就可以工作。）

## 更新日志
- [Microsoft 官方更新日志](https://github.com/microsoft/WSA/discussions/277)
- 增加了对 Windows 10 的支持（Credit: WSAPatch）
- 更新 WSA 版本从 v2302.40000.9.0 x86_64 ----> WSA v2303.40000.2.0 x86_64
- WSA Android 版本：Android 13
- MindTheGapps 13.0 x86_64
- Magisk Canary e2545e57 (26001)
- KernelSU v0.5.0
- 删除了亚马逊应用商店

## 此版本之间的差异：

- **WSA_XXXX.X0000.X.0_XXXX_Release-Nightly-MindTheGapps-XX.X-RemovedAmazon_Windows_10.zip**
    - 只包含 Google Play 商店和服务。
---

- **WSA_XXXX.X0000.X.0_XXXX_Release-Nightly-magisk-XXXXX.XXXX.-canary-MindTheGapps-XX.X-RemovedAmazon_Windows_10.zip**
    - 包含 Google Play 商店和服务。
    **_和_**
    - 包含 Magisk（用于 Root 访问）。
---

- **WSA_XXXX.X0000.X.0_XXXX_Release-Nightly-kernelsu-vX.X.X-MindTheGapps-XX.X-RemovedAmazon_Windows_10.zip**
    - 包含 Google Play 商店和服务。
    **_和_**
    - 包含 KernelSU（用于 Root 访问）。
---

## 鸣谢：

https://github.com/LSPosed/MagiskOnWSALocal

https://github.com/cinit/WSAPatch
