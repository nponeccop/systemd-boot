#!/bin/sh

set -ex

SRC_DIR=$PWD

ovmf_x86() {
  mkdir -p work/ovmf
  cd work/ovmf
  wget --max-redirect 999 -O ovmf-32.zip -c https://sourceforge.net/projects/edk2/files/OVMF/OVMF-IA32-r15214.zip
  unzip -p ovmf-32.zip OVMF.fd > ovmf-32.fd
  cd $SRC_DIR
}

ovmf_x86_64() {
  mkdir -p work/ovmf
  cd work/ovmf
  wget --max-redirect 999 -O ovmf-64.zip -c https://sourceforge.net/projects/edk2/files/OVMF/OVMF-X64-r15214.zip
  unzip -p ovmf-64.zip OVMF.fd > ovmf-64.fd
  cd $SRC_DIR
}

syslinux() {
  mkdir -p work/syslinux
  cd work/syslinux
  wget -O syslinux.tar.xz -c http://kernel.org/pub/linux/utils/boot/syslinux/syslinux-6.03.tar.xz
  tar -xvf syslinux.tar.xz
  cp -r syslinux-*/* .
  cd $SRC_DIR
}

mll_32() {
  mkdir -p work/mll
  cd work/mll
  wget -O mll-32.iso -c http://minimal.idzona.com/download/2017/minimal_linux_live_20-Jan-2017_32-bit.iso
  rm -rf mll-32
  xorriso -osirrox on -indev mll-32.iso -extract / mll-32
  chmod -R ugo+rw mll-32 mll-32/*
  cp mll-32/kernel.xz kernel-32.xz
  cp mll-32/rootfs.xz rootfs-32.xz
  cd $SRC_DIR
}

mll_64() {
  mkdir -p work/mll
  cd work/mll
  wget -O mll-64.iso -c http://minimal.idzona.com/download/2017/minimal_linux_live_20-Jan-2017_64-bit.iso
  rm -rf mll-64
  xorriso -osirrox on -indev mll-64.iso -extract / mll-64
  chmod -R ugo+rw mll-64 mll-64/*
  cp mll-64/kernel.xz kernel-64.xz
  cp mll-64/rootfs.xz rootfs-64.xz
  cd $SRC_DIR
}

systemd_boot_precompiled() {
  rm -rf work/uefi_root
  wget -O work/systemd-boot.tar.xz -c \
    https://github.com/ivandavidov/systemd-boot/releases/download/systemd-boot_26-May-2018/systemd-boot_26-May-2018.tar.xz
  cd work
  tar -xvf systemd-boot.tar.xz
  cd `ls -d systemd-boot_*`
  cp -r * ..
  cd ..
  rm -rf systemd-boot*
  cd $SRC_DIR
}

ovmf_x86
ovmf_x86_64
syslinux
mll_32
mll_64
systemd_boot_precompiled

cd $SRC_DIR
