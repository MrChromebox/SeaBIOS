#!/bin/bash
#
rm -rf ./out
cp .config-chromeos .config
make
if [ $? -eq 0 ]; then
filename="seabios-haswell-box-`date +"%Y%m%d"`-md.bin"
filename2="seabios-haswell-book-`date +"%Y%m%d"`-md.bin"
cp seabios-empty.bin ${filename}
cbfstool ${filename} add-payload -f ./out/bios.bin.elf -n payload -b 0x0
cbfstool ${filename} add -f ~/coreboot/3rdparty/mainboard/google/panther/hsw_1035_cbox.dat -n pci8086,0406.rom -t optionrom
cbfstool ${filename} add -f ~/coreboot/cbfs/boot-menu-wait -n etc/boot-menu-wait -t raw
cbfstool ${filename} add -f ~/coreboot/cbfs/boot-menu-key -n etc/boot-menu-key -t raw
cbfstool ${filename} add -f ~/coreboot/cbfs/boot-menu-message -n etc/boot-menu-message -t raw
cbfstool ${filename} add -f ~/coreboot/cbfs/links -n links -t raw
cbfstool ${filename} print
md5sum ${filename} > ${filename}.md5
cp seabios-empty.bin ${filename2}
cbfstool ${filename2} add-payload -f ./out/bios.bin.elf -n payload -b 0x0
cbfstool ${filename2} add -f ~/coreboot/3rdparty/mainboard/google//panther/hsw_1035_cbook.dat -n pci8086,0406.rom -t optionrom
cbfstool ${filename2} add -f ~/coreboot/cbfs/boot-menu-wait -n etc/boot-menu-wait -t raw
cbfstool ${filename2} add -f ~/coreboot/cbfs/boot-menu-key -n etc/boot-menu-key -t raw
cbfstool ${filename2} add -f ~/coreboot/cbfs/boot-menu-message -n etc/boot-menu-message -t raw
cbfstool ${filename2} add -f ~/coreboot/cbfs/links -n links -t raw
cbfstool ${filename2} print
md5sum ${filename2} > ${filename2}.md5
fi
