## systemd-boot

``systemd-boot`` (previously known as [gummyboot](https://en.wikipedia.org/wiki/Gummiboot_(software))) is a simple UEFI boot manager. Its main job is to launch the selected boot menu entry. 'systemd-boot' leverages APIs provided by the UEFI and offloads all the heavy lifting to the firmware (e.g. loading files from disk, executing EFI images). This allows for ф very minimal implementation, but for a feature complete one to support common use cases (desktop, laptop).

Precompiled 'systemd-boot' UEFI images and sample configuration files are available in the [release](https://github.com/ivandavidov/systemd-boot/releases) section. The latest stable release is [systemd-boot_26-May-2018](https://github.com/ivandavidov/systemd-boot/releases/tag/systemd-boot_26-May-2018). Each release contains the following artifacts:

* UEFI compliant directory structure with general purpose 'systemd-boot' UEFI boot loader images for 'x86' and 'x86_64' architectures.
* Sample configuration files for 'x86' and 'x86_64' machines which describe the boot entries for [Minimal Linux Live](http://github.com/ivandavidov/minimal "Minimal Linux Live").

The primary use case of this project is to provide precompiled general purpose 'systemd-boot' UEFI boot loader images which in turn support the UEFI boot process of Minimal Linux Live.

The raw source code, along with build documentation can be found in the [project](https://github.com/ivandavidov/systemd-boot/tree/master/project) folder. Most probably you don't need it, unless you really want to build 'systemd-boot' from scratch.

The shell scripts in the main folder rely on the precompiled binaries and on other third party software. You don't need these scripts, nor you need the third party software, unless you want to build custom Minimal Linux Live ISO image which boots on UEFI systems. This serves as proof of concept that the precompiled binaries work fine.

## How to use

Good documentation regarding 'systemd-boot' can be found here:

* [freedesktop.org - systemd-boot UEFI Boot Manager](http://www.freedesktop.org/wiki/Software/systemd/systemd-boot)
* [wiki.archlinux.org - systemd-boot](http://wiki.archlinux.org/index.php/Systemd-boot)

The helper scripts in the main folder do the following:

* Download and prepare third party software dependencies, e.g. the precompiled UEFI boot loader images, OVMF images, Syslinux, sample kernel/initramfs files, etc. 
* Genrate sample 'El Torito' boot image as described in UEFI specification 2.7, sections 13.3.1.x and 13.3.2.x.
* Generate sample ISO image with UEFI boot support.
* Run [QEMU](https://www.qemu.org) with UEFI enabled configuration and attached sample ISO image.

Note that you need QEMU on your system in order to test the sample ISO images. You can install it like this (Ubuntu):

* ``sudo apt install qemu``

Please consider all helper scripts just helper scripts. You can use them to gain some more knowledge about the 'systemd-boot' UEFI boot loader insfrastructure and how to create UEFI compatible ISO images.
