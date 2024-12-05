# Magisk on WSA (with Google Apps)

:warning: Magisk on WSA will no longer be available after March 5, 2025. [Learn more](https://learn.microsoft.com/en-us/windows/android/wsa/).

:warning: For fork developers: Please don't build using GitHub Actions, as GitHub will count your forked GitHub Actions usage against this upstream repository, which may cause this upstream repository gets disabled by GitHub staff like [MagiskOnWSA](https://github.com/LSPosed/MagiskOnWSA) because of numerous forks building GitHub Actions, and counting the forks' Action usage against this upstream repository.

## Support for generating from these systems

- Linux (x86_64 or arm64)

  The following dependencies are required:

  | DistrOS             |                            |            |                    |               |               |
  |:-------------------:|----------------------------|------------|--------------------|---------------|---------------|
  | Debian              | `python3 aria2 unzip sudo` | `whiptail` | `python3-venv`     | `python3-pip` | `p7zip-full`  |
  | openSUSE Tumbleweed | Same as above              | `dialog`   | `python3-venvctrl` | Same as above | Same as above |
  | Arch                | Same as Debian             | `libnewt`  |  Same as Debian    | `python-pip`  | `p7zip`       |

  The python3 library `requests` is used.

  Python version ≥ **3.7.2**.

  - Recommended use

    - Ubuntu (You can use [WSL2](https://apps.microsoft.com/store/search?publisher=Canonical%20Group%20Limited))

      Ready to use right out of the box.

    - Debian (You can use [WSL2](https://apps.microsoft.com/store/detail/debian/9MSVKQC78PK6))

      Ready to use right out of the box.

    - openSUSE Tumbleweed (You can use [WSL2](https://apps.microsoft.com/store/detail/opensuse-tumbleweed/9MSSK2ZXXN11))

      Ready to use right out of the box.

    `run.sh` will handle all dependencies automatically.

    No need to type any commands.

## Features

- Integrate Magisk and GApps in a few clicks within minutes
- Keep each build up to date
- Support both ARM64 and x64
- Support MindTheGapps
- Remove Amazon Appstore
- Fix VPN dialog not showing (use our [VpnDialogs app](https://github.com/LSPosed/VpnDialogs))
- Add device administration feature
- Unattended installation
- Automatically activates developers mode in Windows 11
- Update to the new version while preserving data with a one-click script
- Merged all language packs

## Text Guide

1. Star (if you like).
2. Clone the repo to local:

   ```bash
   git clone https://github.com/LSPosed/MagiskOnWSALocal.git --depth 1
   ```

3. Run `cd MagiskOnWSALocal`.
4. Run `./scripts/run.sh`.
5. Select the WSA version and its architecture (mostly x64).
6. Select the version of Magisk.
7. Choose which brand of GApps you want to install:
   - MindTheGapps

     There is no other variant we can choose.
8. Select the root solution (none means no root).
9. If you are running the script for the first time, it will take some time to complete. After the script completes, two new folders named `output` and `download` will be generated in the `MagiskOnWSALocal` folder. Go to the `output` folder. While running the `./run.sh` script in the step 3, if you selected `Yes` for `Do you want to compress the output?` then in `output` folder you will see a compressed file called `WSA-with-magisk-stable-MindTheGapps_2207.40000.8.0_x64_Release-Nightly`or else there will be folder with the `WSA-with-magisk-stable-MindTheGapps_2207.40000.8.0_x64_Release-Nightly`. If there is a folder open it and skip to step 10. NOTE: The name of compressed file or the folder generated in the `output` folder may be different for you. It will be dependent on the choices made when executing `./run.sh`.
10. Extract the compressed file and open the folder created after the extraction of the file.
11. Here look for file `Run.bat` and run it.
    - If you previously have a MagiskOnWSA installation, it will automatically uninstall the previous one while **preserving all user data** and install the new one, so don't worry about your data.
    - If you have an official WSA installation, you should uninstall it first. (In case you want to preserve your data, you can backup `%LOCALAPPDATA%\Packages\MicrosoftCorporationII.WindowsSubsystemForAndroid_8wekyb3d8bbwe\LocalCache\userdata.vhdx` before uninstallation and restore it after installation.)
    - If the popup windows disappear **without asking administrative permission** and WSA is not installed successfully, you should manually run `Install.ps1` as Administrator:
        1. Press `Win+x` and select `Windows Terminal (Admin)`.
        2. Input `cd "{X:\path\to\your\extracted\folder}"` and press `enter`, and remember to replace `{X:\path\to\your\extracted\folder}` including the `{}`, for example `cd "D:\wsa"`
        3. Input `PowerShell.exe -ExecutionPolicy Bypass -File .\Install.ps1` and press `Enter`.
        4. The script will run and WSA will be installed.
        5. If this workaround does not work, your PC is not supported for WSA.
12. Magisk/Play Store will be launched. Enjoy by installing LSPosed-Zygisk with Zygisk enabled or Riru and LSPosed-Riru.

---

## FAQ

<details open>

- Can I delete the installed folder?

  No.

- How can I update WSA to a newer version?

  1. Update build scripts:

      ```bash
      git pull
      ```

      For more usage of git, referred to <https://git-scm.com/book>

  2. Rerun the script, replace the content of your previous installation and rerun `Install.ps1`. Don't worry, your data will be preserved.

- How can I get the logcat from WSA?

  `%LOCALAPPDATA%\Packages\MicrosoftCorporationII.WindowsSubsystemForAndroid_8wekyb3d8bbwe\LocalState\diagnostics\logcat`

- How can I update Magisk to a newer version?

  Do the same as updating WSA.

- How to pass Play Integrity (formerly known as SafetyNet)?

  Like all the other emulators, no way.

- Virtualization is not enabled?

  `Install.ps1` helps you enable it if not enabled. After rebooting, rerun `Install.ps1` to install WSA. If it's still not working, you have to enable virtualization in BIOS. That's a long story so ask Google for help.

- How to remount the system as read-write?

  No way in WSA since it's mounted as read-only by Hyper-V. You can modify the system by making a Magisk module. Or directly modify the system.img. Ask Google for help.

- I cannot `adb connect localhost:58526`, what to do?

  Make sure developer mode is enabled. If the issue persists, check the IP address of WSA on the setting page and try `adb connect ip:5555`.

- Why the Magisk online module is empty?

  Magisk actively removes the online module repository. You can install the module locally or by `adb push module.zip /data/local/tmp` and `adb shell su -c magisk --install-module /data/local/tmp/module.zip`.

- Can I use Magisk v23.0 stable or a lower version?

  No. Magisk has bugs preventing itself from running on WSA. Magisk v24+ has fixed them. So you must use Magisk v24 or later.

- How can I get rid of Magisk?

  Choose `none` as the root solution.

- How to install custom GApps?

  [Tutorial](Custom-GApps.md)

- Where can I download MindTheGapps?

  You can download from here [MindTheGapps](https://androidfilehost.com/?w=files&flid=322935) ([mirror](http://downloads.codefi.re/jdcteam/javelinanddart/gapps)).

  Note that there is no x86_64 pre-build, so you need to build it by yourself ([Repository](https://gitlab.com/MindTheGapps/vendor_gapps)).

  Or you can download the built package for 12.1 and 13 for x86_64 from [this page](https://sourceforge.net/projects/wsa-mtg/files/x86_64/).

- Is it possible to migrate data from a lower version like 2305 to a newer version?

  This is certainly available, Microsoft's change of read-only partition from 2305's EROFS to read-only EXT4 only affects the read-only system partition.

  It has no effect on the user data partition. Check the logs if there is a failure to boot.

- How to install KernelSU?

  [Tutorial](KernelSU.md)

</details>

---

## Credits

- [StoreLib](https://github.com/StoreDev/StoreLib): API for downloading WSA
- [Magisk](https://github.com/topjohnwu/Magisk): The most famous root solution on Android
- ~~[The Open GApps Project](https://opengapps.org): One of the most famous Google Apps packages solution~~
- [WSA-Kernel-SU](https://github.com/LSPosed/WSA-Kernel-SU) and [kernel-assisted-superuser](https://git.zx2c4.com/kernel-assisted-superuser/): The kernel `su` for debugging Magisk Integration
- ~~[WSAGAScript](https://github.com/ADeltaX/WSAGAScript): The first GApps integration script for WSA~~
- ~~[erofs-utils](https://github.com/sekaiacg/erofs-utils): Pre-build `erofs-utils` with erofsfuse enabled~~

_The repository is provided as a utility._

_Android is a trademark of Google LLC. Windows is a trademark of Microsoft Corporation._
