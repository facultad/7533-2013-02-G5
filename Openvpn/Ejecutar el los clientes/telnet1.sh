#!/#!/bin/sh

name="telnet1"

pkill openvpn

chmod 775 ./Interfaces/conf_$name.sh
./Interfaces/conf_$name.sh &

sleep 5

chmod 775 ./Gateways/gate_$name.sh
./Gateways/gate_$name.sh

