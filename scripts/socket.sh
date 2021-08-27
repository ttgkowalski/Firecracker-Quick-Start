#!/bin/bash

rm sockets/$1.socket

bin/firecracker --api-sock sockets/$1.socket
