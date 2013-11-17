#!/bin/sh

#Definir las ips fisicas del server
#ServerIP=192.168.1.101

#Telnet 1
echo "Conectando al servidor en $ServerIP"
sudo ifconfig tap7 promisc
openvpn --remote $ServerIP --port 26300 --dev tap7 --ifconfig 10.134.1.130 255.255.255.0 10.134.1.131    



