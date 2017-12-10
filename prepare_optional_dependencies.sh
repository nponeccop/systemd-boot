#!/bin/sh

set -ex

SRC_DIR=$PWD

ovmf_x86() {
  mkdir -p work/ovmf
  cd work/ovmf
  wget -O ovmf-32.zip -c https://sourceforge.net/projects/edk2/files/OVMF/OVMF-IA32-r15214.zip
  unzip -p ovmf-32.zip OVMF.fd > ovmf-32.fd
}

ovmf_x86_64() {
  mkdir -p work/ovmf
  cd work/ovmf
  wget -O ovmf-64.zip -c https://sourceforge.net/projects/edk2/files/OVMF/OVMF-X64-r15214.zip
  unzip -p ovmf-64.zip OVMF.fd > ovmf-64.fd
}

syslinux() {
  mkdir -p work/syslinux
  cd work/syslinux
  wget -O syslinux.tar.xz -c http://kernel.org/pub/linux/utils/boot/syslinux/syslinux-6.03.tar.xz
  tar -xvf syslinux.tar.xz
  cp -r syslinux-*/* .
}

systemd_boot_precompiled() {
  echo "TODO..."
}

#ovmf_x86
#ovmf_x86_64
syslinux

cd $SRC_DIR
