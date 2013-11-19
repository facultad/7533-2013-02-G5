#!/bin/bash
SRV="srv"
ETC="etc"
APACHE="apache2"
VAR="var"



function install_ftp{
	echo "Instalando FTP"
	apt-get install vsftpd

	cp servers/ftp/vsftpd.conf /$ETC/	# uso la configuracion vsftpd.conf
	cp -r /$SRV/ftp/ ~/aux/
	rm -r /$SRV/ftp/*
	cp -r servers/ftp/$SRV/ftp /$SRV/
}

function install_telnet{
	echo "Instalando Telnet"
	apt-get install telnetd
	apt-get install xinetd
	cp -r /$ETC/xinetd.d/ ~/aux/
	cp servers/telnet/telnet /$ETC/xinetd.d/
}

function install_apache{	
	echo "Instalando Apache"	
	apt-get install apache2

	mkdir /$ETC/$APACHE
	cp -r /$ETC/$APACHE/ ~/aux/
	cp -r /$VAR/www/ ~/aux/
	rm /$VAR/www/*
	cp -r servers/web/$APACHE/ /$ETC/
	cp -r servers/web/www/ /$VAR/

}

if [ "$(id -u)" != "0" ]; then
   echo "Debe ejecutar como administrador"
   exit 1
fi
	mkdir ~/aux
	

install_ftp
install_telnet
install_apache
