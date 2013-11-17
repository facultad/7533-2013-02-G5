#!/bin/sh

#Definir las ips fisicas del server
#ServerIP=192.168.1.101

#Host A
echo "Conectando al servidor en $ServerIP"
sudo ifconfig tap4 promisc
openvpn --remote $ServerIP --port 26000 --dev tap4 --ifconfig 10.11.23.7 255.255.255.0 10.11.23.8 



