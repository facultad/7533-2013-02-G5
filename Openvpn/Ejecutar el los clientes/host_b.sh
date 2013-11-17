#!/bin/sh

#Definir las ips fisicas del server
#ServerIP=192.168.1.101

#Host B
echo "Conectando al servidor en $ServerIP"
sudo ifconfig tap5 promisc
openvpn --remote $ServerIP --port 26100 --dev tap5 --ifconfig 10.134.1.5 255.255.255.0 10.134.1.6 
echo "nameserver 10.134.5.133" > /etc/resolv.conf


