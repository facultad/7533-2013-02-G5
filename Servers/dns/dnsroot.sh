#!/bin/bash

../killVPNs.sh
openvpn ../clientes/dnsroot.conf &
sleep 5
../setupRoutes.sh 10.9.12.193 10.9.12.192 255.255.255.192
sleep 5
../setupRoutes.sh 10.9.12.193 10.9.12.192 255.255.255.192
