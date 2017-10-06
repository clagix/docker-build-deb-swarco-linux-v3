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

make toolchain

#test cross compiler

PATH=$PATH:$PWD/swarco-linux-v3/output/host/usr/bin/
export PATH

echo -e '#include <stdio.h>\nint main() { printf("Hello\\n"); }' >hello.c
pwd
ls -l

arm-buildroot-linux-gnueabi-gcc -o hello hello.c



echo Oki Doki

