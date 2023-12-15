# WSABuilds &nbsp; &nbsp; <img src="https://img.shields.io/github/downloads/MustardChef/WSABuilds/total?label=Total%20Downloads&style=for-the-badge"/> &nbsp; 
   
<picture><img style="float: left;" src="https://img.icons8.com/3d-fluency/94/null/help.png" width="60" height="60"/></picture><h1> &nbsp; FAQ</h1>

&nbsp;
**Help me, I am having problems with the MagiskOnWSA Builds**

- Open an [issue in Github](https://github.com/MustardChef/WSABuilds/issues) or [join the Discord](https://github.com/MustardChef/WSABuilds#join-the-discord) and describe the issue with sufficent detail

**Help me, I am having problems with installing Windows Subsystem For Android™ on Windows™ 10**

- I am not working on the patch, and nor claim to.  Open an issue in the Discord or Github, and I will try to assist you with the problem if possible. For full support visit the project homepage and open an issue there: https://github.com/cinit/WSAPatch/issues/

**How do I get a logcat?**
- There are two ways:
   ```
   adb logcat
   ```
   or

-  Location in Windows ---> <br /> `%LOCALAPPDATA%\Packages\MicrosoftCorporationII.WindowsSubsystemForAndroid_8wekyb3d8bbwe\LocalState\diagnostics\logcat`

**Can I delete the installed folder?**

- No.

**How can I update Windows Subsystem For Android™ to a new version?**

- As Explained [Installation instructions](#installation). Download the [latest Windows Subsystem For Android™ Version](#downloads) and replace the content of your previous installation and rerun Install.ps1. Don't worry, your data will be preserved

**How do I update Magisk?**

- Do the same as updating Windows Subsystem For Android™.  Wait for a new MagiskOnWSA release that includes the newer Magisk version, then follow the [Installation instructions](#installation) to update

**Can I pass SafetyNet/Play Integrity?**

- No. Virtual machines like Windows Subsystem For Android™ cannot pass these mechanisms on their own due to the lack of signing by Google. Passing requires more exotic (and untested) solutions like: <https://github.com/kdrag0n/safetynet-fix/discussions/145#discussioncomment-2170917>

**What is virtualization?**

- Virtualization is required to run virtual machines like Windows Subsystem For Android™.  `Run.bat` helps you enable it. After rebooting, re-run `Run.bat` to install Windows Subsystem For Android™.  If it's still not working, you have to enable virtualization in your BIOS/UEFI. Instructions vary by PC vendor, look for help online

**Can I remount system partition as read-write?**

- No. Windows Subsystem For Android™ is mounted as read-only by Hyper-V. You can, however, modify the system partition by creating a Magisk module, or by directly modifying the system.img file

**I cannot adb connect localhost:58526**

- Make sure developer mode is enabled. If the issue persists, check the IP address of Windows Subsystem For Android™ on the Settings ---> Developer page and try 

   ```
   adb connect ip:5555
   ```

**Magisk online module list is empty?**

- Magisk actively removes the online module repository. You can install the module locally or by 
  
   **Step 1** 
      
      adb push module.zip /data/local/tmp

   **Step 2**  

      adb shell su -c magisk --install-module /data/local/tmp/module.zip


**How do I uninstall Magisk?**

- Request, using [Issues](https://github.com/MustardChef/WSABuilds/issues), a Windows Subsystem For Android™ version that doesn't include Magisk from the [Releases page](https://github.com/MustardChef/WSABuilds/releases/latest). Then follow the [Installation instructions](#installation)

**Can I switch between OpenGApps and MindTheGapps?**

- No. GApps will no longer function. Do a [complete uninstallation](#uninstallation) before switching

**How do I install custom Magisk or GApps?**

- To request a build with custom Magisk or GApps, feel free to open an issue in the [Issues page](https://github.com/MustardChef/WSABuilds/issues.) You can also achieve this by using the [MagiskOnWSALocal](https://github.com/LSPosed/MagiskOnWSALocal) Script and following the provided instructions located in the repo.
</details>