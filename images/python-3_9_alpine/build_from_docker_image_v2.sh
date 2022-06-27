#!/bin/bash

dd if=/dev/zero of=rootfs.ext4 bs=1M count=360
mkfs.ext4 $(pwd)/rootfs.ext4

mkdir -pv rootfs
sudo mount $(pwd)/rootfs.ext4 $(pwd)/rootfs

docker export $(docker create python:3.9-alpine3.14) --output="rootfs.tar.gz"

sudo tar -xf rootfs.tar.gz -C rootfs

sudo cp image_setup.sh rootfs/root/image_setup.sh
sudo cp up_network.sh rootfs/root/up_network.sh


sudo umount rootfs

rm rootfs.tar.gz
rm -rf rootfs
resize2fs -M rootfs.ext4
