#!/bin/bash
#
set -e
rm -rf ./out
cp configs/.config-hswbdw-coreboot .config
make EXTRAVERSION=-MrChromebox-`date +"%Y.%m.%d"`
cp ./out/bios.bin.elf ../coreboot/seabios-hswbdw.bin.elf
