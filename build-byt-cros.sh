#!/bin/bash
#
set -e
rm -rf ./out
cp configs/.config-byt-cros .config
make EXTRAVERSION=-MrChromebox-`date +"%Y.%m.%d"`
filename="seabios-byt-mrchromebox_`date +"%Y%m%d"`.bin"
cbfstool ${filename} create -m x86 -s 0x00200000
cbfstool ${filename} add-payload -f ./out/bios.bin.elf -n payload -b 0x0 -c lzma
cbfstool ${filename} add -f ~/coreboot/blobs/soc/intel/byt/book/vgabios.bin -n pci8086,0f31.rom -t optionrom
cbfstool ${filename} add -f ~/coreboot/cbfs/bootorder.emmc -n bootorder -t raw
cbfstool ${filename} add-int -i 3000 -n etc/boot-menu-wait
cbfstool ${filename} add-int -i 0xd071f000 -n etc/sdcard0
cbfstool ${filename} add-int -i 0xd071d000 -n etc/sdcard1
cbfstool ${filename} add-int -i 0xd071c000 -n etc/sdcard2
cbfstool ${filename} add-int -i 0xd081f000 -n etc/sdcard3
cbfstool ${filename} add-int -i 0xd081c000 -n etc/sdcard4
cbfstool ${filename} add-int -i 0xd091f000 -n etc/sdcard5
cbfstool ${filename} add-int -i 0xd091c000 -n etc/sdcard6
cbfstool ${filename} print
md5sum ${filename} > ${filename}.md5
mv ${filename}* ~/firmware/
