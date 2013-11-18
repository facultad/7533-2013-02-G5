#!/bin/sh

interface="$1"
pings="2"

#Hosts
echo "\n*** WebServer ***"
ping -I $interface -c $pings 192.168.53.1
echo "\n*** DNS1 ***"
ping -I $interface -c $pings 10.134.13.66
echo "\n*** DNS2 ***"
ping -I $interface -c $pings 10.134.5.133
echo "\n*** DNS_ROOT ***"
ping -I $interface -c $pings 10.9.12.196
echo "\n*** HOST A ***"
ping -I $interface -c $pings 10.11.23.7
echo "\n*** HOST B ***"
ping -I $interface -c $pings 10.134.1.5
echo "\n*** HOST C ***"
ping -I $interface -c $pings 10.9.12.197
echo "\n*** TELNET 1 ***"
ping -I $interface -c $pings 10.134.1.130 
echo "\n*** TELNET 2 ***"
ping -I $interface -c $pings 10.134.5.129
echo "\n*** FTP ***"
ping -I $interface -c $pings 10.11.22.1

#A
echo "\n*** R4 e0/1 ***"
ping -I $interface -c $pings 192.168.53.2
echo "\n*** R5 e0/1 ***"
ping -I $interface -c $pings 192.168.53.3
echo "\n*** R6 e0/0 ***"
ping -I $interface -c $pings 192.168.53.5

#B
echo "\n*** R14 e0/1 ***"
ping -I $interface -c $pings 10.11.22.2
echo "\n*** R15 e0/1 ***"
ping -I $interface -c $pings 10.11.22.3
echo "\n*** R16 e0/0 ***"
ping -I $interface -c $pings 10.11.22.4

#C
echo "\n*** R1 e0/0 ***"
ping -I $interface -c $pings 10.11.23.1
echo "\n*** R2 e0/0 ***"
ping -I $interface -c $pings 10.11.23.2
echo "\n*** R3 e0/0 ***"
ping -I $interface -c $pings 10.11.23.3
echo "\n*** R4 e0/0 ***"
ping -I $interface -c $pings 10.11.23.4
echo "\n*** R5 e0/0 ***"
ping -I $interface -c $pings 10.11.23.5

#D
echo "\n*** R7 e0/2 ***"
ping -I $interface -c $pings 10.134.1.1
echo "\n*** R8 e0/0 ***"
ping -I $interface -c $pings 10.134.1.2
echo "\n*** R9 e0/0 ***"
ping -I $interface -c $pings 10.134.1.3

#E
echo "\n*** R9 e0/1 ***"
ping -I $interface -c $pings 10.134.5.130
echo "\n*** R10 e0/0 ***"
ping -I $interface -c $pings 10.134.5.131
echo "\n*** R11 e0/0 ***"
ping -I $interface -c $pings 10.134.5.132

#F
echo "\n*** R13 e0/1 ***"
ping -I $interface -c $pings 10.9.12.193
echo "\n*** R14 e0/0 ***"
ping -I $interface -c $pings 10.9.12.194
echo "\n*** R15 e0/0 ***"
ping -I $interface -c $pings 10.9.12.195

#G
echo "\n*** R2 e0/1 ***"
ping -I $interface -c $pings 10.134.13.65

#H
echo "\n*** R10 e0/1 ***"
ping -I $interface -c $pings 10.134.13.97

#J
echo "\n*** R8 e0/1 ***"
ping -I $interface -c $pings 10.134.13.129
echo "\n*** R9 e0/3 ***"
ping -I $interface -c $pings 10.134.13.130

#L
echo "\n*** R12 e0/0 ***"
ping -I $interface -c $pings 10.134.13.161
echo "\n*** R16 e0/1 ***"
ping -I $interface -c $pings 10.134.13.162

#M
echo "\n*** R14 e0/2 ***"
ping -I $interface -c $pings 10.134.13.49

#O
echo "\n*** R3 e0/1 ***"
ping -I $interface -c $pings 10.134.13.45
echo "\n*** R7 e0/1 ***"
ping -I $interface -c $pings 10.134.13.46

#P
echo "\n*** R9 e0/2 ***"
ping -I $interface -c $pings 10.134.13.41
echo "\n*** R13 e0/2 ***"
ping -I $interface -c $pings 10.134.13.42

#P
echo "\n*** Internet e0/2 ***"
ping -I $interface -c $pings 137.43.1.1
echo "\n*** R6 e0/1 ***"
ping -I $interface -c $pings 137.43.1.2
echo "\n*** Internet e0/0 ***"
ping -I $interface -c $pings 137.43.1.5
echo "\n*** R11 e0/1 ***"
ping -I $interface -c $pings 137.43.1.6
echo "\n*** Internet e0/1 ***"
ping -I $interface -c $pings 137.43.1.9
echo "\n*** R12 e0/1 ***"
ping -I $interface -c $pings 137.43.1.10

#Terminamos!
echo "PRUEBA DE $interface FINALIZADA"

