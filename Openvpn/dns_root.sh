#!/bin/sh

#Definir las ips fisicas del server
ServerIP=192.168.1.101

#DNS ROOT
echo "Conectando al servidor en $ServerIP"
openvpn --remote $ServerIP --port 25900 --dev tap3 --ifconfig 10.9.12.197 255.255.255.192 10.9.12.196



