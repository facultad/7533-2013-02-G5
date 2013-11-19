#!/bin/sh

#Se definen las rutas estaticas por defecto para cada tab
sudo route add -net 0.0.0.0 gw 192.168.53.4 tap0 #WebServer
sudo route add -net 0.0.0.0 gw 10.134.13.65 tap1 #DNS1
sudo route add -net 0.0.0.0 gw 10.134.5.130 tap2 #DNS2
sudo route add -net 0.0.0.0 gw 10.9.12.195 tap3 #DNS_ROOT
sudo route add -net 0.0.0.0 gw 10.11.23.6 tap4 #Host A
sudo route add -net 0.0.0.0 gw 10.134.1.4 tap5 #Host B
sudo route add -net 0.0.0.0 gw 10.9.12.193 tap6 #Host C
sudo route add -net 0.0.0.0 gw 10.134.1.4 tap7 #Telnet 1
sudo route add -net 0.0.0.0 gw 10.134.5.130 tap8 #Telnet 2
sudo route add -net 0.0.0.0 gw 10.11.22.3 tap9 #Ftp



