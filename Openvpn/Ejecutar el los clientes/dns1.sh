#!/bin/sh

#Definir las ips fisicas del server
ServerIP=192.168.1.101

#DNS 1
echo "Conectando al servidor en $ServerIP"
sudo ifconfig tap1 promisc
openvpn --remote $ServerIP --port 25700 --dev tap1 --ifconfig 10.134.13.66 255.255.255.224 10.134.13.67




