#!/bin/bash

export PATH="$HOME/Tools/clang-r437112b/bin:$PATH"
export KD="sdm845-perf_smartisan_defconfig"
export ARCH=arm64
export SUBARCH=arm64

#保存签名密钥
if [ -d "out/certs" ]; then
    mkdir -p ./key
    cp -af out/certs/* ./key/ 2>/dev/null
fi

make clean && make mrproper
rm -f build.log && rm -rf out
mkdir -p out

#恢复签名密钥
if [ -d "./key" ]; then
    mkdir -p out/certs
    cp -af ./key/* out/certs/ 2>/dev/null
fi

make CC="ccache clang" -j$(nproc) \
ARCH=arm64 \
SUBARCH=arm64 \
O=out \
CROSS_COMPILE=aarch64-linux-android- \
CROSS_COMPILE_ARM32=arm-linux-androideabi- \
CLANG_TRIPLE=aarch64-linux-gnu- ${KD}