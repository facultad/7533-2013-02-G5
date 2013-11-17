#!/bin/sh

#Definir las ips fisicas del server
#ServerIP=192.168.1.101

#Host C
echo "Conectando al servidor en $ServerIP"
sudo ifconfig tap6 promisc
openvpn --remote $ServerIP --port 26200 --dev tap6 --ifconfig 10.9.12.197 255.255.255.192 10.9.12.198  
echo "nameserver 10.134.5.133" > /etc/resolv.conf


