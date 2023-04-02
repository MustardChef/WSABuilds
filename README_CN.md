# WSABuilds&nbsp;&nbsp;<img src="https://img.shields.io/github/downloads/MustardChef/WSABuilds/total?label=Total%20Downloads&style=for-the-badge"/>&nbsp;[<img src="https://img.shields.io/badge/XDA%20Developers-WSABuilds-EA7100?style=for-the-badge&logoColor=white&logo=XDA-Developers" />](https://forum.xda-developers.com/t/wsabuilds-latest-windows-subsystem-for-android-wsa-builds-for-windows-10-and-11-with-magisk-and-google-play-store.4545087/)
### MagiskOnWSA（适用于 Windows ™ 10 和 11）[<img align="right" src="https://invidget.switchblade.xyz/2thee7zzHZ" style="width: 400px;"/>](https://discord.gg/2thee7zzHZ)
#### 适用于 Android ™的 Windows 子系统（WSA），带有 Google Play 服务和（或）Magisk

<details>     
   <summary><h4>&nbsp;分叉信息<h4></summary>

|:exclamation: **重要：**  &nbsp;  `⚠️DO NOT FORK⚠️`|
|------------------------------------------------------------------------|
|**此存储库专门设计为不分叉。Magiskonwsa和一些在平台上涌现的各种分支和克隆（*** 潜在***）因滥用GitHub的行为而违反GitHub的服务条款，并最终被警告、禁用或封禁。**|
|**我们想说一件事：我们尊重 GitHub 向其用户制定的条款和条件。Magiskonwsa 版本使用 Magiskonwsalocal 脚本构建，在 Windows 10 版本的情况下进行修补并上传到 GitHub，因此不依赖于 GitHub 操作的使用。**|
|**因此，除非你是一名开发人员，并且想要修改代码本身和/或想要为这个 GitHub 存储库做贡献，否则不要派生这个存储库。**|
</details>  

&nbsp;

## 下载
<details>     
   <summary><h3>&nbsp;下载免责声明<h3></summary>
   
> **警告**
> ### :exclamation: **重要：**
>  ### 在运行 MagiskOnWSA 脚本并上传到 GitHub 之前和之后，没有对 Windows ™ 11[Releases](https://github.com/MustardChef/WSABuilds/releases)的 Android ™预建 Windows 子系统版本进行任何修改。
> ### 在上传到 GitHub 之前，根据 WSAPATCH 指南，仅在中[Releases](https://github.com/MustardChef/WSABuilds/releases)为 Windows ™ 10 的 Android ™版本预先构建的 Windows 子系统已修补了 appxmanifest.XML、ICU.DLL 和 wsapatch.DLL.

> ### 由于对安全、透明度和建筑完整性的全面关注，我将很快转向一种更透明的建造 Magiskonwsa 建筑的方法。

> #### Windows Subsystem for Android ™版本应与你从互联网下载的任何其他程序应用相同级别的审查。
</details>
      
 <details>     
   <summary><h3>&nbsp;想要构建自己的自定义版本吗？<h3></summary>
         
|:exclamation: **重要：**  &nbsp;  `⚠️DO NOT FORK⚠️`|
|------------------------------------------------------------------------|
|**此处显示的存储库专门设计为不分叉。Magiskonwsa和一些在平台上涌现的各种分支和克隆（*** 潜在***）因滥用GitHub的行为而违反GitHub的服务条款，并最终被警告、禁用或封禁。**|
|**因此，除非你是开发人员并且想要修改代码本身和/或想要为 GitHub 存储库做贡献，否则不要派生此存储库。**|
|**如果你想创建你的自定义版本，请按照明确的说明进行操作，以避免由于大量的分叉而误用 GitHub 操作而导致回购被删除。**|
      
---
#### **1. 首先检查版本[Releases](https://github.com/MustardChef/WSABuilds/releases)。如果它没有你想要的版本，请继续遵循本指南。如果是这样，那么可以随意使用那些预构建的 WSA 构建。**
      
