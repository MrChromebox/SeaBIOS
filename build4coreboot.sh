#!/bin/bash
#
cp .config-coreboot .config
make
cp ./out/bios.bin.elf ../coreboot/seabios.bin.elf

