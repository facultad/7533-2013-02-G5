#!/bin/bash
SRV="srv"
ETC="etc"
APACHE="apache2"
VAR="var"
if [ "$(id -u)" != "0" ]; then
   echo "Debe ejecutar como administrador"
   exit 1
fi
	mkdir ~/aux

	echo "Instalando FTP"
	apt-get install vsftpd
echo "done"

	cp servers/ftp/vsftpd.conf /$ETC/	# uso la configuracion vsftpd.conf
	cp -r /$SRV/ftp/ ~/aux/
	rm -r /$SRV/ftp/*

	cp -r servers/ftp/$SRV/ftp /$SRV/
	# comandos get y put para transferir archivos.




	echo "Instalando Telnet"
	apt-get install telnetd
	apt-get install xinetd
	cp -r /$ETC/xinetd.d/ ~/aux/
	cp servers/telnet/telnet /$ETC/xinetd.d/



	echo "Instalando Apache"	
	apt-get install apache2

	mkdir /$ETC/$APACHE
	cp -r /$ETC/$APACHE/ ~/aux/
	cp -r /$VAR/www/ ~/aux/
	rm /$VAR/www/*
	cp -r servers/web/$APACHE/ /$ETC/
	cp -r servers/web/www/ /$VAR/



