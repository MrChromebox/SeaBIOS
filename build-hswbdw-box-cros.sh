#!/bin/bash
#
set -e
rm -rf ./out
cp configs/.config-hswbdw-box-cros .config
make EXTRAVERSION=-MrChromebox-`date +"%Y.%m.%d"`
filename="seabios-hswbdw_box-mrchromebox_`date +"%Y%m%d"`.bin"
cbfstool ${filename} create -m x86 -s 0x00200000
cbfstool ${filename} add-payload -f ./out/bios.bin.elf -n payload -b 0x0
cbfstool ${filename} add -f ~/coreboot/blobs/soc/intel/hsw/box/vgabios.bin -n pci8086,0406.rom -t optionrom
cbfstool ${filename} add -f ~/coreboot/cbfs/bootorder.ssd -n bootorder -t raw
cbfstool ${filename} add -f ~/coreboot/cbfs/links.hswbdw -n links -t raw
cbfstool ${filename} add-int -i 3000 -n etc/boot-menu-wait
cbfstool ${filename} print
md5sum ${filename} > ${filename}.md5
mv ${filename}* ~/firmware/
