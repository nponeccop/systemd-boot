#!/bin/sh

set -ex

# Remove the old artifacts.
rm -rf systemd-boot_installed

# Navigate to the main project directory.
cd project

if [ -f Makefile ] ; then
  make distclean
fi

# Configure, build and install 'systemd-boot' in local folder.
./autogen.sh
./configure --prefix=$PWD/../systemd-boot_installed/usr
make
make install

cd ..

if [ -f systemd-boot_installed/usr/lib/systemd-boot/systemd-boot*.efi ] ; then
  cat << CEOF

  ###################################################################
  #                                                                 #
  #  UEFI boot loader image has been generated. Check this folder:  #
  #                                                                 #
  #    systemd-boot_installed/usr/lib/systemd-boot                  #
  #                                                                 #
  ###################################################################

CEOF
else
  cat << CEOF

  There is something wrong with the build process. 

CEOF
fi
