#!/bin/sh

qemu-system-x86_64 -pflash work/ovmf/ovmf-64.fd -m 128M -cdrom work/mll_64.iso -boot d -vga std > /dev/null 2>&1 &
