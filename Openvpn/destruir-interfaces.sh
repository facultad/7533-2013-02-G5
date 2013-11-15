#!/bin/sh

interfaces="tap0 tap1 tap2 tap3 tap4 tap5 tap6 tap7 tap8 tap9"

for interfaz in $interfaces; do
    openvpn --rmtun --dev $interfaz
done