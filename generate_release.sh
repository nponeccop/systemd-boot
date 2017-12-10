#!/bin/sh

set -e

SRC_DIR=$PWD

mkdir -p $SRC_DIR/work/release
cd $SRC_DIR/work/release

DATE_PARSED=`LANG=en_US ; date +"%d-%b-%Y"`
RELEASE_NAME=systemd-boot_$DATE_PARSED
RELEASE_DIR=$SRC_DIR/work/release/$RELEASE_NAME

rm -rf $RELEASE_DIR*
mkdir -p $RELEASE_DIR

cp -r $SRC_DIR/work/uefi_root \
  $RELEASE_DIR

rm -rf $RELEASE_DIR/uefi_root/loader

cp -r $SRC_DIR/samples/uefi_root/loader \
  $RELEASE_DIR/uefi_root

cd $SRC_DIR/work/release

tar -cvf $RELEASE_NAME.tar $RELEASE_NAME

xz -z -k -9 -e systemd-boot_10-Dec-2017.tar
