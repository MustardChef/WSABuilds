# WSABuilds &nbsp; &nbsp; <img src="https://img.shields.io/github/downloads/MustardChef/WSABuilds/total?label=Total%20Downloads&style=for-the-badge"/> &nbsp; 


## 指南：将 Windows Subsystem For Android™（WSA）移动/安装到其他分区或磁盘

### 前言：
##### WSA 可以占用大量存储空间，因此您想将其移动到具有更多空间的其他分区或磁盘。<br />本指南介绍了一种方法，通过该方法，您可以从其他磁盘安装 WSA 并将数据存储在该驱动器中（而不是“%LOCALAPPDATA%\Packages\MicrosoftCorporationII.WindowsSubsystemForAndroid_8wekyb3d8bbwe”）。

### 先决条件：
- 您要将 Windows Subsystem For Android™ 移动/安装到的分区/磁盘，**必须**为 **NTFS**
- 建议 C:/ 和您要安装（移动）WSA 的磁盘/分区都是 SSD
    - HDD 可能可以工作，但可能会出现性能问题
- 基本了解如何使用命令提示符（CMD）
- 安装/移动 WSA 的磁盘/分区上必须有足够的空间（建议为 20GB，因为 VHDX 可以变得非常大）

> **注意**
>
> 如果您要保留数据，请备份 `%LOCALAPPDATA%\Packages\MicrosoftCorporationII.WindowsSubsystemForAndroid_8wekyb3d8bbwe\LocalCache\userdata.vhdx` 文件。卸载后，将 VHDX 文件复制回 `%LOCALAPPDATA%\Packages\MicrosoftCorporationII.WindowsSubsystemForAndroid_8wekyb3d8bbwe\LocalCache` 文件夹。

## 过程：

- ### 步骤 1：从 WSABuilds 或官方 WSA 发行版中删除所有以前的安装
    - 要从 WSABuild 安装中删除 WSA：

        - **1.）** 确保 Windows Subsystem For Android™ 没有运行
        - **2.）** 使用内置的 Windows 搜索或通过“添加和删除程序”搜索“Windows Subsystem For Android™ 设置”，然后按卸载
        - **3.）** 删除您提取和运行 Run.bat 安装 WSA 的 WSA 文件夹（MagiskOnWSA 文件夹）
        - **4.）** 转到“%LOCALAPPDATA%/Packages/”并删除名为“MicrosoftCorporationII.WindowsSubsystemForAndroid_8wekyb3d8bbwe”的文件夹
            - 如果出现无法删除文件的错误，请确保 WSA 已关闭

    - 要从 Microsoft Store 安装中删除 WSA：
        - **1.）** 使用内置的 Windows 搜索或通过“添加和删除程序”搜索“Windows Subsystem For Android™ 设置”，然后


- ### 步骤2：从所需分区安装WSA 
    - **1.)** 从[下载](https://github.com/MustardChef/WSABuilds#downloads)页面下载适用于Windows版本和CPU架构的最新WSA Build 
    - **2.)** 将其解压到所需分区或驱动器
    - 使用与[安装](https://github.com/MustardChef/WSABuilds#--installation)中详细描述的相同过程 
    - **3.)** 打开已提取的文件夹并运行``Run.bat``

- ### 步骤3：将AppData（VHDX +数据）从Windows驱动器（C:\）移动到所需的分区/驱动器 
     - **1.)** 转到``%LOCALAPPDATA%\Packages\``并复制名为``MicrosoftCorporationII.WindowsSubsystemForAndroid_8wekyb3d8bbwe``的文件夹到所需的驱动器/分区，确保在复制后从``%LOCALAPPDATA%\Packages\``中删除该文件夹 
     
     - **2.)** 通过Windows终端（管理员）或直接打开管理员命令提示符，并运行以下命令：
```shell
mklink /J "%LOCALAPPDATA%\Packages\MicrosoftCorporationII.WindowsSubsystemForAndroid_8wekyb3d8bbwe" "Other_Drive中文件夹的位置"
```
用所需分区/驱动器中复制到的名为 ``MicrosoftCorporationII.WindowsSubsystemForAndroid_8wekyb3d8bbwe`` 的文件夹位置替换 "Other_Drive_中的文件夹位置"。

- ### 步骤 4：测试一切是否正常
    - 运行 Windows 子系统 For Android™ 设置
        - 如果崩溃了，那么您在遵循本指南时可能犯了一个错误。请尝试再次遵循指南。
    
    
### 如果您遇到困难或不理解指南中的任何步骤，请加入 Discord 并在此处询问：
[<img src="https://invidget.switchblade.xyz/2thee7zzHZ" style="width: 400px;"/>](https://discord.gg/2thee7zzHZ) 
