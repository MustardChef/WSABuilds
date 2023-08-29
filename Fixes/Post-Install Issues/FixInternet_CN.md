# WSABuilds &nbsp; &nbsp; <img src="https://img.shields.io/github/downloads/MustardChef/WSABuilds/total?label=Total%20Downloads&style=for-the-badge"/> &nbsp; 

# **⚠️ 指南是不完整的 ⚠️**

&nbsp;
&nbsp;

## Issues:
### 没有互联网 
![image](https://user-images.githubusercontent.com/68516357/215296995-4a8c9184-321e-438f-9483-6983ce65ce47.png)

&nbsp;
&nbsp;
&nbsp;
&nbsp;

## Solution: 
这些解决方法会因为在 Windows Subsystem for Android (WSA) 和 Windows Subsytem for Linux (WSL) 中没有网络的原因不同而被分成多个解决方法。

<details>     
   <summary><h3>解决方法 #1: 卸载 Hyper-V 网络适配器<h3></summary>

**某些 Hyper-V 网络驱动可能会干扰 WSA 或 WSL**
&nbsp;

**⚠️ 谨慎执行以下操作。 ⚠️**

**⚠️ 我不对造成的任何损害负责 ⚠️**
     
&nbsp;
#### **步骤 1：打开设备管理器**
1. 使用搜索或 Win + X，打开设备管理器
![image](https://user-images.githubusercontent.com/68516357/215346473-88649375-6a5b-46b2-80bb-6f6551c23c5f.png)
&nbsp;
#### **步骤 2：显示隐藏设备**
3. 点击 "查看"
4. 选择 "显示隐藏设备"
![image](https://user-images.githubusercontent.com/68516357/215347683-6c84663c-a3cb-4e79-bc63-a2cdf91bb4ef.png)
&nbsp;
#### **步骤 3：卸载所有 Hyper-V 网络适配器**
5. 选择名称中带有 "Hyper-V" 的每个驱动程序
6. 对于每个驱动程序，右键单击并选择 "卸载驱动程序"
![image](https://user-images.githubusercontent.com/68516357/215347543-91c71429-26fe-44a2-b818-dd9bfeb6bcaf.png)
#### **步骤 4：重启 Windows**
![](https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fwww.4winkey.com%2Fimages%2Farticle%2Fwindows-tips%2Frestart-screen-stuck.jpg&f=1&nofb=1&ipt=2b826a4d045dc39aaa0487ea2338289d905c9f94c365f5f606334100a1ec9cb1&ipo=images)

</details>

<!--
![image](https://user-images.githubusercontent.com/68516357/215297044-40f32db5-2b0e-40bd-be50-11d451b7811e.png)

![image](https://user-images.githubusercontent.com/68516357/215297069-594fec55-0f26-4f4a-ab03-4902d4277054.png)

![image](https://user-images.githubusercontent.com/68516357/215297085-89072f6e-bfe0-4422-afbc-33f939382058.png)

![image](https://user-images.githubusercontent.com/68516357/215323733-1c071249-3b0c-490e-a69b-59befccdde6e.png)

![image](https://user-images.githubusercontent.com/68516357/215323705-0688b8ee-4451-4e7b-8a33-8335facc0d91.png)
--!>
