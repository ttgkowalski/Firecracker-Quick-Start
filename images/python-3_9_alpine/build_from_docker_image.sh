#!/bin/bash

dd if=/dev/zero of=rootfs.ext4 bs=1M count=360

mkfs.ext4 $(pwd)/rootfs.ext4

mkdir -pv $(pwd)/rootfs

sudo mount $(pwd)/rootfs.ext4 $(pwd)/rootfs

sudo mkdir -pv $(pwd)/rootfs/root

sudo cp $(pwd)/image_setup.sh $(pwd)/rootfs/root/image_setup.sh

chmod +x startup_scripts/*

sudo mkdir -pv rootfs/etc/local.d/
sudo cp startup_scripts/network-interface-startup.sh rootfs/etc/local.d/network-interface-startup.start
sudo cp startup_scripts/python-httpserver-startup.sh rootfs/etc/local.d/python-httpserver-startup.sh.start

docker run -it --rm --network bridge -v $(pwd)/rootfs:/rootfs python:3.9-alpine3.14 sh /rootfs/root/image_setup.sh
sudo rm rootfs/root/image_setup.sh

sudo umount $(pwd)/rootfs

sudo rm -rf $(pwd)/rootfs

e2fsck -f rootfs.ext4
resize2fs -M rootfs.ext4
du -sh rootfs.ext4

