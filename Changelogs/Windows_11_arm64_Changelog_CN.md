# Windows 子系统 for Android：ARM 处理器上的 Windows 11（Windows_11_WSA_2303.40000.2.0_arm64）

![win11downcpre](https://img.shields.io/github/downloads/MustardChef/WSABuilds/Windows_11_2302.40000.9.0_arm64/total?label=Downloads&style=for-the-badge)

## 最新版本：2023年4月5日 23:03 GMT</br>（原因：初始发布）

> **警告**
> #### **在安装之前，请完整阅读[指南](https://github.com/MustardChef/WSABuilds/blob/master/README.md)，确保满足在Windows 11上安装的所有[要求](https://github.com/MustardChef/WSABuilds#requirements)。**
> **注意**
> #### **如果您正在更新WSA，请在被要求时合并文件夹并替换所有项目的文件**
### 按照以下步骤在Windows 11上安装。
#### 包含Magisk和/或MindTheGAPPS
> **注意：**
> 如果您安装了官方的WSA，请[完全卸载](https://github.com/MustardChef/WSABuilds#uninstallation)它以使用MagiskOnWSA
1. 解压缩zip文件
2. 删除zip文件（建议在WSA已安装并正常运行之前保留.zip文件）
3. 将新提取的文件夹移动到一个适当的位置（文档文件夹是一个好选择），因为您需要将文件夹保留在计算机上以使用MagiskOnWSA。
4. 打开WSA文件夹并双击Run.bat

### 注意事项：

1. 根据[要求](https://github.com/MustardChef/WSABuilds#requirements)规定，您只能在NTFS分区上安装WSA，而不能在exFAT分区上安装。
2. 您不能删除WSA安装文件夹。`Add-AppxPackage -Register .\AppxManifest.xml`所做的是注册一个带有一些现有未打包文件的appx包，因此只要您想使用WSA，就需要保留它们。有关更多详细信息，请参见https://learn.microsoft.com/en-us/powershell/module/appx/add-appxpackage?view=windowsserver2022-ps。
3. 在运行 WSA 之前，您需要注册 WSA appx 包。对于 [WSABuilds](https://github.com/MustardChef/WSABuilds) 和 [MagiskOnWSALocal](https://github.com/LSPosed/MagiskOnWSALocal) 用户，您需要在提取的目录中运行 `Run.bat`。
   如果脚本执行失败，您可以进行以下诊断步骤（需要管理员权限）：
    1. 打开 PowerShell 窗口并将工作目录更改为 WSA 目录。
    2. 在 PowerShell 中运行 `Add-AppxPackage -ForceApplicationShutdown -ForceUpdateFromAnyVersion -Register .\AppxManifest.xml`。
       这应该会失败并生成一个 ActivityID，这是下一步所需的 UUID。
    3. 在 PowerShell 中运行 `Get-AppPackageLog -ActivityID <UUID>`。
       这应该会打印失败操作的日志。
    4. 检查日志以查找失败原因并进行修复。

## 更新日志
- [微软官方更新日志](https://github.com/microsoft/WSA/discussions/277)
- 从 WSA v2302.40000.9.0 arm64 更新至 WSA v2303.40000.2.0 arm64 
- WSA Android 版本：Android 13 
- MindTheGapps 13.0 arm64
- Magisk Canary v69529ac5 (25211)
- KernelSU v0.5.0
- 移除了亚马逊应用商店

## 此版本与上一版本的差异：
- **WSA_XXXX.X0000.X.0_XXXX_Release-Nightly-MindTheGapps-XX.X-RemovedAmazon.zip** 
           - 仅包含 Google Play 商店和服务
---           
- **WSA_XXXX.X0000.X.0_XXXX_Release-Nightly-magisk-XXXXX.XXXX.-canary-MindTheGapps-XX.X-RemovedAmazon.zip**
           - 包含 Google Play 商店和服务 
           **_以及_**
           - 包含 Magisk（用于 Root 权限）
---
- **WSA_XXXX.X0000.X.0_XXXX_Release-Nightly-kernelsu-vX.X.X-MindTheGapps-XX.X-RemovedAmazon.zip**
           - 包含 Google Play 商店和服务 
           **_以及_**
           - 包含 KernelSU（用于 Root 权限）
---

## 致谢：
https://github.com/LSPosed/MagiskOnWSALocal

