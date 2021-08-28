#!/bin/sh

passwd root

apk update
apk upgrade

apk add openrc
apk add util-linux
apk add rsync

# Set up a login terminal on the serial console (ttyS0):
ln -s agetty /etc/init.d/agetty.ttyS0
echo ttyS0 > /etc/securetty
rc-update add agetty.ttyS0 default

# Make sure special file systems are mounted on boot:
rc-update add devfs boot
rc-update add procfs boot
rc-update add sysfs boot


# Copy the container rootfs to /my-rootfs
rsync -av --progress /* /my-rootfs --exclude /my-rootfs

exit
