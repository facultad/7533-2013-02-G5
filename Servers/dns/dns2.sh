#!/bin/bash

#../killVPNs.sh
openvpn ../clientes/dns2.conf &
sleep 5
../setupRoutes.sh 10.134.5.131 10.134.5.128 255.255.255.128
sleep 5
../setupRoutes.sh 10.134.5.131 10.134.5.128 255.255.255.128
