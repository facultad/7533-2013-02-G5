#!/bin/sh

#Definir las ips fisicas del server
#ServerIP=192.168.1.101

#Ftp
echo "Conectando al servidor en $ServerIP"
sudo ifconfig tap9 promisc
openvpn --remote $ServerIP --port 26500 --dev tap9 --ifconfig 10.11.22.1 255.255.255.0 10.11.22.2
