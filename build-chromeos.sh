#!/bin/bash
#
rm -rf ./out
cp .config-chromeos .config
make
if [ $? -eq 0 ]; then
filename="seabios-haswell-`date +"%Y%m%d"`-md.bin"
cp seabios-empty.bin ${filename}
cbfstool ${filename} add-payload -f ./out/bios.bin.elf -n payload -b 0x0
cbfstool ${filename} add -f ~/coreboot/3rdparty/mainboard/google/panther/vgabios_orig.bin -n pci8086,0406.rom -t optionrom
cbfstool ${filename} add -f ~/coreboot/cbfs/boot-menu-wait -n etc/boot-menu-wait -t raw
cbfstool ${filename} add -f ~/coreboot/cbfs/boot-menu-key -n etc/boot-menu-key -t raw
cbfstool ${filename} add -f ~/coreboot/cbfs/boot-menu-message -n etc/boot-menu-message -t raw
cbfstool ${filename} add -f ~/coreboot/cbfs/links -n links -t raw
cbfstool ${filename} print
md5sum ${filename} > ${filename}.md5
fi
