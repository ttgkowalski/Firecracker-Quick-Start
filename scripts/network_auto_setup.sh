#!/bin/sh

# This shellscript must be inside VM

IP_ADDR=10.0.0.2/24
ip addr add $IP_ADDR dev eth0

ip link set eth0 up
ip route add default via 10.0.0.1 dev eth0