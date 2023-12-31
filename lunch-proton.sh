#!/bin/bash
# Copyright cc 2023 sirnewbies
# Edited By Denwah/Radinka
# Before u compile make sure u have the proton clang on your directory and make path on that!!

# setup timer compiler
SECONDS=0 # builtin bash timer

# setup color
red='\033[0;31m'
green='\e[0;32m'
white='\033[0m'
yellow='\033[0;33m'

# setup dir
WORK_DIR=$(pwd)
KERN_IMG="${WORK_DIR}/out/arch/arm64/boot/Image-gz.dtb"
KERN_IMG2="${WORK_DIR}/out/arch/arm64/boot/Image.gz"

# prepare clang
git clone --depth=1 https://github.com/clyfly/proton-clang.git "${WORK_DIR}/tool-chain"

function clean() {
    sudo apt update && sudo apt upgrade -y
    sudo apt-get install git-core gnupg flex bison build-essential zip curl zlib1g-dev libc6-dev-i386 libncurses5 x11proto-core-dev libx11-dev lib32z1-dev libgl1-mesa-dev libxml2-utils xsltproc unzip fontconfig -y
    echo -e "\n"
    echo -e "$red << cleaning up >> \n$white"
    echo -e "\n"
    rm -rf out
}

function build_kernel() {
    export PATH="${WORK_DIR}/tool-chain/bin:$PATH"
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

function zupload() {
    git clone --depth=1 https://github.com/clyfly/AnyKernel3.git -b master AnyKernel
    cp out/arch/arm64/boot/Image.gz AnyKernel
    cd Anykernel
    zip -r9 mykernel.zip *
    curl -T mykernel.zip oshi.at && curl -T mykernel.zip temp.sh
}

function fun() {
    toilet -f future "Rad Kernel Compiled"
}
# execute
clean
build_kernel
