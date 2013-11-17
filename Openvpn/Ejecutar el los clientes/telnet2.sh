#!/bin/sh

#Definir las ips fisicas del server
ServerIP=192.168.1.101

#Telnet 2
echo "Conectando al servidor en $ServerIP"
sudo ifconfig tap8 promisc
openvpn --remote $ServerIP --port 26400 --dev tap8 --ifconfig 10.134.5.129 255.255.255.128 10.134.5.130
