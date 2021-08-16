In the first terminal, run:
```shell
sudo bin/jailer --id testvm \
    --chroot-base-dir jailer/ \
    --exec-file bin/firecracker --uid 2000 --gid 2000
```

In the second terminal, run the following commands:
```shell
cp images/hello/* jailer/firecracker/testvm/root
```

```shell
curl --unix-socket jailer/firecracker/testvm/root/run/firecracker.socket -i \
    -X PUT 'http://localhost/boot-source' \
    -H 'Accept: application/json' \
    -H 'Content-Type: application/json' \
    -d "{
            \"kernel_image_path\": \"vmlinux.bin\",
            \"boot_args\": \"console=ttyS0 reboot=k panic=1 pci=off\"
       }"
```

```shell
curl --unix-socket jailer/firecracker/testvm/root/run/firecracker.socket -i \
    -X PUT 'http://localhost/drives/rootfs' \
    -H 'Accept: application/json' \
    -H 'Content-Type: application/json' \
    -d "{
        \"drive_id\": \"rootfs\",
        \"path_on_host\": \"rootfs.ext4\",
        \"is_root_device\": true,
        \"is_read_only\": false
   }"
```

```shell
curl --unix-socket jailer/firecracker/testvm/root/run/firecracker.socket -i \
    -X PUT 'http://localhost/actions' \
    -H  'Accept: application/json' \
    -H  'Content-Type: application/json' \
    -d '{
      "action_type": "InstanceStart"
   }'

```

TO-DO
- [ ] Add daemon mode
