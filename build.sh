#!/bin/bash

starttime=$(date +'%Y-%m-%d %H:%M:%S')

export KERNEL=Image.gz
export ARCH=arm64
export SUBARCH=arm64
export KBUILD_BUILD_USER="Android-TSK"
export KBUILD_BUILD_HOST="DE106"
export PATH="$HOME/Tools/clang-r437112b/bin:$PATH"

args="-j$(nproc) \
ARCH=arm64 \
SUBARCH=arm64 \
O=out \
CROSS_COMPILE=aarch64-linux-android- \
CROSS_COMPILE_ARM32=arm-linux-androideabi- \
CLANG_TRIPLE=aarch64-linux-gnu- "

#基本配置信息
echo "-------------------编译器信息--------------------"
echo "           "
clang -v
echo "           "
aarch64-linux-android-ld -v


echo "           "
echo "开始编译   时间 `date +'%Y-%m-%d %H:%M:%S'`"
echo "           "
make CC="ccache clang" ${args} 2>&1 | tee build.log
echo "           "

if [ -f ./out/arch/$ARCH/boot/$KERNEL ]
	then
		echo "           "
		echo "编译成功"
		echo "           "
	else
	    echo "           "
		echo "编译失败"
		echo "           "
	fi

#耗时统计
echo "--------------------------------"
endtime=`date +'%Y-%m-%d %H:%M:%S'`
start_seconds=$(date --date=" $starttime" +%s);
end_seconds=$(date --date="$endtime" +%s);
echo 开始时间: $starttime.
echo 结束时间: $endtime.
echo "编译耗时: "$((end_seconds-start_seconds))"s."
echo "--------------------------------"