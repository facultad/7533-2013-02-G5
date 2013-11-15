#!/bin/sh

#Definir las ips fisicas del server
ServerIP=192.168.1.101

#Host A
echo "Conectando al servidor en $ServerIP"
openvpn --remote $ServerIP --port 26000 --dev tap4 --ifconfig 10.11.23.8 255.255.255.0 10.11.23.7 



