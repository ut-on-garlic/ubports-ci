#!/bin/bash
source halium.env
cd $ANDROID_ROOT

# replace something
sed -i 's/external\/selinux/external\/selinux external\/libcurl/g' build/core/main.mk

source build/envsetup.sh
export LC_ALL=C && export USE_NINJA=false && export USE_CCACHE=1 && export ALLOW_MISSING_DEPENDENCIES=true
virtualenv --python 2.7 ~/python27
source ~/python27/bin/activate
breakfast $DEVICE
make -j$(nproc) hybris-hal
make -j$(nproc) halium-boot
make -j$(nproc) systemimage 

echo "md5sum halium-boot.img and system.img"
md5sum $ANDROID_ROOT/out/target/product/${DEVICE}/halium-boot.img
md5sum $ANDROID_ROOT/out/target/product/${DEVICE}/system.img
