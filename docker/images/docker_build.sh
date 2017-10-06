#!/bin/bash

set -e -x
id


cd swarco-linux-v3

make

(
    cd output/images
    tar cJf ../../../swarco-linux-v3_images.tar.bz2 .
)

#(
    #    tar cJf ../swarco-linux-v2_staging_dir.tar.bz2 buildroot/buildroot-2.0/build_arm/staging_dir
#)
pwd
# mv swarco-linux-v3/output/host .
# ls -l

# # remove swarco-linux-v3 build directory after build to prevent too
# # large Docker image
# rm -rf swarco-linux-v3

# mkdir -p swarco-linux-v3/output
# mv host swarco-linux-v3/output/

ls -l
cd ..

