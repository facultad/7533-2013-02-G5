#!/bin/bash

if [ "$(id -u)" != "0" ]; then
   echo "Debe ejecutar como administrador"
   exit 1
fi

case "$1" in

	#FTP 
	ftp)
	ps -ef | grep "vsftpd" | grep -v "grep" > /dev/null
	if [ "$?" -eq "0" ]
	then
		echo "El FTP está corriendo."
		case "$2" in
		off)
			service vsftpd stop
			echo "Stopping FTP"
		;;
		esac
		exit
	fi

	echo "El FTP no esta corriendo."
	case "$2" in	
		on)
			service vsftpd start	
			echo "Iniciando FTP.."
		;;
		esac
	;;

	
	#Telnet 
	telnet)
	ps -ef | grep "xinetd" | grep -v "grep" > /dev/null
	if [ "$?" -eq "0" ]
	then
		echo "Telnet está corriendo."
		case "$2" in
		off)
			service xinetd stop
			echo "Stopping Telnet"
		;;
		esac
		exit
	fi
	echo "Telnet No esta corriendo."
	case "$2" in	
		on)
			service xinetd start	
			echo "Iniciando Telnet.."
		;;
		esac
	;;
	

	#Apache
	apache)
	ps -ef | grep "apache2" | grep -v "grep" > /dev/null
	if [ "$?" -eq "0" ]
	then
		echo "El servidor Apache2 está corriendo."
		case "$2" in
		off)
			service apache2 stop
			echo "Stopping web server"
		;;
		esac
		exit
	fi

	echo "El Servidor no Apache2 esta corriendo."
	case "$2" in	
		on)
			service apache2 start	
			echo "Iniciando servidor Apache2.."
		;;
		esac
	;;


	*)
	echo "Parametros incorrectos"
	;;

esac
