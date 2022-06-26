#!/bin/bash

dd if=/dev/zero of=rootfs.ext4 bs=1M count=400

mkfs.ext4 $(pwd)/rootfs.ext4

mkdir -pv $(pwd)/my-rootfs

sudo mount $(pwd)/rootfs.ext4 $(pwd)/my-rootfs

sudo cp $(pwd)/image_setup.sh $(pwd)/my-rootfs

docker run -it --rm -v $(pwd)/my-rootfs:/my-rootfs python:3.9-alpine3.14 sh /my-rootfs/image_setup.sh

sudo umount $(pwd)/my-rootfs

sudo rm -rf $(pwd)/my-rootfs

