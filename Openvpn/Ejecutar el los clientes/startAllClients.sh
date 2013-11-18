#!/bin/sh

#Asigno la misma ip a cada cliente (misma maquina fisica) 
export ServerIP=192.168.1.101

#Mato las conexiones anteriores
pkill openvpn

#Hago ejecutable cada script
chmod 775 dns1.sh
chmod 775 dns2.sh
chmod 775 dns_root.sh
chmod 775 ftp.sh
chmod 775 host_a.sh
chmod 775 host_b.sh
chmod 775 host_c.sh
chmod 775 telnet1.sh
chmod 775 telnet2.sh
chmod 775 webserver.sh

#Enciendo los clientes
./dns1.sh &
./dns2.sh &
./dns_root.sh &
./ftp.sh &
./host_a.sh &
./host_b.sh &
./host_c.sh &
./telnet1.sh &
./telnet2.sh &
./webserver.sh &

wait 3000

#Configuro los ruteos por default estaticos
./configRuteoEstatico.sh &

