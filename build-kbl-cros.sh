#!/bin/bash
#
set -e
rm -rf ./out
cp configs/.config-kbl-cros .config
make EXTRAVERSION=-MrChromebox-`date +"%Y.%m.%d"`
filename="seabios-kbl-mrchromebox_`date +"%Y%m%d"`.bin"
cbfstool ${filename} create -m x86 -s 0x00200000
cbfstool ${filename} add-payload -f ./out/bios.bin.elf -n payload -b 0x0 -c lzma
cbfstool ${filename} add -f ./out/vgabios.bin -n vgaroms/seavgabios.bin -t optionrom
echo "/pci@i0cf8/*@1e,4/drive@0/disk@0\n" > /tmp/bootorder
cbfstool ${filename} add -f /tmp/bootorder -n bootorder -t raw
cbfstool ${filename} add-int -i 3000 -n etc/boot-menu-wait
cbfstool ${filename} print
md5sum ${filename} > ${filename}.md5
mv ${filename}* ~/dev/firmware/
