## Issues:
### No Internet

![image](https://user-images.githubusercontent.com/68516357/215296995-4a8c9184-321e-438f-9483-6983ce65ce47.png) ![IMG-20230627-WA0012 cropped](https://github.com/MustardChef/WSABuilds/assets/68516357/a108b1df-2e03-4a52-9e0a-d0004a9d3585)


## Solution: 
These will be split into multiple solutions due to the different causes of the problem of no internet on Windows Subsystem for Android (WSA) and Windows Subsytem for Linux (WSL) 

---

<details>     
   <summary><h3>Fix #1: Uninstalling Hyper-V Network Adapters<h3></summary>

**Some Hyper-V Network Drivers may be interferring with WSA or WSL**

**⚠️ Carry these instructions out with caution. ⚠️**

**⚠️ I do not take responsibility for any damage caused ⚠️**
     
#### **Step 1: Open Device Manager**
1. Using Search or Win + X, open Device manager
![image](https://user-images.githubusercontent.com/68516357/215346473-88649375-6a5b-46b2-80bb-6f6551c23c5f.png)
&nbsp;
#### **Step 2: Show Hidden Device**
3. Press on "View" 
4. Select "Show hidden devices"
![image](https://user-images.githubusercontent.com/68516357/215347683-6c84663c-a3cb-4e79-bc63-a2cdf91bb4ef.png)
&nbsp;
#### **Step 3: Uninstalling All Hyper-V Network Adapter**
5. Select each driver that has "Hyper-V" in its name
6. Right-Click and select "Uninstall Driver" for each of these drivers
![image](https://user-images.githubusercontent.com/68516357/215347543-91c71429-26fe-44a2-b818-dd9bfeb6bcaf.png)
#### **Step 4: Restart Windows**
![](https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fwww.4winkey.com%2Fimages%2Farticle%2Fwindows-tips%2Frestart-screen-stuck.jpg&f=1&nofb=1&ipt=2b826a4d045dc39aaa0487ea2338289d905c9f94c365f5f606334100a1ec9cb1&ipo=images)
</details>

---
<details>     
   <summary><h3>Fix #2: Checking Firewall Settings<h3></summary>
   
Sometimes Windows Firewall and other Firewall tools and software may be the cause of internet issues. It is therefore important that we check them if we are facing issues with internet on WSA.    

  
   <summary><h4>Users with Windows Firewall<h4></summary>

****1. Open Windows Firewall by pressing the Windows Key and "R" key, Open Run****

****2. Type WF.msc, and then select OK. See also [Open Windows Firewall](https://learn.microsoft.com/en-us/windows/security/operating-system-security/network-security/windows-firewall/best-practices-configuring)****

****3. Go to the "Inbound Connection" tab****

![image](https://github.com/MustardChef/WSABuilds/assets/68516357/c2863479-fc0d-46cc-a211-815026e68dfd)

****4. Find the entries in the list that state: "Windows Subsystem for Android™"**** 

![image](https://github.com/MustardChef/WSABuilds/assets/68516357/6c16b5fe-6670-4467-b8b4-f8feb9de0210)

![image](https://github.com/MustardChef/WSABuilds/assets/68516357/00b8a9cc-620b-41b7-9135-0796af2ee72e)

![image](https://github.com/MustardChef/WSABuilds/assets/68516357/607a0be4-9898-43dd-b3c9-38b6429a2f30)


****5. Confirm that these entries are Enabled and "Action" is set to "Allow" for both UDP and TCP for all entries (as shown above)**** 

****6. Now, go to the "Outbound Connection" tab****

![image](https://github.com/MustardChef/WSABuilds/assets/68516357/051c1f4d-1eaa-4055-81e7-4f7299cd7c56)

****7. Find the entries in the list that state: "Windows Subsystem for Android™"**** 

![image](https://github.com/MustardChef/WSABuilds/assets/68516357/5db5319c-00cf-47ed-9ded-8610bfff1702)

![image](https://github.com/MustardChef/WSABuilds/assets/68516357/574947cf-68be-4aa4-a002-8edf4dd48527)

****5. Confirm that these entries are Enabled and "Action" is set to "Allow" for both UDP and TCP for all entries (as shown above)**** 

<br>

> <picture>
>   <source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/Mqxx/GitHub-Markdown/main/blockquotes/badge/light-theme/tip.svg">
>   <img alt="Tip" src="https://raw.githubusercontent.com/Mqxx/GitHub-Markdown/main/blockquotes/badge/dark-theme/tip.svg">
> </picture><br>
>     
> You may not have as many entries for "Windows Subsystem for Android™", as shown in the screenshots provded. These are just for illustration purposes and Firewall entries may look different on your device.    


   <summary><h4>Antivirus Users<h4></summary>

It is a known issue that some antivirus firewall such as those built-in to ESET, Bitdefender, AVG and many others, can prevent the internet for Windows Susbsystem for Android (WSA) from working.
It is highly recommended to disable the firewall provided by these Antivirus/Antimalware tools and fallback to Windows Firewall, to see if the internet starts working.

Source: From [this](https://community.bitdefender.com/en/discussion/91237/bitdefender-blocking-wsl2-traffic-solution-to-a-thread-that-was-left-unresolved) 


</details> 


---

<details>     
   <summary><h3>Fix #3: Changing Android DNS Settings<h3></summary>

****1. Open Windows Firewall by pressing the Windows Key and "R" key, Open Run****

****2. Type wsa://com.android.settings, and then select OK.****

****3. Wait for Android Settings to load and open.****

****4. In Android Settings, click on the "Network and Internet" Section.****

****5. In the "Network and Internet" Section, select "Private DNS" .****

****6. In the "Select Private DNS mode", click on "Private DNS provider hostname".****

****7. In the entry box below, type "dns.google" and click save.****

****8. Now click on the "Internet" section and click on VirtWifi.****

****9. Click on "Disconnect".****

****10. Then click on "Connect".****

Your Internet should now be fixed!


</details> 

---

<details>     
   <summary><h3>Fix #4: Enabling and Disabling Advanced Networking from WSA Settings<h3></summary>

1. Go to the Start Menu and search for Windows Subsystem for Android™
2. Depending on your WSA version, the Advanced Networking setting is located in different places witin the WSA Settings app

- For 2305 and newer builds, you must go to "Advanced settings" and then to "Experimental features"
- For 2304 and older builds, this setting is located in the "System" tab/ main screen when you open the Settings app

3. Make sure that if Advanced Networking is enabled, you disable it as this may be causing issues with the internet

This should fix the internet if Advanced Networking was on and the internet was not working due to this

</details> 
