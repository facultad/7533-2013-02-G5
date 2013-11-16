#!/bin/sh

#Definir las ips fisicas de cada host
WebServerIP=157.92.48.169
DNS1IP=157.92.48.169
DNS2IP=157.92.48.169
DNSROOTIP=157.92.48.169
HOSTAIP=157.92.48.169
HOSTBIP=157.92.48.169
HOSTCIP=157.92.48.169
TELNET1IP=157.92.48.169
TELNET2IP=157.92.48.169
FTPIP=157.92.48.169

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
exec sudo openvpn --port 25600 --remote $WebServerIP --dev tap0 --ifconfig 192.168.53.2 255.255.255.0 192.168.53.1 &
sudo ifconfig tap0 promisc

#DNS1
echo "Conectando al DNS1 en $DNS1IP"
exec sudo openvpn--port 26600 --remote $DNS1IP --dev tap1 --ifconfig 10.134.13.67 255.255.255.224 10.134.13.66 &
sudo ifconfig tap1 promisc

#DNS2
echo "Conectando al DNS2 en $DNS2IP"
exec sudo openvpn --port 25800 --remote $DNS2IP --dev tap2 --ifconfig 10.134.5.134 255.255.255.128 10.134.5.133 &
sudo ifconfig tap2 promisc

#DNS ROOT
echo "Conectando al DNS ROOT en $DNSROOTIP"
exec sudo openvpn --port 25900 --remote $DNSROOTIP --dev tap3 --ifconfig 10.9.12.197 255.255.255.192 10.9.12.196 &
sudo ifconfig tap3 promisc

#Host A
echo "Conectando al HOST A en $HOSTAIP"
exec sudo openvpn --port 26000 --remote $HOSTAIP --dev tap4 --ifconfig 10.11.23.8 255.255.255.0 10.11.23.7 &
sudo ifconfig tap4 promisc

#Host B
echo "Conectando al HOST B en $HOSTBIP"
exec sudo openvpn --port 26100 --remote $HOSTBIP --dev tap5 --ifconfig 10.134.1.6 255.255.255.0 10.134.1.5 &
sudo ifconfig tap5 promisc

#Host C
echo "Conectando al HOST C en $HOSTCIP"
exec sudo openvpn --port 26200 --remote $HOSTCIP --dev tap6 --ifconfig 10.9.12.198 255.255.255.192 10.9.12.197 &
sudo ifconfig tap6 promisc

#Telnet 1
echo "Conectando al TELNET 1 en $TELNET1IP"
exec sudo openvpn --port 26300 --remote $TELNET1IP --dev tap7 --ifconfig 10.134.1.131 255.255.255.0 10.134.1.130 &
sudo ifconfig tap7 promisc

#Telnet 2
echo "Conectando al TELNET 2 en $TELNET2IP"
exec sudo openvpn --port 26400 --remote $TELNET2IP --dev tap8 --ifconfig 10.134.5.130 255.255.255.128 10.134.5.129 &
sudo ifconfig tap8 promisc

#FTP
echo "Conectando al FTP en $FTPIP"
exec sudo openvpn  --port 26500 --remote $FTPIP --dev tap9 --ifconfig 10.11.22.2 255.255.255.0 10.11.22.1 &
sudo ifconfig tap9 promisc

