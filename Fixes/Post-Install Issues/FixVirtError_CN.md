# WSABuilds &nbsp; &nbsp; <img src="https://img.shields.io/github/downloads/MustardChef/WSABuilds/total?label=Total%20Downloads&style=for-the-badge"/> &nbsp; 

&nbsp;
&nbsp;

## 问题：

&nbsp;
&nbsp;

<img src="https://user-images.githubusercontent.com/68629435/213985345-a6fc6e97-63f3-4741-8965-8d62a0d6b824.png"/>

## 解决方法：

即使在BIOS中启用了虚拟化，并且在任务管理器中显示启用的情况下（如下所示），您仍可能会遇到此问题，并出现“虚拟机平台”+“Windows Hypervisor平台”。解决方案如下：

&nbsp;

1. ***删除 WSA***：右键单击“Windows Subsystem for Android™ Settings”，然后单击“卸载”，删除提取的 WSA（从中提取和安装的 MagiskOnWSA 文件夹），并转到 %LOCALAPPDATA%/Packages/ 并删除该文件夹：MicrosoftCorporationII.WindowsSubsystemForAndroid_8wekyb3d8bbwe

2. ***打开 "打开或关闭Windows功能" 并禁用Hyper-V、虚拟机平台、Windows Hypervisor平台和Windows子系统 Linux，然后重新启动。****

3. ***重新启用这些功能并再次重新启动。*** 

4. ***确保在Windows安全性 > 应用和浏览器控制 > 漏洞利用保护中启用了控制流防护。*** 这是一个已知的问题，可能会阻止WSA启动

5.  ***在注册表编辑器 (regedit) 中，转到 “\HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\FsDepends"***

    将 “Start” 的值从 “3” 改为 “0”

> **注意**
> 如果没有任何区别，您可以将其更改回3

6. ***然后在CMD（以管理员身份运行）中，粘贴：*** 
```cmd
bcdedit /set hypervisorlaunchtype auto
```

7. ***重新启动电脑***

8. ***通过运行 `Run.bat` 重新安装WSA***


&nbsp;

**希望这对您有帮助！**

如果您有任何其他问题或需要帮助，请加入我们的Discord！

[<img src="https://invidget.switchblade.xyz/2thee7zzHZ" style="width: 400px;"/>](https://discord.gg/2thee7zzHZ)
