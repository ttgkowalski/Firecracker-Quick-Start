#!/bin/bash

# KERNEL
curl --unix-socket sockets/$1.socket -i \
      -X PUT 'http://localhost/boot-source'   \
      -H 'Accept: application/json'           \
      -H 'Content-Type: application/json'     \
      -d "{
            \"kernel_image_path\": \"$(pwd)/kernels/vmlinuz-5.4.43-fc.x86_64\",
            \"boot_args\": \"console=ttyS0 reboot=k panic=1 pci=off\"
       }"

# ROOTFS
curl --unix-socket sockets/$1.socket -i \
    -X PUT 'http://localhost/drives/rootfs' \
    -H 'Accept: application/json'           \
    -H 'Content-Type: application/json'     \
    -d "{
        \"drive_id\": \"rootfs\",
        \"path_on_host\": \"$(pwd)/images/hello/rootfs.ext4\",
        \"is_root_device\": true,
        \"is_read_only\": false
    }"



# NETWORK
curl --unix-socket sockets/$1.socket -i \
  -X PUT 'http://localhost/network-interfaces/eth0' \
  -H 'Accept: application/json' \
  -H 'Content-Type: application/json' \
  -d '{
      "iface_id": "eth0",
      "guest_mac": "AA:FC:00:00:00:01",
      "host_dev_name": "tapvm1"
    }'

# START
curl --unix-socket sockets/$1.socket -i \
    -X PUT 'http://localhost/actions'       \
    -H  'Accept: application/json'          \
    -H  'Content-Type: application/json'    \
    -d '{
        "action_type": "InstanceStart"
    }'
