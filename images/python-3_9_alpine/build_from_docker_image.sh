#!/bin/bash

dd if=/dev/zero of=rootfs.ext4 bs=1M count=360

mkfs.ext4 $(pwd)/rootfs.ext4

mkdir -pv $(pwd)/rootfs

sudo mount $(pwd)/rootfs.ext4 $(pwd)/rootfs

sudo mkdir -pv $(pwd)/rootfs/root

sudo cp $(pwd)/image_setup.sh $(pwd)/rootfs/root/image_setup.sh
sudo cp $(pwd)/up_network.sh $(pwd)/rootfs/root/up_network.sh

docker run -it --rm --network bridge -v $(pwd)/rootfs:/rootfs python:3.9-alpine3.14 sh /rootfs/root/image_setup.sh

sudo umount $(pwd)/rootfs

sudo rm -rf $(pwd)/rootfs

