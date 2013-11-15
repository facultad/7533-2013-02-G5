#!/bin/sh

#Definir las ips fisicas del server
ServerIP=192.168.1.101

#WebServer
echo "Conectando al servidor en $ServerIP"
openvpn --remote $ServerIP --port 25600 --dev tap0 --ifconfig 192.168.53.2 255.255.255.0 192.168.53.1



