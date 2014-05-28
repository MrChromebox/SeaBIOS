#!/bin/bash
#
set -e
rm -rf ./out
cp configs/.config-byt-coreboot .config
make EXTRAVERSION=-MrChromebox-`date +"%Y.%m.%d"`
cp ./out/bios.bin.elf ../coreboot/seabios-byt.bin.elf
filename="seabios-byt_bootstub-mrchromebox_`date +"%Y%m%d"`.bin"
cp ./out/bios.bin.elf ${filename}
md5sum ${filename} > ${filename}.md5
mv ${filename}* ~/dev/firmware/
