#!/bin/bash
#
set -e
rm -rf ./out
cp configs/.config-hswbdw-duet .config
make EXTRAVERSION=-MattDevo-`date +"%Y.%m.%d"`
cp ./out/bios.bin.elf ../coreboot/seabios-hswbdw-duet.bin.elf
