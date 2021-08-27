#!/bin/bash

rm ../../sockets/firecracker.socket

../../bin/firecracker --api-sock ../../sockets/firecracker.socket
