#!/bin/bash

## Configuración de Servidor DNS root

## Definición de constantes

NOMBRE_ZONA="ROOT"
DIR_BIND="${_DIR_BIND:-/etc/bind}"
DOMINIO_DNS_ROOT="${_DOMINIO_DNS_ROOT:-neuquen.dc.fi.uba.ar}"

DOMINIO_DNS="${DOMINIO_DNS_ROOT}"
ARCH_CONFIGURACION="zona.root"
ARCH_CONFIGURACION_INV="zona.root.inv"
ARCH_CONF_INVERSO="db.inverso"


ARCH_CONF_ROOT="db.root"
ARCH_CONF_INVERSO_10="db.local.10"
ARCH_CONF_INVERSO_172_13="db.local.172_13"
ARCH_CONF_INVERSO_137_43="db.local.137_43"
ARCH_CONF_INVERSO_192_168="db.local.192_168"

IP_DNS_ROOT="${_IP_DNS_ROOT:-10.9.12.197}"
IP_DNS="${IP_DNS_ROOT}"

IP_DNS_1="${_IP_DNS_1:-10.134.13.66}"
DOMINIO_DNS_1="chosmalal.${DOMINIO_DNS_ROOT}"

IP_DNS_2="${_IP_DNS_2:-10.134.5.133}"
DOMINIO_DNS_2="alumine.${DOMINIO_DNS_ROOT}"
DOMINIO_DNS_2_1="junin.${DOMINIO_DNS_ROOT}"




OPCIONES_CONF="options {
     directory \"/var/cache/bind\";
     dump-file \"/var/cache/bind/cache_dump.db\";
     statistics-file \"/var/cache/bind/named_stats.txt\";
	
     allow-recursion { none; };

     //query-source address * port 53;

     listen-on port 53 { any; };

     allow-query { any;
	};
};"



ZONAS="
zone \"${DOMINIO_DNS}\" IN {
	type master;
	file \"${DIR_BIND}/${ARCH_CONF_ROOT}\";
	allow-update { none; };
};

zone \"168.192.in-addr.arpa\" {
	type master;
	file \"${DIR_BIND}/${ARCH_CONF_INVERSO_192_168}\";
	allow-transfer {none;};
};

zone \"10.in-addr.arpa\" {
	type master;
	file \"${DIR_BIND}/${ARCH_CONF_INVERSO_10}\";
	allow-transfer {none;};
};

zone \"13.172.in-addr.arpa\" {
	type master;
	file \"${DIR_BIND}/${ARCH_CONF_INVERSO_172_13}\";
	allow-transfer {none;};
};

zone \"43.137.in-addr.arpa\" {
	type master;
	file \"${DIR_BIND}/${ARCH_CONF_INVERSO_137_43}\";
	allow-transfer {none;};
};
"



declare -a RESOLUCIONES=(
"	IN	NS	nsroot.fokker.alumine ; " \
"nsroot.fokker.alumine	IN	A	${IP_DNS_ROOT} ; "  \
"chosmalal	IN	NS	ns1.goshawk.chosmalal ; " \
"ns1.goshawk.chosmalal	IN	A	${IP_DNS_1} ; "  \
"alumine	IN	NS	ns2.embraer.junin ; " \
"junin	IN	NS	ns2.embraer.junin ; " \
"ns2.embraer.junin 	IN	A	${IP_DNS_2} ; "  \
)


