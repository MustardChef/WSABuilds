# WSABuilds &nbsp; &nbsp; <img src="https://img.shields.io/github/downloads/MustardChef/WSABuilds/total?label=Total%20Downloads&style=for-the-badge"/> &nbsp; 

## Guide: Install KernelSU and Manager Using Prebuilt Builds

**1.** Download WSA with KernelSU from [![Action Tab](https://img.shields.io/badge/Builds%20Status-Passing-brightgreen?style=flat&logo=Github)](https://github.com/MustardChef/WSABuilds/releases) then [Follow this guide](https://github.com/YT-Advanced/WSA-Script#--installation) to install it.

**2.** Download KernelSU Manager from [![Build Manager](https://github.com/tiann/KernelSU/actions/workflows/build-manager.yml/badge.svg?event=push)](https://github.com/tiann/KernelSU/actions/workflows/build-manager.yml?query=event%3Apush+is%3Acompleted+branch%3Amain) (Download the artifact named `manager`).

**3.** Unzip the downloaded zip package and get the manager apk named `KernelSU_vx.x.x-xx-.....apk`.

**4.** Use the command `adb install <apkname>.apk` or WSAPacman to install the manager.
</br>
</br>

## Guide: Install KernelSU and Manager Using Custom Build Guide

**1.** [Follow the guide], in order to fork the Custom Build "Github Actions" Repo

**2.** Remember to Select KernalSU when selecting options for the Workflow Run

<img src="https://user-images.githubusercontent.com/68516357/224405961-17bebc41-eb85-458e-8feb-86dec443548e.png" width=19% height=19%/>


**3.** Download KernelSU Manager from [![Build Manager](https://github.com/tiann/KernelSU/actions/workflows/build-manager.yml/badge.svg?event=push)](https://github.com/tiann/KernelSU/actions/workflows/build-manager.yml?query=event%3Apush+is%3Acompleted+branch%3Amain) (Download the artifact named `manager`).

**4.** Unzip the downloaded zip package and get the manager apk named `KernelSU_vx.x.x-xx-.....apk`.

**5.** Use the command `adb install <apkname>.apk` or WSAPacman to install the manager.
</br>
</br>

## Guide: How to install KernelSU and Manager Manually

### Install Manager

**1.** Download KernelSU Manager from [![Build Manager](https://github.com/tiann/KernelSU/actions/workflows/build-manager.yml/badge.svg?event=push)](https://github.com/tiann/KernelSU/actions/workflows/build-manager.yml?query=event%3Apush+is%3Acompleted+branch%3Amain) (Download the artifact named `manager`).

**2.** Unzip the downloaded zip package and get the manager apk named `KernelSU_vx.x.x-xx-.....apk`.

**3.** Use the command `adb install <apkname>.apk` to install the manager.

### Install Kernel

**1.** Download pre-build kernel from [![Build WSA-5.10.117-Kernel](https://github.com/tiann/KernelSU/actions/workflows/build-WSA-5.10.117-kernel.yml/badge.svg?event=push)](https://github.com/tiann/KernelSU/actions/workflows/build-WSA-5.10.117-kernel.yml?query=branch%3Amain+event%3Apush+is%3Acompleted) (Remember to download the same architecture).

**2.** Unzip the downloaded zip package and get the kernel file named `bzImage`.

**3.** Replace the kernel in the folder named `Tools` in the WSA directory with `bzImage`.

**4.** Restart WSA and then enjoy.
