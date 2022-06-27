ip route flush dev eth0

ip addr add 10.0.0.3/24 dev eth0
ip link set dev eth0 up

ip route add 0.0.0.0/0 via 10.0.0.1

echo nameserver 8.8.8.8 > /etc/resolv.conf