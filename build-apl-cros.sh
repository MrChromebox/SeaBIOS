#!/bin/bash
#
set -e
rm -rf ./out
cp configs/.config-apl-cros .config
make EXTRAVERSION=-MrChromebox-`date +"%Y.%m.%d"`
filename="seabios-apl-mrchromebox_`date +"%Y%m%d"`.bin"
cbfstool ${filename} create -m x86 -s 0x00200000
cbfstool ${filename} add-payload -f ./out/bios.bin.elf -n payload -b 0x0 -c lzma
cbfstool ${filename} add -f ./out/vgabios.bin -n vgaroms/seavgabios.bin -t optionrom
cbfstool ${filename} add -f ~/dev/coreboot/cbfs/bootorder.emmc.apl -n bootorder -t raw
cbfstool ${filename} add-int -i 3000 -n etc/boot-menu-wait
cbfstool ${filename} print
md5sum ${filename} > ${filename}.md5
mv ${filename}* ~/dev/firmware/
