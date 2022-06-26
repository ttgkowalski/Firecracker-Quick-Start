#!/bin/sh


echo http://dl-2.alpinelinux.org/alpine/edge/community/ >> /etc/apk/repositories
apk update
apk upgrade

apk add openrc
apk add util-linux
apk add rsync
apk --no-cache add shadow

# passwd root
# This password was made by running -> echo Test_1234 | openssl passwd -1 -stdin
# Where Test_1234 is the actual password for root
echo "Build image with password: \$1\$Zxrqb8Em\$sOAMrShbOq8LZUyewjcqQ0"
usermod --password \$1\$Zxrqb8Em\$sOAMrShbOq8LZUyewjcqQ0 root

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
