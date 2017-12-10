#!/bin/sh

qemu-system-i386 -pflash work/ovmf/ovmf-32.fd -m 128M -cdrom work/mll_32.iso -boot d -vga std > /dev/null 2>&1 &
