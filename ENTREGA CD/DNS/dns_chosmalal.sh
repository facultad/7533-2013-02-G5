#!/bin/bash

## Configuración de Servidor DNS para la Zona Chos Malal

ETC_BIND="${_ETC_BIND:-/etc/bind}"
DOMINIO_EMPRESA="${_DOMINIO_EMPRESA:-neuquen.dc.fi.uba.ar}"

DOMINIO_DNS="chosmalal.${DOMINIO_EMPRESA}"
CONF_LOCAL="db.local"
CONF_ROOT="db.root.dns"
CONF_INVERSO_10_134_13_64_65="db.local.10.134.13.64-65" #G
CONF_INVERSO_10_11_23="db.local.10.11.23" #C
CONF_INVERSO_192_168_53="db.local.192.168.53" #A

IP_DNSROOT="${_IP_DNSROOT:-10.9.12.196}"

IP_DNS="${_IP_DNS_1:-127.0.0.1}"


CONF_OPTIONS="options {
     directory \"/var/cache/bind\";
     dump-file \"/var/cache/bind/cache_dump.db\";
     statistics-file \"/var/cache/bind/named_stats.txt\";

     //query-source address * port 53;

     //allow-recursion { none; };
	
     listen-on { 127.0.0.1; ${IP_DNS}; };

     listen-on port 53 { any; };

     allow-query { any;
	};
};"



ZONES="zone \"${DOMINIO_DNS}\" IN {
	type master;
	file \"${ETC_BIND}/${CONF_LOCAL}\";
	allow-update { none; };
};

zone \"${DOMINIO_EMPRESA}\" IN {
	type forward;
	forwarders { ${IP_DNSROOT}; };
};

zone \"in-addr.arpa\" IN {
	type forward;
	forwarders { ${IP_DNSROOT}; };
};

zone \"64-65.13.134.10.in-addr.arpa\" IN {
        type master;
        file \"${ETC_BIND}/${CONF_INVERSO_10_134_13_64_65}\";
        allow-update { none; };
};

zone \"23.11.10.in-addr.arpa\" IN {
        type master;
        file \"${ETC_BIND}/${CONF_INVERSO_10_11_23}\";
        allow-update { none; };
};

zone \"53.168.192.in-addr.arpa\" IN {
        type master;
        file \"${ETC_BIND}/${CONF_INVERSO_192_168_53}\";
        allow-update { none; };
};
"


declare -a DIRECTAS=(
"goshawk	IN	A	10.134.13.64 ; Red G  /27 " \
"R2.goshawk	IN	A	10.134.13.65;" \
\
"concorde	IN	A	10.11.23.0 ; Red C /24 "  \
"R1.concorde	IN	A	10.11.23.1;" \
"R2.concorde	IN	A	10.11.23.2;" \
"R3.concorde	IN	A	10.11.23.3;" \
"R4.concorde	IN	A	10.11.23.4;" \
"R5.concorde	IN	A	10.11.23.5;" \
"masterVRRP.concorde	IN	A	10.11.23.6;" \
"a.concorde	IN	A	10.11.23.7;" \
\
"airbus		IN	A	192.168.53.0 ;   Red A  /24" \
"R4.airbus	IN	A	192.168.53.2;" \
"R5.airbus	IN	A	192.168.53.3;" \
"R6.airbus	IN	A	192.168.53.5;" \
"masterVRRP.concorde	IN	A	192.168.53.4;" \
"www.airbus	IN	A	192.168.53.1;" \
)


declare -a INVERSAS_10_134_13_64_65=(
"64	IN	PTR	goshawk.${DOMINIO_DNS} ; Red G  /27 " \
"65	IN	PTR	R2.goshawk.${DOMINIO_DNS};" \
)

declare -a INVERSAS_10_11_23=(
"0	IN	PTR	concorde.${DOMINIO_DNS} ; Red C  /24 " \
"1	IN	PTR	R1.concorde.${DOMINIO_DNS};" \
"2	IN	PTR	R2.concorde.${DOMINIO_DNS};" \
"3	IN	PTR	R3.concorde.${DOMINIO_DNS};" \
"4	IN	PTR	R4.concorde.${DOMINIO_DNS};" \
"5	IN	PTR	R5.concorde.${DOMINIO_DNS};" \
"6	IN	PTR	masterVRRP.concorde.${DOMINIO_DNS};" \
"7	IN	PTR	a.concorde.${DOMINIO_DNS};" \
)

