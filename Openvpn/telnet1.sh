#!/bin/sh

#Definir las ips fisicas del server
ServerIP=192.168.1.101

#Telnet 1
echo "Conectando al servidor en $ServerIP"
openvpn --remote $ServerIP --port 26300 --dev tap7 --ifconfig 10.134.1.131 255.255.255.0 10.134.1.130    



