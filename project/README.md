## systemd-boot

``systemd-boot`` is a simple UEFI boot manager. Its main job is to launch the selected boot menu entry. 'systemd-boot' leverages APIs provided by the UEFI and offloads all the heavy lifting to the firmware (e.g. loading files from disk, executing EFI images). This allows for very minimal implementation, but feature complete to support common usecases (desktop, laptop).

'systemd-boot' fully supports the [Freedesktop Boot Loader Specification](https://www.freedesktop.org/wiki/Specifications/BootLoaderSpec).

## Installation

If you want to build 'systemd-boot' from scratch, then you'll need to add all [Minimal Linux Live] (http://github.com/ivandavidov/minimal "Minimal Linux Live") dependencies and the 'systemd-boot' build dependencies (Ubuntu):

``sudo apt install wget make gawk gcc bc xorriso gnu-efi dh-autoreconf``

If you have already built Minimal Linux Live, then you need to add just 2 more build dependencies (Ubuntu):

``sudo apt install gnu-efi dh-autoreconf``

These are the steps you need to follow in order to build and install 'systemd-boot':

```
# Assuming you are in the main GitHub project folder

# Remove the old artifacts.
rm -rf systemd-boot_installed

# Navigate to the main project directory.
cd project

# Configure, build and install 'systemd-boot' in local folder.
./autogen.sh
./configure --prefix=$PWD/../systemd-boot_installed/usr
make
make install
```

The above set of commands will preapre and install all 'systemd-boot' artifacts in the following local folder:

``systemd-boot_installed/usr``.

You can find the generated EFI boot loader image here:

``systemd-boot_installed/usr/lib/systemd-boot/systemd-boot{ARCH}.efi``

For your convenience, the above described build process has been automated in the [build_project.sh](https://github.com/ivandavidov/systemd-boot/blob/master/build_project.sh) shell script. 

On 32-bit x86 machines you may need to manually tweak the 'configure.ac' script and/or some of the 'gnu-efi' header locations, because the 'gnu-efi' headers are installed for 'ia32' architectures but the actual architecture is most likely 'i686' or similar. The same applies for the 'gnu-efi' linker which contains the architecture in its file name (e.g. 'ia32') and it may not be resolved if the actual architecture is 'i686' or similar.

I had no such build issues on 'x86_64' machine.

Note that installation of 'sytemd-boot' to the EFI System Partition (if you want to use 'systemd-boot' as main boot loader on your machine) must be handled separately. It is usually done by ``bootctl`` command line utility from the 'systemd' package.

## How to use

Good documentation regarding 'systemd-boot' can be found here:

* [freedesktop.org - systemd-boot UEFI Boot Manager](http://www.freedesktop.org/wiki/Software/systemd/systemd-boot)
* [wiki.archlinux.org - systemd-boot](http://wiki.archlinux.org/index.php/Systemd-boot)

## Dependencies

* gnu-efi - mandatory build dependency
* dh-autoreconf - mandatory build dependency
* qemu - optional
* OVMF - optional
* Syslinux - optional

## Authors

* Kay Sievers
* Harald Hoyer
* ... and many others (for complete list see git history [here](https://www.github.com/systemd/systemd)).
