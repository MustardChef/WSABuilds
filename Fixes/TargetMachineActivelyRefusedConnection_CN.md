# WSABuilds &nbsp; &nbsp; <img src="https://img.shields.io/github/downloads/MustardChef/WSABuilds/total?label=Total%20Downloads&style=for-the-badge"/> &nbsp; 

---
## 问题: </br> 错误：无法建立连接，因为目标计算机积极拒绝 (10061)
### 前言：
##### 当您使用诸如 [WSA-Sideloader](https://github.com/infinitepower18/WSA-Sideloader) 或 [WSAPacman](https://github.com/alesimula/wsa_pacman) 的侧载应用程序，或尝试使用 [Android SDK 平台工具](https://developer.android.com/tools/releases/platform-tools) 的 ``adb.exe`` 连接设备时，将出现此问题。由于 Hyper V 无法保留端口 58526，因此会导致此问题，如下所示。

![image](https://user-images.githubusercontent.com/68516357/230793765-6c72a7d7-796f-4cb9-8a45-3d40b4f1d38f.png)

```
cannot connect to ||127.0.0.1:58526:|| No connection could be made because the target machine actively refused it. (10061)
```
---

## 解决方案

这是子系统本身的 [错误](https://github.com/microsoft/WSA/issues/136)，重新启动计算机通常可以解决该问题。

如果您仍然遇到此错误，请尝试以下步骤：

1. 确保关闭 WSA 并在继续之前在任务管理器 ---> 启动应用程序中禁用 WSA 自启动

2. 使用命令 ``dism.exe /Online /Disable-Feature:Microsoft-Hyper-V`` 禁用 Hyper-V 并重新启动计算机

3. 使用命令 `netsh int ipv4 add excludedportrange protocol=tcp startport=58526 numberofports=1` 保留端口 58526，以免 Hyper-V 将其保留回来

4. 使用命令 `dism.exe /Online /Enable-Feature:Microsoft-Hyper-V /All` 重新启用 Hyper-V 并重新启动计算机

现在应该已经解决了您的问题！

<br/>
<br/>

**希望这对您有帮助！**

如果您有任何其他问题或需要帮助，请加入 Discord！

[<img src="https://invidget.switchblade.xyz/2thee7zzHZ" style="width: 400px;"/>](https://discord.gg/2thee7zzHZ)
