# Firecracker-Quick-Start

A simple working tree with Firecracker v0.24.5 binaries.

---

## First steps
- *Make sure you're running this in a x86_64 architecture*
- `git clone https://github.com/ttgkowalski/Firecracker-Quick-Start.git`
- `cd Firecracker-Quick-Start`

## #1 Running a MicroVM using a socket

You'll need 2 terminals to run a MicroVM using a socket.

At the **first terminal**, run the following command:
```shell
rm -rf sockets/first-microvm.socket && bin/firecracker --api-sock sockets/first-microvm.socket
```

At the **second terminal**:

To set the guess kernel:
```shell
curl --unix-socket ../../sockets/firecracker.socket -i \
      -X PUT 'http://localhost/boot-source'   \
      -H 'Accept: application/json'           \
      -H 'Content-Type: application/json'     \
      -d "{
            \"kernel_image_path\": \"$(pwd)/vmlinux.bin\",
            \"boot_args\": \"console=ttyS0 reboot=k panic=1 pci=off\"
       }"
```
To set the guess rootfs:
```shell
curl --unix-socket sockets/first-microvm.socket -i \
    -X PUT 'http://localhost/drives/rootfs' \
    -H 'Accept: application/json'           \
    -H 'Content-Type: application/json'     \
    -d "{
        \"drive_id\": \"rootfs\",
        \"path_on_host\": \"$(pwd)/images/hello/rootfs.ext4\",
        \"is_root_device\": true,
        \"is_read_only\": false
    }"
```

Then, to start the MicroVM:
```shell
curl --unix-socket sockets/first-microvm.socket -i \ 
    -X PUT 'http://localhost/actions' \ 
    -H  'Accept: application/json' \ 
    -H  'Content-Type: application/json' \ 
    -d '{"action_type": "InstanceStart"}'
```

The default login and password is **root**.
To shutdown your instance, just run **reboot**.
