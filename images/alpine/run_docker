#!/bin/bash

dd if=/dev/zero of=rootfs.ext4 bs=1M count=50

mkfs.ext4 $(pwd)/rootfs.ext4

mkdir -pv $(pwd)/my-rootfs

sudo mount $(pwd)/rootfs.ext4 $(pwd)/my-rootfs

sudo cp $(pwd)/build.sh $(pwd)/my-rootfs

docker run -it --rm -v $(pwd)/my-rootfs:/my-rootfs alpine sh /my-rootfs/build.sh

sudo umount $(pwd)/my-rootfs

sudo rm -rf $(pwd)/my-rootfs

