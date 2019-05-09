#! /bin/bash

root=`pwd`

function build {
	cd $root
	dir=build_$1
	echo "build platform=$1 API_LEVEL=$2 in  $root/$dir"
	rm -rf $dir && mkdir $dir 
	cd $dir
	cmake -DANDROID_ABI=$1 \
      -DCMAKE_TOOLCHAIN_FILE=${ANDROID_NDK_ROOT}/build/cmake/android.toolchain.cmake \
      -DANDROID_NATIVE_API_LEVEL=$2 \
      -GNinja ..
    ninja

    echo "build $1 done,  $root"

    cd $root
    out_dir=android-libs/$1
    mkdir -p $out_dir
    cp -f $dir/crypto/libcrypto.a $out_dir
}

build armeabi 14
build armeabi-v7a 14
build arm64-v8a 21

build x86 14
build x86_64 21


