#!/bin/bash

sudo bin/jailer --id testvm \
    --chroot-base-dir jailer/ \
    --exec-file bin/firecracker --uid 2000 --gid 2000