declare -a INVERSAS_192_168_53=(
"1	IN	PTR	www.airbus.${DOMINIO_DNS} ;" \
"0	IN	PTR	airbus.${DOMINIO_DNS};	Red A  /24 "  \
"2	IN	PTR	R4.airbus.${DOMINIO_DNS};" \
"3	IN	PTR	R5.airbus.${DOMINIO_DNS};" \
"5	IN	PTR	R6.airbus.${DOMINIO_DNS};" \
"4	IN	PTR	masterVRRP.airbus.${DOMINIO_DNS};" \
)




## Funciones auxiliares
function exit_conf 
{
	if [ "$#" = "0" ];then 
		echo "DNS OK"
		exit 0
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
		exit_conf "5" "No es root"
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
function write_named_conf {	
	#cargo ell named_conf
	file_replace "${ETC_BIND}/named.conf" "include" "//include"	
	echo "include \"${ETC_BIND}/named.conf.local\";" >> "${ETC_BIND}/named.conf";	
	chmod +r "${ETC_BIND}/named.conf"
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

function write_named_conf_local {	
	echo -e "$CONF_OPTIONS" > "${ETC_BIND}/named.conf.local"
	echo -e "$ZONES" >> "${ETC_BIND}/named.conf.local"
	chmod +r "${ETC_BIND}/named.conf.local"
	return 0
}



function write_resoluciones {	
	file_replace "${ETC_BIND}/${CONF_LOCAL}" "localhost" "${DOMINIO_DNS}" 
	file_replace "${ETC_BIND}/${CONF_LOCAL}" "127.0.0.1" "${IP_DNS}" 
	
	cp "${ETC_BIND}/${CONF_LOCAL}" "${ETC_BIND}/${CONF_ROOT}"
	cp "${ETC_BIND}/${CONF_LOCAL}" "${ETC_BIND}/${CONF_INVERSO_10_134_13_64_65}"
	cp "${ETC_BIND}/${CONF_LOCAL}" "${ETC_BIND}/${CONF_INVERSO_10_11_23}"
	cp "${ETC_BIND}/${CONF_LOCAL}" "${ETC_BIND}/${CONF_INVERSO_192_168_53}"
	
	file_replace "${ETC_BIND}/${CONF_ROOT}" "${DOMINIO_DNS}" "${DOMINIO_EMPRESA}" 
	file_replace "${ETC_BIND}/${CONF_ROOT}" "${IP_DNS}" "${IP_DNSROOT}" 
	
	#directas 
	for resolution in "${DIRECTAS[@]}"; do
		echo "$resolution" >> "${ETC_BIND}/${CONF_LOCAL}"
	done
		
	chmod +r "${ETC_BIND}/${CONF_LOCAL}"

	
	#inversas

   	for resolution in "${INVERSAS_10_134_13_64_65[@]}"; do
                echo "$resolution" >> "${ETC_BIND}/${CONF_INVERSO_10_134_13_64_65}"
        done
        chmod +r "${ETC_BIND}/${CONF_INVERSO_10_134_13_64_65}"

		
   	for entrada_inv_10_11_23 in "${INVERSAS_10_11_23[@]}"; do
                echo "$entrada_inv_10_11_23" >> "${ETC_BIND}/${CONF_INVERSO_10_11_23}"
        done
        chmod +r "${ETC_BIND}/${CONF_INVERSO_10_11_23}"

		
   	for resolution in "${INVERSAS_192_168_53[@]}"; do
                echo "$resolution" >> "${ETC_BIND}/${CONF_INVERSO_192_168_53}"
        done
        chmod +r "${ETC_BIND}/${CONF_INVERSO_192_168_53}"

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


echo "Dns chosmalal"

validaciones
write_confs

start_bind9

echo "Servidor dns de chosmalal corriendo"

exit_conf

