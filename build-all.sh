#!/bin/bash
#

build_targets=("bsw-cros" "byt-cros" "byt-coreboot" "hswbdw-coreboot" \
    "hswbdw-book-cros" "hswbdw-box-cros" "skl-cros");
for device in ${build_targets[@]}
do
    ./build-${device}.sh
    if [ $? -ne 0 ]; then
        echo "Error building for ${device}; aborting"
        exit 1
    fi
done