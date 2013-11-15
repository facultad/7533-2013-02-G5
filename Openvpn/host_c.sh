#!/bin/sh

#Definir las ips fisicas del server
ServerIP=192.168.1.101

#Host C
echo "Conectando al servidor en $ServerIP"
openvpn --remote $ServerIP --port 26200 --dev tap6 --ifconfig 10.9.12.198 255.255.255.192 10.9.12.197  



