#!/bin/bash

#Create tap named tapvm1
sudo ip tuntap add tapvm1 mode tap

#Add an address to tapvm1
sudo ip addr add 10.0.0.1/24 dev tapvm1

#start the new tap interface
sudo ip link set tapvm1 up

#Change enp1s0f0 to your internet interface
sudo iptables -t nat -A POSTROUTING -o wlo1 -j MASQUERADE
sudo iptables -A FORWARD -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
sudo iptables -A FORWARD -i tapvm1 -o wlo1 -j ACCEPT

