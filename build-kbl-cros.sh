#!/bin/bash
#
set -e
rm -rf ./out
cp configs/.config-kbl-cros .config
make olddefconfig
make EXTRAVERSION=-MrChromebox-`date +"%Y.%m.%d"`
filename="seabios-kbl-mrchromebox_`date +"%Y%m%d"`.bin"
filename2="seabios-kbl_18-mrchromebox_`date +"%Y%m%d"`.bin"
cbfstool ${filename} create -m x86 -s 0x200000
cbfstool ${filename2} create -m x86 -s 0x1C0000
for fname in ${filename} ${filename2}
do
cbfstool ${fname} add-payload -f ./out/bios.bin.elf -n payload -b 0x0 -c lzma
cbfstool ${fname} add -f ./out/vgabios.bin -n vgaroms/seavgabios.bin -t optionrom
echo "/pci@i0cf8/*@1e,4/drive@0/disk@0\n" > /tmp/bootorder
cbfstool ${fname} add -f /tmp/bootorder -n bootorder -t raw
cbfstool ${fname} add-int -i 3000 -n etc/boot-menu-wait
cbfstool ${fname} print
md5sum ${fname} > ${fname}.md5
mv ${fname}* ~/dev/firmware/
done