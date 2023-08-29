# WSABuilds &nbsp; &nbsp; <img src="https://img.shields.io/github/downloads/MustardChef/WSABuilds/total?label=Total%20Downloads&style=for-the-badge"/> &nbsp; 

&nbsp;
&nbsp;

<details>     
   <summary><h2>问题:<h2><h3> &nbsp; Install.ps1未被识别/丢失<h3></summary>

&nbsp;
&nbsp;



<img src="https://media.discordapp.net/attachments/1044322950725259274/1068243571544690719/9Qf3veK.png" />
<img src="https://user-images.githubusercontent.com/68516357/215262023-89e0e0fa-3dd7-4d6d-b93a-224169f61971.png" />
 
</details>

<details>     
   <summary><h2>解决方案<h2></summary>

&nbsp;
    
如果弹出窗口没有请求管理员权限并且 Windows 子系统 for Android™ 没有成功安装，您应该手动以管理员身份运行 Install.ps1：

&nbsp;  

### **1. 在键盘上按 Win + X，根据您正在运行的 Windows™ 版本选择 Windows™ 终端 (管理员) 或 Powershell (管理员)**

|||
|--------|------|
|<img src="https://upload.wikimedia.org/wikipedia/commons/e/e6/Windows_11_logo.svg" style="width: 200px;"/> |<img src="https://upload.wikimedia.org/wikipedia/commons/0/05/Windows_10_Logo.svg" style="width: 200px;"/> |
|![215262254-7466d964-3956-4d71-8014-e2c5869ca4d4](https://user-images.githubusercontent.com/68516357/215263173-500591dd-c6d5-4c2d-9d38-58bc065fff28.png)|![winx_editor-1](https://user-images.githubusercontent.com/68516357/215263348-022dc031-802f-4e93-8999-05d0aa6744b9.png)|

&nbsp;    
### **2. 输入下面的命令，替换 {X:\path\to\your\extracted\folder} 包括{}中的路径为解压后文件夹的路径**

```Powershell
  cd "{X:\path\to\your\extracted\folder}"
```
&nbsp; 
### **3. 输入下面的命令并按 Enter 键** 

```Powershell
  PowerShell.exe -ExecutionPolicy Bypass -File .\Install.ps1
```  
&nbsp;  
### **4. 脚本将运行，Windows 子系统 for Android™ 将被安装**

</details>
