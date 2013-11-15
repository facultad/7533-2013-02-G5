#!/bin/sh

#Definir las ips fisicas de cada host
WebServerIP=192.168.1.103
DNS1IP=192.168.1.103
DNS2IP=192.168.1.103
DNSROOTIP=192.168.1.103
HOSTAIP=192.168.1.103
HOSTBIP=192.168.1.103
HOSTCIP=192.168.1.103
TELNET1IP=192.168.1.103
TELNET2IP=192.168.1.103
FTPIP=192.168.1.103

#Mato las conexiones anteriores
echo "Terminando conexiones vpn anteriores"
interfaces="tap0 tap1 tap2 tap3 tap4 tap5 tap6 tap7 tap8 tap9"
for interfaz in $interfaces; do
    sudo openvpn --rmtun --dev $interfaz
    sudo ifconfig $interfaz down
done
sudo pkill openvpn

#Activo las interfaces
#for interfaz in $interfaces; do
#    sudo ifconfig $interfaz up
#done

#WebServer
echo "Conectando al Webserver en $WebServerIP"
exec sudo openvpn --port 25600 --remote $WebServerIP --dev tap0 --ifconfig 192.168.53.1 255.255.255.0 192.168.53.2 &

#DNS1
echo "Conectando al DNS1 en $DNS1IP"
exec sudo openvpn--port 26600 --remote $DNS1IP --dev tap1 --ifconfig 10.134.13.66 255.255.255.224 10.134.13.67 &

#DNS2
echo "Conectando al DNS2 en $DNS2IP"
exec sudo openvpn --port 25800 --remote $DNS2IP --dev tap2 --ifconfig 10.134.5.133 255.255.255.128 10.134.5.134 &

#DNS ROOT
echo "Conectando al DNS ROOT en $DNSROOTIP"
exec sudo openvpn --port 25900 --remote $DNSROOTIP --dev tap3 --ifconfig 10.9.12.196 255.255.255.192 10.9.12.197 &

#Host A
echo "Conectando al HOST A en $HOSTAIP"
exec sudo openvpn --port 26000 --remote $HOSTAIP --dev tap4 --ifconfig 10.11.23.7 255.255.255.0 10.11.23.8 &

#Host B
echo "Conectando al HOST B en $HOSTBIP"
exec sudo openvpn --port 26100 --remote $HOSTBIP --dev tap5 --ifconfig 10.134.1.5 255.255.255.0 10.134.1.6 &

#Host C
echo "Conectando al HOST C en $HOSTCIP"
exec sudo openvpn --port 26200 --remote $HOSTCIP --dev tap6 --ifconfig 10.9.12.197 255.255.255.192 10.9.12.198 &

#Telnet 1
echo "Conectando al TELNET 1 en $TELNET1IP"
exec sudo openvpn --port 26300 --remote $TELNET1IP --dev tap7 --ifconfig 10.134.1.130 255.255.255.0 10.134.1.131 &

#Telnet 2
echo "Conectando al TELNET 2 en $TELNET2IP"
exec sudo openvpn --port 26400 --remote $TELNET2IP --dev tap8 --ifconfig 10.134.5.129 255.255.255.128 10.134.5.130 &

#FTP
echo "Conectando al FTP en $FTPIP"
exec sudo openvpn  --port 26500 --remote $FTPIP --dev tap9 --ifconfig 10.11.22.1 255.255.255.0 10.11.22.2 &

