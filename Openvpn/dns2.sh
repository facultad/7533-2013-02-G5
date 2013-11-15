#!/bin/sh

#Definir las ips fisicas del server
ServerIP=192.168.1.101

#DNS 2
echo "Conectando al servidor en $ServerIP"
openvpn --remote $ServerIP --port 25800 --dev tap2 --ifconfig 10.134.5.134 255.255.255.128 10.134.5.133 



