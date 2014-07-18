#!/bin/bash

make -j16

rm -rf mod
mkdir mod

cp `find ./ | grep .ko$` modules.order mod/

rm -rf out
mkdir out

cp arch/arm/boot/zImage out/zImage
./scripts/dtbTool -s 2048 -o arch/arm/boot/dt.img arch/arm/boot/
cp arch/arm/boot/dt.img out/dt.img
./scripts/mkbootfs /home/ramdisk | gzip > out/ramdisk.gz
./scripts/mkbootimg --kernel out/zImage --ramdisk out/ramdisk.gz --dt out/dt.img --cmdline "console=null androidboot.hardware=qcom user_debug=31 msm_rtb.filter=0x3F" --base 0x00000000 --ramdisk_offset 0x02000000 --tags_offset 0x01e00000 --pagesize 2048 -o out/civz.img


