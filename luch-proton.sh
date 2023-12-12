#!/bin/bash
# Copyright cc 2023 sirnewbies
#Edited By Denwah/Radinka
# Before u compile make sure u have the proton clang on your directory and make path on that!!

# setup color
red='\033[0;31m'
green='\e[0;32m'
white='\033[0m'
yellow='\033[0;33m'

# setup dir
WORK_DIR=$(pwd)
KERN_IMG="${WORK_DIR}/out/arch/arm64/boot/Image-gz.dtb"
KERN_IMG2="${WORK_DIR}/out/arch/arm64/boot/Image.gz"

function clean() {
    echo -e "\n"
    echo -e "$red << cleaning up >> \n$white"
    echo -e "\n"
    rm -rf out
}

function build_kernel() {
    export PATH="/workspace/gitpod/proton-clang/bin:$PATH"
    make -j$(nproc --all) O=out ARCH=arm64 rad_defconfig
    make -j$(nproc --all) ARCH=arm64 O=out \
                          CC=clang \
                          CROSS_COMPILE=aarch64-linux-gnu- \
                          CROSS_COMPILE_ARM32=arm-linux-gnueabi-
    if [ -e "$KERN_IMG" ] || [ -e "$KERN_IMG2" ]; then
        echo -e "\n"
        echo -e "$green << Rad Kernel Succesfully compile in $((SECONDS / 60)) minute(s) and $((SECONDS % 60)) second(s)! >> \n$white"
        echo -e "\n"
    else
        echo -e "\n"
        echo -e "$red <<  Rad Kernel failed to compile in $((SECONDS / 60)) minute(s) and $((SECONDS % 60)) second(s)! >> \n$white"
        echo -e "\n"
    fi
}

function zupload()
{
git clone --depth=1 https://github.com/clyfly/AnyKernel3.git -b master AnyKernel
cp out/arch/arm64/boot/Image.gz AnyKernel
cd AnyKernel
zip -r9 Focalor-rad.zip *
curl -T Focalor-rad.zip oshi.at && curl -T Focalor-rad.zip temp.sh
}

function fun()
{
figlet -c "Rad Kernel Compiled"
}
# execute
clean
build_kernel
