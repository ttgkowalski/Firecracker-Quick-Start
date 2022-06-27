#!/bin/bash

#Create tap named tap0
sudo ip tuntap add tap0 mode tap user $(id -u) group $(id -g)

#Add an address to tap0
sudo ip addr add 10.0.0.1/24 dev tap0

#start the new tap interface
sudo ip link set tap0 up

# Enable forwarding
sudo sysctl -w net.ipv4.ip_forward=1
sudo sh -c "echo 1 > /proc/sys/net/ipv4/ip_forward"

#Change enp1s0f0 to your internet interface
sudo iptables -t nat -A POSTROUTING -o wlo1 -j MASQUERADE
sudo iptables -A FORWARD -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
sudo iptables -A FORWARD -i tap0 -o wlo1 -j ACCEPT

