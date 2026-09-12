#!/bin/bash

export ARCH=arm64
export SUBARCH=arm64
export KBUILD_BUILD_USER="Android-TSK"
export KBUILD_BUILD_HOST="DE106"
export PATH="$HOME/clang-r437112b/bin:$PATH"

make CC="ccache clang" -j$(nproc) \
ARCH=arm64 \
SUBARCH=arm64 \
O=out \
CROSS_COMPILE=aarch64-linux-android- \
CROSS_COMPILE_ARM32=arm-linux-androideabi- \
CLANG_TRIPLE=aarch64-linux-gnu- menuconfig
