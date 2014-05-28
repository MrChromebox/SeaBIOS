#!/bin/bash
#
cp .config-chromeos .config
make
filename="seabios-panther-`date +"%Y%m%d"`-md.bin"
cp seabios-empty.bin ${filename}
../coreboot/util/cbfstool/cbfstool ${filename} add-payload -f ./out/bios.bin.elf -n payload -b 0x0
../coreboot/util/cbfstool/cbfstool ${filename} add -f ../coreboot/pci8086,0a06.rom -n pci8086,0a06.rom -t optionrom
../coreboot/util/cbfstool/cbfstool ${filename} add -f ../coreboot/cbfs/boot-menu-key -n etc/boot-menu-key -t raw
../coreboot/util/cbfstool/cbfstool ${filename} add -f ../coreboot/cbfs/boot-menu-message -n etc/boot-menu-message -t raw
../coreboot/util/cbfstool/cbfstool ${filename} add -f ../coreboot/cbfs/boot-menu-wait -n etc/boot-menu-wait -t raw
../coreboot/util/cbfstool/cbfstool ${filename} add -f ../coreboot/cbfs/bootorder -n bootorder -t raw
../coreboot/util/cbfstool/cbfstool ${filename} print
md5sum ${filename} > ${filename}.md5
