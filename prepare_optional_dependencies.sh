#!/bin/sh

set -ex

SRC_DIR=$PWD

ovmf_x86() {
  mkdir -p work/ovmf
  cd work/ovmf
  wget -O ovmf-32.zip -c https://sourceforge.net/projects/edk2/files/OVMF/OVMF-IA32-r15214.zip
  unzip -p ovmf-32.zip OVMF.fd > ovmf-32.fd
  cd $SRC_DIR
}

ovmf_x86_64() {
  mkdir -p work/ovmf
  cd work/ovmf
  wget -O ovmf-64.zip -c https://sourceforge.net/projects/edk2/files/OVMF/OVMF-X64-r15214.zip
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
  wget -O mll-32.iso -c http://minimal.idzona.com/download/minimal_linux_live_20-Jan-2017_32-bit.iso
  xorriso -osirrox on -indev mll-32.iso -extract / mll-32
  chmod -R ugo+rw mll-32 mll-32/*
  cp mll-32/kernel.xz kernel-32.xz
  cp mll-32/rootfs.xz rootfs-32.xz  
  cd $SRC_DIR
}

mll_64() {
  mkdir -p work/mll
  cd work/mll
  wget -O mll-64.iso -c http://minimal.idzona.com/download/minimal_linux_live_20-Jan-2017_64-bit.iso
  xorriso -osirrox on -indev mll-64.iso -extract / mll-64
  chmod -R ugo+rw mll-64 mll-64/*
  cp mll-64/kernel.xz kernel-64.xz
  cp mll-64/rootfs.xz rootfs-64.xz  
  cd $SRC_DIR
}

systemd_boot_precompiled() {
  echo "TODO..."
  cd $SRC_DIR
}

#ovmf_x86
#ovmf_x86_64
#syslinux
#mll_32
mll_64

cd $SRC_DIR
