#!/bin/sh

interface="$1"
pings="2"

#A
echo "*** R4 e0/1 ***"
ping -I $interface -c $pings 192.168.53.2
echo "*** R5 e0/1 ***"
ping -I $interface -c $pings 192.168.53.3
echo "*** R6 e0/0 ***"
ping -I $interface -c $pings 192.168.53.5

#B
echo "*** R14 e0/1 ***"
ping -I $interface -c $pings 10.11.22.2
echo "*** R15 e0/1 ***"
ping -I $interface -c $pings 10.11.22.3
echo "*** R16 e0/0 ***"
ping -I $interface -c $pings 10.11.22.4

#C
echo "*** R1 e0/0 ***"
ping -I $interface -c $pings 10.11.23.1
echo "*** R2 e0/0 ***"
ping -I $interface -c $pings 10.11.23.2
echo "*** R3 e0/0 ***"
ping -I $interface -c $pings 10.11.23.3
echo "*** R4 e0/0 ***"
ping -I $interface -c $pings 10.11.23.4
echo "*** R5 e0/0 ***"
ping -I $interface -c $pings 10.11.23.5

#D
echo "*** R7 e0/2 ***"
ping -I $interface -c $pings 10.134.1.1
echo "*** R8 e0/0 ***"
ping -I $interface -c $pings 10.134.1.2
echo "*** R9 e0/0 ***"
ping -I $interface -c $pings 10.134.1.3

#E
echo "*** R9 e0/1 ***"
ping -I $interface -c $pings 10.134.5.130
echo "*** R10 e0/0 ***"
ping -I $interface -c $pings 10.134.5.131
echo "*** R11 e0/0 ***"
ping -I $interface -c $pings 10.134.5.132

#F
echo "*** R13 e0/1 ***"
ping -I $interface -c $pings 10.9.12.193
echo "*** R14 e0/0 ***"
ping -I $interface -c $pings 10.9.12.194
echo "*** R15 e0/0 ***"
ping -I $interface -c $pings 10.9.12.195

#G
echo "*** R2 e0/1 ***"
ping -I $interface -c $pings 10.134.13.65

#H
echo "*** R10 e0/1 ***"
ping -I $interface -c $pings 10.134.13.97

#J
echo "*** R8 e0/1 ***"
ping -I $interface -c $pings 10.134.13.129
echo "*** R9 e0/3 ***"
ping -I $interface -c $pings 10.134.13.130

#L
echo "*** R12 e0/0 ***"
ping -I $interface -c $pings 10.134.13.161
echo "*** R16 e0/1 ***"
ping -I $interface -c $pings 10.134.13.162

#M
echo "*** R14 e0/2 ***"
ping -I $interface -c $pings 10.134.13.49

#O
echo "*** R3 e0/1 ***"
ping -I $interface -c $pings 10.134.13.45
echo "*** R7 e0/1 ***"
ping -I $interface -c $pings 10.134.13.46

#P
echo "*** R9 e0/2 ***"
ping -I $interface -c $pings 10.134.13.41
echo "*** R13 e0/2 ***"
ping -I $interface -c $pings 10.134.13.42

#P
echo "*** Internet e0/2 ***"
ping -I $interface -c $pings 137.43.1.1
echo "*** R6 e0/1 ***"
ping -I $interface -c $pings 137.43.1.2
echo "*** Internet e0/0 ***"
ping -I $interface -c $pings 137.43.1.5
echo "*** R11 e0/1 ***"
ping -I $interface -c $pings 137.43.1.6
echo "*** Internet e0/1 ***"
ping -I $interface -c $pings 137.43.1.9
echo "*** R12 e0/1 ***"
ping -I $interface -c $pings 137.43.1.10

#Terminamos!
echo "PRUEBA DE $interface FINALIZADA"

