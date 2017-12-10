#!/bin/sh

set -ex

SRC_DIR=$PWD

cleanup() {
  ORIG_USER=`who | awk '{print \$1}'`
  chown -R $ORIG_USER:$ORIG_USER $SRC_DIR/work/*
}

# Genrate 'El Torito' boot image as per UEFI sepcification 2.7,
# sections 13.3.1.x and 13.3.2.x.
generate_uefi_boot_image() (
  kernel_size=`du -b $SRC_DIR/work/mll/kernel-64.xz | awk '{print \$1}'`
  rootfs_size=`du -b $SRC_DIR/work/mll/rootfs-64.xz | awk '{print \$1}'`
  loader_size=`du -b $SRC_DIR/work/uefi_root/EFI/BOOT/BOOTx64.EFI | awk '{print \$1}'`

  image_size=$((kernel_size + rootfs_size + loader_size + 65536))
    
  rm -f $SRC_DIR/work/uefi_64.img
  truncate -s $image_size $SRC_DIR/work/uefi_64.img

  LOOP_DEVICE_HDD=$(losetup -f)
  losetup $LOOP_DEVICE_HDD $SRC_DIR/work/uefi_64.img

  mkfs.vfat $LOOP_DEVICE_HDD

  rm -rf $SRC_DIR/work/uefi_64_image
  mkdir -p $SRC_DIR/work/uefi_64_image
  mount $SRC_DIR/work/uefi_64.img $SRC_DIR/work/uefi_64_image

  # The default image file names are described in UEFI
  # specification 2.7, section 3.5.1.1. Note that the
  # x86_64 UEFI image file name indeed contains small
  # letter 'x'.
  mkdir -p $SRC_DIR/work/uefi_64_image/EFI/BOOT
  cp $SRC_DIR/work/uefi_root/EFI/BOOT/BOOTx64.EFI \
      $SRC_DIR/work/uefi_64_image/EFI/BOOT

  mkdir -p $SRC_DIR/work/uefi_64_image/loader/entries
  cp $SRC_DIR/samples/uefi_root/loader/loader.conf \
      $SRC_DIR/work/uefi_64_image/loader
  cp $SRC_DIR/samples/uefi_root/loader/entries/mll-x86_64.conf \
      $SRC_DIR/work/uefi_64_image/loader/entries

  mkdir -p $SRC_DIR/work/uefi_64_image/minimal/x86_64
  cp $SRC_DIR/work/mll/kernel-64.xz \
      $SRC_DIR/work/uefi_64_image/minimal/x86_64/kernel.xz
  cp $SRC_DIR/work/mll/rootfs-64.xz \
      $SRC_DIR/work/uefi_64_image/minimal/x86_64/rootfs.xz

  sync
  umount $SRC_DIR/work/uefi_64_image
  sync
  sleep 1

  rm -rf $SRC_DIR/work/uefi_64_image

  chmod ugo+r $SRC_DIR/work/uefi_64.img
)

check_root() {
  if [ ! "$(id -u)" = "0" ] ; then
    cat << CEOF
  
  ISO image preparation process for UEFI systems requires root permissions
  but you don't have such permissions. Restart this script with root
  permissions in order to generate UEFI compatible ISO image.
  
CEOF

    exit 1
  fi
}

prepare_iso_structure() {
  rm -rf $SRC_DIR/work/isoimage_64_root
  mkdir -p $SRC_DIR/work/isoimage_64_root
  
  cp $SRC_DIR/work/uefi_64.img \
    $SRC_DIR/work/isoimage_64_root
}

generate_iso_image() {
  xorriso -as mkisofs \
    -isohybrid-mbr $SRC_DIR/work/syslinux/bios/mbr/isohdpfx.bin \
    -c boot.cat \
    -e uefi_64.img \
      -no-emul-boot \
      -isohybrid-gpt-basdat \
    -o $SRC_DIR/work/mll_64.iso \
    $SRC_DIR/work/isoimage_64_root
}

check_root
generate_uefi_boot_image
prepare_iso_structure
generate_iso_image
cleanup