declare -a RESOLUCIONES_INV_10=(
"23.11	IN	NS	ns1.goshawk.chosmalal.neuquen.dc.fi.uba.ar.; " \
"64-65.13.134	IN	NS	ns1.goshawk.chosmalal.neuquen.dc.fi.uba.ar.; " \
"64.13.134		CNAME	64.64-65.13.134.10.in-addr.arpa." \
"65.13.134		CNAME	65.64-65.13.134.10.in-addr.arpa." \
\
"192-197.12.9	IN	NS	ns2.embraer.junin.neuquen.dc.fi.uba.ar.; " \
"192.12.9		CNAME	192.192-197.12.9.10.in-addr.arpa." \
"193.12.9		CNAME	193.192-197.12.9.10.in-addr.arpa." \
"194.12.9		CNAME	194.192-197.12.9.10.in-addr.arpa." \
"195.12.9		CNAME	195.192-197.12.9.10.in-addr.arpa." \
"196.12.9		CNAME	196.192-197.12.9.10.in-addr.arpa." \
"197.12.9		CNAME	197.192-197.12.9.10.in-addr.arpa." \
"48-49.13.134	IN	NS	ns2.embraer.junin.neuquen.dc.fi.uba.ar.; " \
"48.13.134		CNAME	48.48-49.13.134.10.in-addr.arpa." \
"49.13.134		CNAME	49.48-49.13.134.10.in-addr.arpa." \
"22.11	IN	NS	ns2.embraer.junin.neuquen.dc.fi.uba.ar.; " \
"160-162.13.134	IN	NS	ns2.embraer.junin.neuquen.dc.fi.uba.ar.; " \
"160.13.134		CNAME	160.160-162.13.134.10.in-addr.arpa." \
"161.13.134		CNAME	161.160-162.13.134.10.in-addr.arpa." \
"162.13.134		CNAME	162.160-162.13.134.10.in-addr.arpa." \
"40-42.13.134	IN	NS	ns2.embraer.junin.neuquen.dc.fi.uba.ar.; " \
"40.13.134		CNAME	40.40-42.13.134.10.in-addr.arpa." \
"41.13.134		CNAME	41.40-42.13.134.10.in-addr.arpa." \
"42.13.134		CNAME	42.40-42.13.134.10.in-addr.arpa." \
"128-131.13.134	IN	NS	ns2.embraer.junin.neuquen.dc.fi.uba.ar.; " \
"128.13.134		CNAME	128.128-131.13.134.10.in-addr.arpa." \
"129.13.134		CNAME	129.128-131.13.134.10.in-addr.arpa." \
"130.13.134		CNAME	130.128-131.13.134.10.in-addr.arpa." \
"131.13.134		CNAME	131.128-131.13.134.10.in-addr.arpa." \
"44-46.13.134	IN	NS	ns2.embraer.junin.neuquen.dc.fi.uba.ar.; " \
"44.13.134		CNAME	44.44-46.13.134.10.in-addr.arpa." \
"45.13.134		CNAME	45.44-46.13.134.10.in-addr.arpa." \
"46.13.134		CNAME	46.44-46.13.134.10.in-addr.arpa." \
"1.134	IN	NS	ns2.embraer.junin.neuquen.dc.fi.uba.ar.; " \
"96-97.13.134	IN	NS	ns2.embraer.junin.neuquen.dc.fi.uba.ar.; " \
"96.13.134		CNAME	96.96-97.13.134.10.in-addr.arpa." \
"97.13.134		CNAME	97.96-97.13.134.10.in-addr.arpa." \
"128-133.5.134	IN	NS	ns2.embraer.junin.neuquen.dc.fi.uba.ar.; " \
"128.5.134		CNAME	128.128-133.5.134.10.in-addr.arpa." \
"129.5.134		CNAME	129.128-133.5.134.10.in-addr.arpa." \
"130.5.134		CNAME	130.128-133.5.134.10.in-addr.arpa." \
"131.5.134		CNAME	131.128-133.5.134.10.in-addr.arpa." \
"132.5.134		CNAME	132.128-133.5.134.10.in-addr.arpa." \
"133.5.134		CNAME	133.128-133.5.134.10.in-addr.arpa." \
"36-38.13.134	IN	NS	ns2.embraer.junin.neuquen.dc.fi.uba.ar.; " \
"36.13.134		CNAME	36.36-38.13.134.10.in-addr.arpa." \
"37.13.134		CNAME	37.36-38.13.134.10.in-addr.arpa." \
"38.13.134		CNAME	38.36-38.13.134.10.in-addr.arpa." \
"32-34.13.134	IN	NS	ns2.embraer.junin.neuquen.dc.fi.uba.ar.; " \
"32.13.134		CNAME	32.32-34.13.134.10.in-addr.arpa." \
"33.13.134		CNAME	33.32-34.13.134.10.in-addr.arpa." \
"34.13.134		CNAME	34.32-34.13.134.10.in-addr.arpa." \
"28-30.13.134	IN	NS	ns2.embraer.junin.neuquen.dc.fi.uba.ar.; " \
"28.13.134		CNAME	28.28-30.13.134.10.in-addr.arpa." \
"29.13.134		CNAME	29.28-30.13.134.10.in-addr.arpa." \
"30.13.134		CNAME	30.28-30.13.134.10.in-addr.arpa." \


)

declare -a RESOLUCIONES_INV_192_168=(
"53	IN	NS	ns1.goshawk.chosmalal.neuquen.dc.fi.uba.ar." \
)

declare -a RESOLUCIONES_INV_172_13=(
"1	IN	NS	ns2.embraer.junin.neuquen.dc.fi.uba.ar." \
)

declare -a RESOLUCIONES_INV_137_43=(
"1	IN	NS	ns2.embraer.junin.neuquen.dc.fi.uba.ar." \
)




## Funciones auxiliares
function exit_conf 
{
	if [ "$1" = "0" ];then 
		echo "DNS OK"
	else
		echo "Error: $1 : ${2}."
	fi
	exit $1
}

