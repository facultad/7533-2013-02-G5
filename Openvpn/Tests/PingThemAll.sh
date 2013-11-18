#!/bin/sh

interfaces="tap0 tap1 tap2 tap3 tap4 tap5 tap6 tap7 tap8 tap9"
mkdir "PingThemAllResults"
chmod 775 ./prueba1.sh
for interfaz in $interfaces; do
    ./prueba1.sh $interfaz > ./PingThemAllResults/"$interfaz.txt" &
done




