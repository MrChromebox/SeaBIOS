#!/bin/bash
#
rm -rf ./out
cp .config-coreboot .config
make
if [ $? -eq 0 ]; then
cp ./out/bios.bin.elf ../coreboot/seabios.bin.elf
fi
