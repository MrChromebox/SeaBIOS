#!/bin/bash
#
set -e
rm -rf ./out
cp configs/.config-bsw-cros .config
make EXTRAVERSION=-MrChromebox-`date +"%Y.%m.%d"`
filename="seabios-bsw-mrchromebox_`date +"%Y%m%d"`.bin"
cbfstool ${filename} create -m x86 -s 0x00200000
cbfstool ${filename} add-payload -f ./out/bios.bin.elf -n payload -b 0x0 -c lzma
cbfstool ${filename} add -f ./out/vgabios.bin -n pci8086,22b1.rom -t optionrom
cbfstool ${filename} add -f ~/coreboot/cbfs/bootorder.emmc -n bootorder -t raw
cbfstool ${filename} add-int -i 3000 -n etc/boot-menu-wait
cbfstool ${filename} add-int -i 0xd131d000 -n etc/sdcard0
cbfstool ${filename} add-int -i 0xd131f000 -n etc/sdcard1
cbfstool ${filename} print
md5sum ${filename} > ${filename}.md5
mv ${filename}* ~/firmware/
