# Install KernelSU

## Install Manager

1. Download KernelSU Manager from [![Build Manager](https://github.com/tiann/KernelSU/actions/workflows/build-manager.yml/badge.svg?event=push)](https://github.com/tiann/KernelSU/actions/workflows/build-manager.yml?query=event%3Apush+is%3Acompleted+branch%3Amain) (Download the artifact named `manager`).

1. Unzip the downloaded zip package and get the manager apk named `KernelSU_vx.x.x-xx-.....apk`.

1. Use the command `adb install <apkname>.apk` to install the manager.

## Install Kernel

1. Download pre-build kernel from [![Build Kernel - WSA](https://github.com/tiann/KernelSU/actions/workflows/build-kernel-wsa.yml/badge.svg?event=push)](https://github.com/tiann/KernelSU/actions/workflows/build-kernel-wsa.yml?query=branch%3Amain+event%3Apush+is%3Acompleted) (Remember to download the same architecture).

1. Unzip the downloaded zip package and get the kernel file named `bzImage`.

1. Replace the kernel in the folder named `Tools` in the WSA directory with `bzImage`.

1. Restart WSA and then enjoy.