function validate_root
{
	#chequeo que sea root
	if [ "$USER" != "root" ]; then
		echo "Debe ejecutar como root"
		exit_conf "5" "No es usuario Root"
	fi

	return 0
}

function validate_bind9
{
	if [ -d "/etc/bind" ]; then
		echo "bind9 instalado."
	else
		echo "Instalando bind9"
		apt-get install bind9
	fi	

	return 0
}

function validaciones
{
	validate_root
	validate_bind9
}

function write_named_conf 
{	
	file_replace "${DIR_BIND}/named.conf" "include" "//include"
	
	echo "include \"${DIR_BIND}/named.conf.local\";" >> "${DIR_BIND}/named.conf";
	
	chmod +r "${DIR_BIND}/named.conf"

	return 0
}

function file_replace 
{	
	if [ $# -eq 3 ]; then

		declare local aux="aux.tmp"
		
		sed "s%$2%$3%g" $1 > "$aux"
		
		rm "$1"
		mv "$aux" "$1"
	fi
		return 0
}

function write_named_conf_local 
{	
	echo -e "$OPCIONES_CONF" > "${DIR_BIND}/named.conf.local"
	echo -e "$ZONAS" >> "${DIR_BIND}/named.conf.local"
	chmod +r "${DIR_BIND}/named.conf.local"
	return 0
}



function write_resoluciones 
{	
	file_replace "${DIR_BIND}/${ARCH_CONFIGURACION}" "localhost" "${DOMINIO_DNS}" 
	file_replace "${DIR_BIND}/${ARCH_CONFIGURACION}" "127.0.0.1" "${IP_DNS}" 

	cp "${ARCH_CONFIGURACION}" "${DIR_BIND}/${ARCH_CONF_ROOT}"
	cp "${ARCH_CONFIGURACION_INV}" "${DIR_BIND}/${ARCH_CONF_INVERSO_10}"
	cp "${ARCH_CONFIGURACION_INV}" "${DIR_BIND}/${ARCH_CONF_INVERSO_192_168}"
	cp "${ARCH_CONFIGURACION_INV}" "${DIR_BIND}/${ARCH_CONF_INVERSO_172_13}"
	cp "${ARCH_CONFIGURACION_INV}" "${DIR_BIND}/${ARCH_CONF_INVERSO_137_43}"	

	echo "\$ORIGIN in-addr.arpa." > "${DIR_BIND}/${ARCH_CONF_INVERSO}"
	
	cat "${DIR_BIND}/${ARCH_CONFIGURACION}" >> "${DIR_BIND}/${ARCH_CONF_INVERSO}"

	# Cargo las resoluciones 
	for entrada in "${RESOLUCIONES[@]}"; do
		echo "$entrada" >> "${DIR_BIND}/${ARCH_CONF_ROOT}"
	done
		
	chmod +r "${DIR_BIND}/${ARCH_CONF_ROOT}"

	
	# Cargo las resoluciones Inversas
	for entrada_inv in "${RESOLUCIONES_INV_10[@]}"; do
		echo "$entrada_inv" >> "${DIR_BIND}/${ARCH_CONF_INVERSO_10}"
	done
	chmod +r "${DIR_BIND}/${ARCH_CONF_INVERSO_10}"

	for entrada_inv in "${RESOLUCIONES_INV_172_13[@]}"; do
		echo "$entrada_inv" >> "${DIR_BIND}/${ARCH_CONF_INVERSO_172_13}"
	done
	chmod +r "${DIR_BIND}/${ARCH_CONF_INVERSO_172_13}"

	for entrada_inv in "${RESOLUCIONES_INV_137_43[@]}"; do
		echo "$entrada_inv" >> "${DIR_BIND}/${ARCH_CONF_INVERSO_137_43}"
	done
	chmod +r "${DIR_BIND}/${ARCH_CONF_INVERSO_137_43}"

	for entrada_inv in "${RESOLUCIONES_INV_192_168[@]}"; do
		echo "$entrada_inv" >> "${DIR_BIND}/${ARCH_CONF_INVERSO_192_168}"
	done
	chmod +r "${DIR_BIND}/${ARCH_CONF_INVERSO_192_168}"

	return 0
}



function start_bind9 {
	echo "Starting bind9"
	/etc/init.d/bind9 restart

	if [ "$?" != "0" ];then 
		exit_conf "3" "Error iniciando bind9"
	fi

	return 0
}


function write_confs
{
	write_named_conf
	write_named_conf_local
	write_resoluciones
}



echo "Dns root"

validaciones

write_confs

start_bind9

echo "Servidor dns root corriendo"

exit_conf "0"