#### **2. 登录到你的 GitHub 帐户（这是必要的），并在主页中，点击按钮（如下所示）并选择“导入存储库”或转到[这一页直接](https://github.com/new/import)**
   ***步骤1：***
   
   <img src="https://user-images.githubusercontent.com/68516357/221636520-78d0716a-247b-4034-aa9d-bdbe2277950c.png" style="width: 350px;"/>
   
   ***步骤2：***
   
   ![image](https://user-images.githubusercontent.com/68516357/221641202-e3ef4deb-f2dd-46e6-82c8-fb4767f82e99.png)
   
---   
#### **3. [复制此回购的URL](https://github.com/WellCodeIsDelicious/WSA-Script)并将其粘贴到下面的文本框中，然后按“导入”**

![image](https://user-images.githubusercontent.com/68516357/221643582-72d71f68-8f53-48d9-a940-692a54d42098.png)

---
#### **4.转到**设置**在新导入的repo中设置选项卡并启用“ GitHub操作”**

![Settings](https://user-images.githubusercontent.com/68516357/222214308-b52b1c6f-a60b-44ef-9ce0-bc335087e3a2.png) ![MRq9WD3SO2](https://user-images.githubusercontent.com/68516357/222215598-30d68ad3-9700-4061-bba4-815b3befcb10.png)

---
#### **5. 然后，向下滚动，直到到达标题为“工作流权限”的部分，并按照下**图所示的步骤操作

![image](https://user-images.githubusercontent.com/68516357/224546417-a82249b4-3864-42bd-8a29-32350b8b0c97.png)


---
#### **6.现在，转到**行动**选项卡**

![CvYhP0B0CI](https://user-images.githubusercontent.com/68516357/222221960-f48ab9c3-eb77-4cb0-b932-5cd343381048.png)

    
---
#### **在左侧边栏中，单击**自定义构建**工作流程。**
    
![image](https://user-images.githubusercontent.com/68516357/222221307-8a4571d2-ac3e-410b-b999-0eb62b14d8d5.png)
    
---
#### **在工作流运行列表上方，选择**运行工作流****
    
![image](https://user-images.githubusercontent.com/68516357/222222850-f991890c-5a80-4cc2-b83d-0ef35c24a79e.png)
    
---
#### **9. 选择所需的选项（如***Magisk版本***、***WSA发布渠道+WSA架构***），***GAPPS变量******压缩格式***然后单击**运行工作流****
    
![image](https://user-images.githubusercontent.com/68516357/222224185-abcfa0cf-c8c6-46e3-bc38-871c968b86f2.png)
    
---    
#### **10. 等待操作完成并下载工件**

**不要通过多线程下载器（如 IDM**）下载

![image](https://user-images.githubusercontent.com/68516357/222224469-5748b78a-158e-46ff-9f65-317dbb519aac.png)

---
#### **11.使用此存储库中的说明正常安装**最重要的..

<br/>

### **享受！**
 
<br/>

---    
</details>
      
<details>     
   <summary><h3>&nbsp;想要请求预构建的自定义版本<h3></summary>
   
> **注意**
> <br />请求：<br />-较新的版本<br />-具有不同版本的 GAPPS（Google Play 服务）或 MAGISK（根）<br />的版本-没有 MAGISK（根）或 GAPPS（Google Play 服务）<br />的版本请随时在[问题页面](https://github.com/MustardChef/WSABuilds/issues)中打开问题。<br /><br />请求的（自定义）版本可以在下面的“自定义版本”部分中。
</details>

|****操作系统****|****Download Page****|****Download Mirrors****|
|----------|-----------|--------------|
|<img src="https://upload.wikimedia.org/wikipedia/commons/e/e6/Windows_11_logo.svg" style="width: 200px;"/> |[![win11down](https://img.shields.io/badge/Download%20Latest%20Build-Windows%2011%20x64-blue?style=for-the-badge&logo=windows11)](https://github.com/MustardChef/WSABuilds/releases/tag/Windows_11_2302.40000.9.0) <br /> [![win11down](https://img.shields.io/badge/Download%20Latest%20Build-Windows%2011%20arm64-blue?style=for-the-badge&logo=windows11)](https://github.com/MustardChef/WSABuilds/releases/tag/Windows_11_2302.40000.9.0_arm64)|[<img src="https://img.shields.io/badge/OneDrive-white?style=for-the-badge&logo=Microsoft%20OneDrive&logoColor=0078D4" style="width: 150px;"/>](https://x6cgr-my.sharepoint.com/:f:/g/personal/mcdt_x6cgr_onmicrosoft_com/EpU5MZpnqGlMopVKP_kgmSwBiUCiDquTdoo-OT5gVtTZxA?e=MTEeNP)|
|<img src="https://upload.wikimedia.org/wikipedia/commons/0/05/Windows_10_Logo.svg" style="width: 200px;"/> | [![win10down](https://img.shields.io/badge/Download%20Latest%20Build-Windows%2010%20x64-blue?style=for-the-badge&logo=windows)](https://github.com/MustardChef/WSABuilds/releases/tag/Windows_10_2302.40000.9.0)|[<img src="https://img.shields.io/badge/OneDrive-white?style=for-the-badge&logo=Microsoft%20OneDrive&logoColor=0078D4" style="width: 150px;"/>] （https：//x6cgr-my.sharepoint.com/：F：/G/Personal/MCDT_x6cgr Microsoft_ 上的 _com/egxkx2pttfvehjxixh-ij1ebq3cynoxuzp0pde-ffyrc6g？E=0lm1ml）|
| <p align="center"><img src="https://img.icons8.com/color/240/null/windows-11.png" style="width: 50px;"/> <img src="https://img.icons8.com/color/240/null/windows-10.png" style="width: 50px;"/></p>|[![windownold](https://img.shields.io/badge/Windows%2010%2F11-Older%20Builds-red?style=for-the-badge)](https://github.com/MustardChef/WSABuilds/blob/master/OldBuilds.md)|[<img src="https://img.shields.io/badge/OneDrive-white?style=for-the-badge&logo=Microsoft%20OneDrive&logoColor=0078D4" style="width: 150px;"/>] （https：//x6cgr-my.sharepoint.com/：f：/G/Personal/MCDT_x6cgr Microsoft_ 上的 _com/egnsfssthbtiuazginvkanybtwu0kkvc_qvoiw7i0iojdq）|
|<p align="center"><img src="https://img.icons8.com/color/240/null/windows-11.png" style="width: 50px;"/> <img src="https://img.icons8.com/color/240/null/windows-10.png" style="width: 50px;"/></p>| <h4>Custom Builds:<h4> [![windownmagikdelta](https://img.shields.io/badge/Windows%2010%2F11-Magisk%20Delta-382bef?style=for-the-badge)](https://github.com/MustardChef/WSAMagiskDelta)|  |
|<p align="center"><img align="centre;" src="https://user-images.githubusercontent.com/68516357/216452358-8137df76-875f-4b59-b77d-ca34c8a2d6d3.png" style="width: 80px;"/></p>|[<img src="https://img.shields.io/badge/Download-.msix%20Sources-3A6B35?style=for-the-badge&logoColor=white&logo=Github" />](https://github.com/MustardChef/WSAArchives)|[<img src="https://img.shields.io/badge/OneDrive-white?style=for-the-badge&logo=Microsoft%20OneDrive&logoColor=0078D4" style="width: 150px;"/>] （https：//x6cgr-my.sharepoint.com/：f：/G/Personal/MCDT_x6cgr Microsoft_ 上的 _com/egswyr5jljfnksmnydpnfksbjalckj61c6bbbbvgpglasa？e=weik7y）|

&nbsp;

## 要求
|     <img src="https://upload.wikimedia.org/wikipedia/commons/e/e6/Windows_11_logo.svg" style="width: 200px;"/>|  <img src="https://upload.wikimedia.org/wikipedia/commons/0/05/Windows_10_Logo.svg" style="width: 200px;"/>     |
|-----------------------|-----------------------|
|-RAM：6 GB（不推荐）、8 GB（最低）和 16 GB（推荐）。|- RAM: 6 GB (not recommended), 8 GB (minimum) and 16 GB (recommended).|
|-处理器：你的 PC 应满足基本的 Windows ™ 11 要求，即第 8 代酷睿 i3、锐龙 3000、Snapdragon 8C 或更高版本。|-处理器：N/</br>A 这有点不确定，但强烈建议将你的处理器列在[符合Windows 11要求的受支持CPU列表](https://learn.microsoft.com/en-gb/windows-hardware/design/minimum/windows-processor-requirements)
|- Processor type: x64 or ARM64.|-处理器类型：x64 或 ARM64。|
|- GPU: Any compatible Intel, AMD or Nvidia GPU <br /> GPU Performance may vary depending on its compatibility with Windows Subsystem For Android™  <br /><br /> <details><summary><h3>**Users with Intel HD Graphics 530 and older**<h3><br /></summary> <br /> WSA may not start or graphical glitches will occur when Intel HD Graphics 530 and Older iGPUs are used. This is a known issue, but unfortunately there are no fixes that I currently know, plus, these GPUs are too old and do not meet Windows 11 requirements and hence are not offical supported. [Follow this guide](https://github.com/MustardChef/WSABuilds/blob/master/Guides/ChangingGPU.md) to switch to another iGPU/dGPU/eGPU  that you may have or Microsoft Basic Renderer </details> <br /><details><summary><h3>**Users with Nvidia GPUs**<h3><br /></summary> <br /> Nvidia GPUs are known to cause problems. If Windows Subsystem For Android™ does not start or there are graphical glitches when an Nvidia GPU is used, [follow this guide](https://github.com/MustardChef/WSABuilds/blob/master/Guides/ChangingGPU.md) to switch to another iGPU/dGPU/eGPU  that you may have or Microsoft Basic Renderer </details>|-GPU：任何兼容的英特尔、AMD 或 NVIDIA GPU<br />GPU 性能可能会有所不同，具体取决于其与 Windows Subsystem for Android ™ WSA<br /><br /><details><summary><h3>**配备英特尔高清显卡530及更早版本的用户**<h3><br /></summary><br />的兼容性。使用英特尔 HD Graphics 530 和较旧的 iGPU 时，可能无法启动或出现图形故障。这是一个已知的问题，但不幸的是，我目前还不知道任何修复程序，另外，这些 GPU 太旧了，不符合 Windows 11 的要求，因此不受官方支持。[请遵循本指南](https://github.com/MustardChef/WSABuilds/blob/master/Guides/ChangingGPU.md)切换到你可能拥有的另一个 iGPU/dGPU/eGPU 或 Microsoft 基本渲染器</details><br /><details><summary><h3>**使用NVIDIA GPU的用户**<h3><br /></summary><br />已知 NVIDIA GPU 会导致问题。如果 Android ™的 Windows 子系统无法启动或在使用 NVIDIA GPU 时出现图形故障，[请遵循本指南](https://github.com/MustardChef/WSABuilds/blob/master/Guides/ChangingGPU.md)请切换到你可能拥有的另一个 iGPU/dGPU/eGPU 或 Microsoft 基本渲染器</details>|
|- Virtual Machine Platform Enabled: <br /> This optional setting is for virtualization and you can enable the setting from Control Panel/ Optional Features.|-已启用虚拟机平台：<br />此可选设置用于虚拟化，你可以从“控制面板”/“可选功能”中启用该设置。|
|- Storage: Solid-state drive (SSD) <br /> - Hard Disk Drive (HDD) (NOT RECOMMENDED).|-存储：固态驱动器（SSD）<br />-硬盘驱动器（HDD）（不推荐）。|
|-分区：NTFS<br />Windows Subsystem for Android ™只能安装在 NTFS 分区上，而不能安装在 exFAT 分区上|- Partition: NTFS <br /> Windows Subsystem For Android™ can only be installed on a NTFS partition, not on an exFAT partition|
|- Windows™ 11: Build 22000.526 or higher.|-Windows ™ 10：22H2 10.0.19045.2311 或更高版本。<br /><br />**从此回购中的WSA版本2301.40000.7.0及更高版本开始，存在对Windows™10：20H1 10.0.19041.264或更高版本的非官方支持**因此，你必须先安装[KB5014032](https://www.catalog.update.microsoft.com/Search.aspx?q=KB5014032)，然后再安装[KB5022282](https://www.catalog.update.microsoft.com/Search.aspx?q=KB5022282)才能在这些较旧的 Windows 版本<br /><br />上使用 WSA.|
|-计算机必须支持虚拟化，并在 BIOS/UEFI 和可选功能中启用。[Guide](https://support.microsoft.com/en-us/windows/enable-virtualization-on-windows-11-pcs-c5578302-6e43-4b4b-a449-8ced115f58e1)|- The Computer must support virtualization and be enabled in BIOS/UEFI and Optional Features. [Guide](https://support.microsoft.com/en-us/windows/enable-virtualization-on-windows-11-pcs-c5578302-6e43-4b4b-a449-8ced115f58e1)|

&nbsp;

<details>     
   <summary><img style="float: right;" src="https://img.icons8.com/color/96/null/software-installer.png" width="60" height="60"/><h1>&nbsp;安装<h1></summary>

&nbsp;

> **注意**:
> 如果你安装了 Android ™的官方 Windows 子系统，则必须[完全卸载](#uninstallation)使用 MagiskOnWSA.

> 如果你想保留以前安装（官方或 MagiskOnWSA）的数据，你可以在卸载前备份 %LOCALAPPDATA%\Packages\MicrosoftCorporationII.WindowsSubsystemforAndroid_8WEKYB3D8BBWE\LocalCache\UserData.vhdx，并在安装后将其恢复。

1. 转到[发布页面](https://github.com/MustardChef/WSABuilds/releases/latest)
2. 在最新版本中，转到资产部分并下载你选择的 Android ™版本的 Windows 子系统（不要下载“源代码”）。
3. 解压缩 ZIP 文件
4. 删除 ZIP 文件
5. 将新提取的文件夹移动到合适的位置（Documents 文件夹是一个不错的选择），因为你需要将该文件夹保留在 PC 上才能使用 MagiskOnWSA

> **注意**:
> 如果你正在更新 WSA，请在询问时合并文件夹并替换所有项目的文件

6. 打开 Windows Subsystem for Android ™文件夹：搜索并双击 `Run.bat`
   - 如果你以前安装了 MagiskOnWSA，它将自动卸载以前的版本，同时保留所有用户数据并安装新版本，因此无需担心你的数据。
   - 如果弹出窗口在未询问管理权限的情况下消失，并且 Android ™的 Windows 子系统未成功安装，则应以管理员身份手动运行 install.PS1：
      
      - 按 Win+X 并选择 Windows ™终端（管理员）
      
      - 输入下面的命令并按 Enter 键，将 {X：\path\to\your\extracted\folder} （包括 {} ）替换为提取文件夹的路径
        ```Powershell
        cd "{X:\path\to\your\extracted\folder}"
        ```  
        
      - 输入下面的命令并按 Enter 键
        ```Powershell
        PowerShell.exe -ExecutionPolicy Bypass -File .\Install.ps1
        ```
        
      - 脚本将运行，并且将安装 Android ™的 Windows 子系统
      - 如果此解决方法不起作用，则说明你的 PC 不支持 WSA
      
7. 安装过程完成后，Windows Subsystem for Android ™将启动（如果是首次安装，则会显示一个询问是否同意诊断信息的窗口）。有时会显示两个相同的窗口，这很好，如果你在两个窗口中都单击“确定”，则不会发生任何问题）
8. 单击 PowerShell 窗口，然后按键盘上的任意键，PowerShell 窗口应关闭
9. 关闭文件资源管理器
10. **好好享受**

&nbsp;

### 注意事项（适用于 Windows 10 和 11）：

1. 你无法删除 Android ™的 Windows Subsystem 安装文件夹。 `Add-AppxPackage -Register.\AppxManifest.xml` 要做的是用一些现有的未打包文件注册一个 appx 包，所以只要你想使用 Android ™的 Windows 子系统，你就需要保留它们。查看https://learn.microsoft.com/en-us/powershell/module/appx/add-appxpackage?view=windowsserver2022-ps 更多详细信息。
2. 你需要先注册适用于 Android ™ AppX 的 Windows Subsystem 程序包，然后才能运行适用于 Android ™的 Windows Subsystem.对于[WSABuilds](https://github.com/MustardChef/WSABuilds)和[Magiskonwsalocal](https://github.com/LSPosed/MagiskOnWSALocal)用户，你需要在提取的目录中运行 `Run.bat`。如果脚本失败，你可以采取以下步骤进行诊断（需要管理员权限）：
    1. 打开 PowerShell 窗口并将工作目录更改为适用于 Android ™的 Windows 子系统目录。
    
    2. 在 PowerShell 中运行以下命令。这将因 ActivityID 而失败，这是下一步所需的 UUID.
       ```Powershell
       Add-AppxPackage -ForceApplicationShutdown -ForceUpdateFromAnyVersion -Register .\AppxManifest.xml
       ```
       
    3. 在 PowerShell 中运行以下命令。这将打印失败操作的日志。
       ```Powershell
       Get-AppPackageLog -ActivityID <UUID>
       ```
    4. 检查日志，查找故障原因并修复。

</details> 

&nbsp;


<details>     
   <summary><img style="float: right;" src="https://img.icons8.com/external-flaticons-flat-flat-icons/64/null/external-updating-tools-and-material-ecommerce-flaticons-flat-flat-icons.png" width="60" height="60"/><h1>&nbsp;正在更新<h1></summary>

### 如何在不丢失 Windows Subsystem for Android（WSA）上的任何应用程序和数据的情况下进行更新？

1. [下载最新版本](https://github.com/MustardChef/WSABuilds#downloads)（要更新到的）
2. 确保 Windows Subsystem for Android 未运行（单击 WSA 设置中的“关闭”并等待旋转加载器消失）
2. 使用 7-Zip、WinRAR 或选择的任何其他工具，打开.zip 文件
3. 在.zip 存档中，打开子文件夹（示例：WSA_2xxx.xxxxx.XX_XX_release-nightly-with-magisk-xxxxxxx-mindthegapps-XX.X-removedamazon）。
4. 选择此子文件夹中的所有文件，并将它们解压缩到 Windows Subsystem for Android 文件所在的当前文件夹（你从中解压缩并安装 WSA 的文件夹）中。
5. 提示替换文件夹时，选择“对所有当前项目执行此操作”，然后单击“是”
6. 提示替换文件时，单击“替换目标中的文件”
7. 运行``Run.bat``文件
8. 启动 Windows Subsystem for Android 设置应用程序，并使用侧边栏转到``About``选项卡
9. 检查 WSA 版本是否与你要更新到的最新版本/版本号匹配

如果你有任何困难**，就**加入不和谐。


</details>   

&nbsp;

<details>     
   <summary><img style="float: right;" src="https://img.icons8.com/color/96/null/uninstall-programs.png" width="60" height="60"/><h1>&nbsp;卸载<h1></summary>

&nbsp;

### 新的 CLI 和 GUI 卸载工具即将推出！加入 Discord 以获取公告和更新。

> **注意**:
> 
> 如果要保存数据，请对 `%LOCALAPPDATA%\Packages\MicrosoftCorporationII.WindowsSubsystemForAndroid_8wekyb3d8bbwe\LocalCache\userdata.vhdx` 文件进行备份。卸载后，将 VHDX 文件复制回 `%LOCALAPPDATA%\Package\MicrosoftCorporationII.WindowsSubsystemForAndroid_8wekyb3d8bbwe\LocalCache` 文件夹。

- 要删除通过 WSABuild 安装的 WSA，请执行以下操作：

   - **1.)**确保适用于 Android ™的 Windows 子系统未运行
   - 使用内置的 Windows 搜索，或通过“添加和删除程序”**2.)**搜索``Windows Subsystem For Android™ Settings``，然后按"卸载
   - **3.)**删除你解压缩的 wsa 文件夹，并从中运行 run.bat 以安装 wsa（magiskonwsa 文件夹）
   - **4.)**转到``%LOCALAPPDATA%/Packages/``并删除名为``MicrosoftCorporationII.WindowsSubsystemForAndroid_8wekyb3d8bbwe``的文件夹
            
      - 如果你收到一个错误，指出无法删除文件，请确保 WSA 已关闭
     
- 要从 Microsoft Store 中删除已安装的 WSA，请执行以下操作：
        
   - 使用内置的 Windows 搜索，或通过“添加和删除程序”**1.)**搜索``Windows Subsystem For Android™ Settings``，然后按"卸载

</details>

&nbsp;

<details>     
   <summary><img style="float: right;" src="https://img.icons8.com/3d-fluency/94/null/help.png" width="60" height="60"/><h1>&nbsp;常见问题<h1></summary>

&nbsp; **帮帮我，我的Magiskonwsa版本有问题**

- 打开[GitHub中的问题](https://github.com/MustardChef/WSABuilds/issues)或[加入不和谐](https://github.com/MustardChef/WSABuilds#join-the-discord)并充分详细地描述问题

**请帮助我，我在 Windows ™ 10**上安装适用于 Android ™的 Windows 子系统时遇到问题

- 我没有在补丁上工作，也没有声称。在 Discord 或 GitHub 中打开一个问题，如果可能的话，我将尝试帮助你解决问题。要获得全面支持，请访问项目主页并在那里打开一个问题：https://github.com/cinit/WSAPatch/issues/

**如何获得 LogCat？**
- 有两种方法：
   ```
   adb logcat
   ```
   或

-  在 Windows 中的位置---><br/> `%LOCALAPPDATA%\Packages\MicrosoftCorporationII.WindowsSubsystemForAndroid_8wekyb3d8bbwe\LocalState\diagnostics\logcat`

我**可以删除已安装的文件夹吗？**

- 不。

**如何将适用于 Android ™的 Windows 子系统更新到新版本？**

- 正如所解释的[安装说明](#installation)。下载[适用于Android™版本的最新Windows子系统](#downloads)并替换以前安装的内容，然后重新运行 install.PS1. 不用担心，你的数据将被保存

**如何更新 Magisk？**

- 执行与更新适用于 Android ™的 Windows 子系统相同的操作。等待包含较新 Magisk 版本的新 MagiskOnWSA 版本，然后按照[安装说明](#installation)进行更新

我**可以通过 SafetyNet/Play Integrity 吗？**

- 不。由于缺少 Google 签名，像 Windows Subsystem for Android ™这样的虚拟机无法自行通过这些机制。通过需要更奇特的（和未经测试的）解决方案，如：<https://github.com/kdrag0n/safetynet-fix/discussions/145#discussioncomment-2170917>

**什么是虚拟化？**

- 要运行 Windows Subsystem for Android ™等虚拟机，需要进行虚拟化。 `Run.bat` 帮助你启用它。重新启动后，重新运行 `Run.bat` 以安装适用于 Android ™的 Windows 子系统。如果它仍然不工作，你必须在 BIOS/UEFI 中启用虚拟化。说明因 PC 供应商而异，请查看联机帮助

我**可以以读写方式重新挂载系统分区吗？**

- 不。适用于 Android ™的 Windows 子系统由 Hyper-V 以只读方式装载。但是，你可以通过创建 Magisk 模块或直接修改 System.IMG 文件来修改系统分区

**我无法 ADB 连接本地主机：58526**

- 确保已启用开发人员模式。如果问题仍然存在，请在“设置”-->“开发人员”页面上检查 Android ™的 Windows 子系统的 IP 地址，然后尝试

   ```
   adb connect ip:5555
   ```

**Magisk 在线模块列表为空？**

- Magisk 主动删除在线模块存储库。你可以在本地安装该模块，也可以通过
  
   **步骤1**
      
      ADB 推送模块.zip/data/local/TMP

   **步骤2**

      ADB shell su-C magisk--install-module/data/local/TMP/module.zip


**如何卸载 Magisk？**

- 使用[Issues](https://github.com/MustardChef/WSABuilds/issues)从[发布页面](https://github.com/MustardChef/WSABuilds/releases/latest)请求不包含 Magisk 的 Android ™版本的 Windows 子系统。然后按照[安装说明](#installation)

我**可以在 OpenGApps 和 MindTheGApps 之间切换吗？**

- 不。GAPPS 将不再发挥作用。在切换前执行[完成卸载](#uninstallation)

**如何安装自定义 Magisk 或 Gapps？**

- 要请求使用自定义 Magisk 或 Gapps 进行构建，请随时在中[问题页面](https://github.com/MustardChef/WSABuilds/issues.)打开问题。你也可以通过使用[Magiskonwsalocal](https://github.com/LSPosed/MagiskOnWSALocal)脚本并按照 repo 中提供的说明来实现这一点。
</details>

&nbsp;

<details>     
   <summary><img style="float: right;" src="https://img.icons8.com/external-xnimrodx-lineal-color-xnimrodx/96/null/external-guide-education-xnimrodx-lineal-color-xnimrodx.png" width="60" height="60"/><h1>&nbsp;使用指南<h1></summary>

&nbsp;

### GPU 指南：
[<img src="https://img.shields.io/badge/-How%20to%20Change%20the%20GPU%20Used-474154?style=for-the-badge&logoColor=white&logo=github" />] （https：//github.com/mustardchef/wsabuilds/blob/master/guides/changinggpu.md）

### 侧载导轨：
[<img src="https://img.shields.io/badge/-How%20to%20Sideload%20apps-474154?style=for-the-badge&logoColor=white&logo=github" />] （https：//github.com/mustardchef/wsabuilds/blob/master/guides/sideloading.md）

### 将 WSA 移动到另一个驱动器或分区：
[<img src="https://img.shields.io/badge/-How%20to%20Move%20WSA%20to%20another%20drive%20or%20partition-474154?style=for-the-badge&logoColor=white&logo=github" />] （https：//github.com/mustardchef/wsabuilds/blob/master/guides/movetoextdrive.md）

### 安装 KernelSU
[<img src="https://img.shields.io/badge/-How%20to%20install%20KernelSU-474154?style=for-the-badge&logoColor=white&logo=github" />] （https：//github.com/mustardchef/wsabuilds/blob/master/guides/kernelsu.md）

### 正在安装 BusyBox

[<img src="https://img.shields.io/badge/-How%20to%20install%20BusyBox-474154?style=for-the-badge&logoColor=white&logo=github" />] （https：//github.com/mustardchef/wsabuilds/blob/master/guides/busybox.md）

</details> 

&nbsp;

<details>     
   <summary><img style="float: right;" src="https://img.icons8.com/external-soft-fill-juicy-fish/96/null/external-bug-coding-and-development-soft-fill-soft-fill-juicy-fish-2.png" width="60" height="60"/><h1>&nbsp;有问题吗？<h1></summary>

### 常见问题：
[<img src="https://img.shields.io/badge/-Fix%20Install.ps1%20Issue-%23EF2D5E?style=for-the-badge&logoColor=white&logo=Github" />] （https：//github.com/mustardchef/wsabuilds/blob/master/fixes/fixinstallps1.md）

[<img src="https://img.shields.io/badge/-Fix Virtualization and Virtual Machine Platform Error-%23EF2D5E?style=for-the-badge&logoColor=white&logo=github" />] （https：//github.com/mustardchef/wsabuilds/blob/master/fixes/fixvirterror.md）

[<img src="https://img.shields.io/badge/-Fix%20Internet%20Issues-%23EF2D5E?style=for-the-badge&logoColor=white&logo=Github" />] （https：//github.com/mustardchef/wsabuilds/blob/master/fixes/fixinternet.md）

[<img src="https://img.shields.io/badge/-Fix%20Error%200x80073CFD-%23EF2D5E?style=for-the-badge&logoColor=white&logo=Github" />] （https：//github.com/mustardchef/wsabuilds/blob/master/fixes/fix%20error%200x80073cfd.md）

[<img src="https://img.shields.io/badge/-Fix%20Error%200x80073CF6-%23EF2D5E?style=for-the-badge&logoColor=white&logo=Github" />] （https：//github.com/mustardchef/wsabuilds/blob/master/fixes/fix%20error%200x80073cf6.md）

[<img src="https://img.shields.io/badge/-Fix%20Error%200x80073CF9-%23EF2D5E?style=for-the-badge&logoColor=white&logo=Github" />] （https：//github.com/mustardchef/wsabuilds/blob/master/fixes/fix%20error%200x80073cf9.md）

[<img src="https://img.shields.io/badge/-Fix%20Error%200x80073D10-%23EF2D5E?style=for-the-badge&logoColor=white&logo=Github" />] （https：//github.com/mustardchef/wsabuilds/blob/master/fixes/fix%20error%200x80073d10.md）
      
[<img src="https://img.shields.io/badge/-NamedResource%20Not%20Found:%20Fix%20Error%200x80073B17-%23EF2D5E?style=for-the-badge&logoColor=white&logo=Github" />](https://github.com/MustardChef/WSABuilds/blob/master/Fixes/NamedResource%20Not%20Found%20-%20Fix%20Error%200x80073B17.md)

[<img src="https://img.shields.io/badge/-Fix%20Path%20Too%20Long-%23EF2D5E?style=for-the-badge&logoColor=white&logo=Github" />] （https：//github.com/mustardchef/wsabuilds/blob/master/fixes/fixpathtoolong.md）

[<img src="https://img.shields.io/badge/-Fix%20Missing%20Icons%20Issue-%23EF2D5E?style=for-the-badge&logoColor=white&logo=Github" />] （https：//github.com/mustardchef/wsabuilds/blob/master/fixes/missingicons.md）

</details>  

<!--
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
-->

&nbsp;      
      
<details>     
   <summary><img style="float: right;" src="https://img.icons8.com/external-flaticons-lineal-color-flat-icons/64/null/external-credits-movie-theater-flaticons-lineal-color-flat-icons.png" width="60" height="60"/><h1>&nbsp;学分<h1></summary>

- [Microsoft](https://apps.microsoft.com/store/detail/windows-subsystem-for-android%E2%84%A2-with-amazon-appstore/9P3395VX91NR)：用于提供 Android ™的 Windows 子系统和相关文件。Windows Subsystem for Android ™、Windows Subsystem for Android ™徽标、Windows ™ 10 和 Windows ™ 11 徽标是 Microsoft Corporation 的商标。Microsoft Corporation 保留对这些商标的所有权利。下载并安装适用于 Android ™的 Windows 子系统，即表示你同意[条款和条件](https://support.microsoft.com/en-gb/windows/microsoft-software-license-terms-microsoft-windows-subsystem-for-android-cf8dfb03-ba62-4daa-b7f3-e2cb18f968ad)和[隐私政策](https://privacy.microsoft.com/en-gb/privacystatement)
- [YT-高级](https://github.com/YT-Advanced/WSA-Script)：为了提供并继续开发 Lsposed 制作的脚本，GitHub 操作工作流程指南基于他的 GitHub repo.我不认为他的工作和许多贡献者的工作是我自己的，也不打算这样做。
- [CINIT和WSAPATCH指南](https://github.com/cinit/WSAPatch)：非常感谢 CINIT 和 WSAPATCH 存储库的贡献者提供的全面指南、文件和支持。此回购协议中的 Windows ™ 10 构建依赖于此项目的辛勤工作，因此给予了应有的信任。
- [StoreLib](https://github.com/StoreDev/StoreLib)：用于下载 WSA 的 API
- [Magisk](https://github.com/topjohnwu/Magisk)：Android 的神奇面具
- [开放谷歌应用程序项目](https://opengapps.org)：编写自动生成最新 Google Apps 软件包的脚本
- [WSA-Kernel-SU](https://github.com/LSPosed/WSA-Kernel-SU)：一个内核模块，为 Android 内核提供/system/xbin/su
- [内核辅助超级用户](https://git.zx2c4.com/kernel-assisted-superuser)：获得 Android 的 root shell 的内核辅助方法
- [沃萨加斯克里普](https://github.com/ADeltaX/WSAGAScript)：WSA 的第一个 GAPPS 集成脚本
- [Magiskonwsa](https://github.com/LSPosed/MagiskOnWSA)： `Deprecated` 将 Magisk Root 和 Google Apps 集成到 WSA 中
- [Magiskonwsalocal](https://github.com/LSPosed/MagiskOnWSALocal)：将 Magisk Root 和 Google Apps 集成到 WSA 中

***存储库是作为实用程序提供的。***

***Android是Google LLC的商标。Windows™是Microsoft LLC的商标。***

</details> 
