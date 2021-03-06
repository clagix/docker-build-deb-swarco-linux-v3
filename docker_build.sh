#!/bin/bash

set -e -x
id

git clone https://github.com/swarco/swarco-linux-v3

cd swarco-linux-v3
git clone https://github.com/swarco/swarco-linux-v3-dl output

make swarco_linux_v3_ccm2200_defconfig

# disable toolchain locale support
# sed -i -e "s/BR2_ENABLE_LOCALE=y/# BR2_ENABLE_LOCALE is not set/g" .config
# grep ^BR2_ENABLE_LOCALE .config
# make oldconfig
# grep ^BR2_ENABLE_LOCALE .config
# locale -a

# substitute  grep -q -i utf8 in  grep -q -i utf-\\\?8
sed -i -e 's/utf8/utf-\\\\\\?8/g' support/dependencies/dependencies.sh
cat support/dependencies/dependencies.sh

make



(
    cd output/images
    tar cJf ../../../swarco-linux-v3_images.tar.bz2 .
)

#(
    #    tar cJf ../swarco-linux-v2_staging_dir.tar.bz2 buildroot/buildroot-2.0/build_arm/staging_dir
#)
pwd
cd ..

#test cross compiler

PATH=$PATH:$PWD/swarco-linux-v3/output/host/usr/bin/
export PATH

echo -e '#include <stdio.h>\nint main() { printf("Hello\\n"); }' >hello.c
arm-buildroot-linux-gnueabi-gcc -o hello hello.c        

mv swarco-linux-v3/output/host .
ls -l

# remove swarco-linux-v2 build directory after build to prevent too
# large Docker image
rm -rf swarco-linux-v3
#mkdir swarco-linux-v2
mkdir -p swarco-linux-v3/output
mv host swarco-linux-v3/output/

arm-buildroot-linux-gnueabi-gcc -o hello hello.c        
ls -l

echo Oki Doki
exit 0
