#!/bin/bash

../killVPNs.sh
openvpn ../clientes/dns1.conf &
sleep 5
../setupRoutes.sh 10.134.13.65 10.134.13.64 255.255.255.224
sleep 5
../setupRoutes.sh 10.134.13.65 10.134.13.64 255.255.255.224
