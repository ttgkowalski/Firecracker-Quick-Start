#!/bin/bash

# Creates a disk image file
dd if=/dev/zero of=rootfs.ext4 bs=1M count=360

# Formats the disk image file to ext4
mkfs.ext4 $(pwd)/rootfs.ext4

# Create a temporary rootfs folder to hold the ext4 disk image file
mkdir -pv $(pwd)/rootfs

# Mount the ext4 disk image on the temporary rootfs folder
sudo mount $(pwd)/rootfs.ext4 $(pwd)/rootfs

# Create the /root folder on the mounted disk image
sudo mkdir -pv $(pwd)/rootfs/root

# Copy the automated image builder script into the disk image
sudo cp $(pwd)/image_setup.sh $(pwd)/rootfs/root/image_setup.sh

# Gives to the automated image builder script a execution permission
chmod +x startup_scripts/*

# Creates a local.d/ folder on the disk image, this folder contains 
# small programs or light scripts to be run when the local service is started or stopped.
# The local service is part of OpenRC. 
sudo mkdir -pv rootfs/etc/local.d/

# Copy the automated network setup scripts into the local.d/
sudo cp startup_scripts/network-interface-startup.sh rootfs/etc/local.d/network-interface-startup.start
sudo cp startup_scripts/python-httpserver-startup.sh rootfs/etc/local.d/python-httpserver-startup.sh.start

# Run the docker to start the building process
# Note that the image used in this command will define the image generated to be ran by Firecracker
docker run -it --rm --network bridge -v $(pwd)/rootfs:/rootfs python:3.9-alpine3.14 sh /rootfs/root/image_setup.sh

# Remove the setup script from final version
sudo rm rootfs/root/image_setup.sh

# Umount the ext4 disk image from the temporary folder rootfs/
sudo umount $(pwd)/rootfs

# Clean up the files used in thr build
sudo rm -rf $(pwd)/rootfs

# Checks if the disk file is healthy
e2fsck -f rootfs.ext4

# Shrink the disk file to the minimum, example:
# We used 360MB of virtual disk file to build the system, but the final version only takes 80MB
# This command turns the 360MB ext4 disk file into a 80MB ext4 disk file
resize2fs -M rootfs.ext4

# Finally, shows the final size of the image.
du -sh rootfs.ext4

