# WSABuilds &nbsp; &nbsp; <img src="https://img.shields.io/github/downloads/MustardChef/WSABuilds/total?label=%E6%80%BB%E4%B8%8B%E8%BD%BD%E6%AC%A1%E6%95%B0&style=for-the-badge"/> &nbsp; 

## 问题：更新 WSA 或重新启动计算机后，图标消失或变成白色

</br>

### 前言：
##### 这看起来像是 WSA 本身的一个 bug，可以通过以下步骤恢复图标。

</br>
</br>

## 解决方法
 
**1.** 备份 `%LOCALAPPDATA%\Packages\MicrosoftCorporationII.WindowsSubsystemForAndroid_8wekyb3d8bbwe\LocalCache\userdata.vhdx` 中的 `userdata.vhdx`

**2.** 按照[此指南](https://github.com/MustardChef/WSABuilds#--uninstallation)卸载 WSA。
 
**3.** 从 `Install.ps1` 中删除在安装完成后自动启动 Magisk 和 Play Store 的两行代码

```powershell
function Finish {
    Clear-Host
    Start-Process "wsa://com.topjohnwu.magisk"
    Start-Process "wsa://com.android.vending"
}
```

**4.** 安装 WSA
 
**5.** 将备份的 `userdata.vhdx` 恢复到 `%LOCALAPPDATA%\Packages\MicrosoftCorporationII.WindowsSubsystemForAndroid_8wekyb3d8bbwe\LocalCache\userdata.vhdx`

**6.** 启动 WSA

</br>

> **警告**
> **恢复用户数据之前不要启动 WSA。**

</br>

---

### 有进一步问题或需要帮助吗？

如果您有任何其他问题或需要帮助，请加入 Discord！

[<img src="https://invidget.switchblade.xyz/2thee7zzHZ" style="width: 400px;"/>](https://discord.gg/2thee7zzHZ)
