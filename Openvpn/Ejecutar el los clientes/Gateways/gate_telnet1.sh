#!/bin/sh

subredes="0.0.0.0/0 192.168.53.0/24 10.11.22.0/23 10.9.12.192/26 10.134.1.0/24 10.134.13.0/24 10.134.5.128/25"
for subred in $subredes; do
    sudo route add -net $subred gw 10.134.1.4 tap7 #Telnet 1
done




