# WSABuilds &nbsp; &nbsp; <img src="https://img.shields.io/github/downloads/MustardChef/WSABuilds/total?label=Total%20Downloads&style=for-the-badge"/> &nbsp; 

---

## 问题: </br> 运行 "Run.bat" 安装安卓子系统 (WSA) 时出现错误代码 0x80073CF9
### 前言:
##### 这个问题可能由许多因素引起，例如下载 .zip 文件或从 .zip 文件中提取文件时的文件损坏。这也可能是由于文件夹名称过长导致（这是由于 MagiskOnWSA 倾向于为 .zip 文件和存档内的文件夹生成一个长字符串。）

<img src="https://user-images.githubusercontent.com/68516357/219852713-fde4520d-9fa8-4c8b-80e6-ac2adecbeae9.png" style="width: 600px;"/>  

---

## 解决方案

**1. 确保你要安装的分区/驱动器是 NTFS 格式**

**2. 从 [Releases 页面](https://github.com/MustardChef/WSABuilds/releases) 重新下载 WSA Build .zip 文件 (有时下载和提取过程中可能会损坏文件)**

**3. 将 .zip 文件夹重命名为较短的名称，可以是任何你选择的名称 </br> (例如: WSA_2XXX.XXXXX.X.X_XXXX_Release-Nightly-with-magisk-XXXXXXX-XXXXXX-MindTheGapps-XX.X-RemovedAmazon ----> WSAArchive2XXX)**

**4. 使用 WinRAR 或适当的压缩工具而不是内置的 Windows .zip 解压程序提取 .zip 文件**

**5. 将提取后的文件夹重命名为较短的名称，可以是任何你选择的名称 </br> (例如: WSA_2XXX.XXXXX.X.X_XXXX_Release-Nightly-with-magisk-XXXXXXX-XXXXXX-MindTheGapps-XX.X-RemovedAmazon ----> WSAExtracted2XXX)**

**6. 确保以管理员身份运行 "Run.bat"**

**希望这对你有帮助！**

---

### 还有问题或需要帮助吗？

如果您有任何其他问题或需要帮助，请加入 Discord！

[<img src="https://invidget.switchblade.xyz/2thee7zzHZ" style="width: 400px;"/>](https://discord.gg/2thee7zzHZ)
