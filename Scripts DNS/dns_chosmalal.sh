#!/bin/bash



## Configuración de Servidor DNS para la Zona Chos Malal

## Definición de constantes

NOMBRE_ZONA="Chos Malal"
DIR_BIND="${_DIR_BIND:-/etc/bind}"
DOMINIO_DNS_ROOT="${_DOMINIO_DNS_ROOT:-neuquen.dc.fi.uba.ar}"

DOMINIO_DNS="chosmalal.${DOMINIO_DNS_ROOT}"
ARCH_CONFIGURACION="db.local"
ARCH_DNS_ROOT="db.root.dns"
ARCH_CONF_INVERSO_10_134_13_64_65="db.local.10.134.13.64-65" #G
ARCH_CONF_INVERSO_10_11_23="db.local.10.11.23" #C
ARCH_CONF_INVERSO_192_168_53="db.local.192.168.53" #A

IP_DNS_ROOT="${_IP_DNS_ROOT:-10.9.12.196}"

IP_DNS="${_IP_DNS_1:-127.0.0.1}"



declare -a RESOLUCIONES_DNS_ROOT=(
"mm	IN	A	20.20.20.20 ;" \
"\$ORIGIN ${DOMINIO_DNS_ROOT}" \
"@	IN	A	ns ;" \
"ns	IN	A	${IP_DNS_ROOT} ;" \
)

OPCIONES_CONF="options {
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



ZONAS="zone \"${DOMINIO_DNS}\" IN {
	type master;
	file \"${DIR_BIND}/${ARCH_CONFIGURACION}\";
	allow-update { none; };
};

zone \"${DOMINIO_DNS_ROOT}\" IN {
	type forward;
	forwarders { ${IP_DNS_ROOT}; };
};

zone \"in-addr.arpa\" IN {
	type forward;
	forwarders { ${IP_DNS_ROOT}; };
};

zone \"64-65.13.134.10.in-addr.arpa\" IN {
        type master;
        file \"${DIR_BIND}/${ARCH_CONF_INVERSO_10_134_13_64_65}\";
        allow-update { none; };
};

zone \"23.11.10.in-addr.arpa\" IN {
        type master;
        file \"${DIR_BIND}/${ARCH_CONF_INVERSO_10_11_23}\";
        allow-update { none; };
};

zone \"53.168.192.in-addr.arpa\" IN {
        type master;
        file \"${DIR_BIND}/${ARCH_CONF_INVERSO_192_168_53}\";
        allow-update { none; };
};
"


declare -a RESOLUCIONES=(
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
"a.concorde	IN	A	10.11.23.7;Ubicado en la red C, con masc /24" \
\
"airbus		IN	A	192.168.53.0 ;   Red A  /24" \
"R4.airbus	IN	A	192.168.53.2;" \
"R5.airbus	IN	A	192.168.53.3;" \
"R6.airbus	IN	A	192.168.53.5;" \
"masterVRRP.concorde	IN	A	192.168.53.4;" \
"www.airbus	IN	A	192.168.53.1; Ubicado en la red A" \
)


declare -a RESOLUCIONES_INV_10_134_13_64_65=(
"64	IN	PTR	goshawk.${DOMINIO_DNS} ; Red G  /27 " \
"65	IN	PTR	R2.goshawk.${DOMINIO_DNS};" \
)

declare -a RESOLUCIONES_INV_10_11_23=(
"0	IN	PTR	concorde.${DOMINIO_DNS} ; Red C  /24 " \
"1	IN	PTR	R1.concorde.${DOMINIO_DNS};" \
"2	IN	PTR	R2.concorde.${DOMINIO_DNS};" \
"3	IN	PTR	R3.concorde.${DOMINIO_DNS};" \
"4	IN	PTR	R4.concorde.${DOMINIO_DNS};" \
"5	IN	PTR	R5.concorde.${DOMINIO_DNS};" \
"6	IN	PTR	masterVRRP.concorde.${DOMINIO_DNS};" \
"7	IN	PTR	a.concorde.${DOMINIO_DNS}; Ubicado en la red C, con masc /24" \
)

declare -a RESOLUCIONES_INV_192_168_53=(
"1	IN	PTR	www.airbus.${DOMINIO_DNS} ;  Ubicado en la red A " \
"0	IN	PTR	airbus.${DOMINIO_DNS};	Red A  /24 "  \
"2	IN	PTR	R4.airbus.${DOMINIO_DNS};" \
"3	IN	PTR	R5.airbus.${DOMINIO_DNS};" \
"5	IN	PTR	R6.airbus.${DOMINIO_DNS};" \
"4	IN	PTR	masterVRRP.airbus.${DOMINIO_DNS};" \
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
function write_named_conf {	
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

function write_named_conf_local {	
	echo -e "$OPCIONES_CONF" > "${DIR_BIND}/named.conf.local"
	echo -e "$ZONAS" >> "${DIR_BIND}/named.conf.local"
	chmod +r "${DIR_BIND}/named.conf.local"
	return 0
}



function write_resoluciones {	
	file_replace "${DIR_BIND}/${ARCH_CONFIGURACION}" "localhost" "${DOMINIO_DNS}" 
	file_replace "${DIR_BIND}/${ARCH_CONFIGURACION}" "127.0.0.1" "${IP_DNS}" 
	
	cp "${DIR_BIND}/${ARCH_CONFIGURACION}" "${DIR_BIND}/${ARCH_DNS_ROOT}"
	cp "${DIR_BIND}/${ARCH_CONFIGURACION}" "${DIR_BIND}/${ARCH_CONF_INVERSO_10_134_13_64_65}"
	cp "${DIR_BIND}/${ARCH_CONFIGURACION}" "${DIR_BIND}/${ARCH_CONF_INVERSO_10_11_23}"
	cp "${DIR_BIND}/${ARCH_CONFIGURACION}" "${DIR_BIND}/${ARCH_CONF_INVERSO_192_168_53}"
	
	file_replace "${DIR_BIND}/${ARCH_DNS_ROOT}" "${DOMINIO_DNS}" "${DOMINIO_DNS_ROOT}" 
	file_replace "${DIR_BIND}/${ARCH_DNS_ROOT}" "${IP_DNS}" "${IP_DNS_ROOT}" 
	
	# Cargo las resoluciones del Root 
	for entrada_root in "${RESOLUCIONES_DNS_ROOT[@]}"; do
		echo "$entrada_root" >> "${DIR_BIND}/${ARCH_DNS_ROOT}"
	done
	chmod +r "${DIR_BIND}/${ARCH_DNS_ROOT}"

	# Cargo las resoluciones 
	for entrada in "${RESOLUCIONES[@]}"; do
		echo "$entrada" >> "${DIR_BIND}/${ARCH_CONFIGURACION}"
	done
		
	chmod +r "${DIR_BIND}/${ARCH_CONFIGURACION}"

	
	# Cargo las resoluciones Inversas

   	for entrada_inv_10_134_13_64_65 in "${RESOLUCIONES_INV_10_134_13_64_65[@]}"; do
                echo "$entrada_inv_10_134_13_64_65" >> "${DIR_BIND}/${ARCH_CONF_INVERSO_10_134_13_64_65}"
        done
        chmod +r "${DIR_BIND}/${ARCH_CONF_INVERSO_10_134_13_64_65}"

		
   	for entrada_inv_10_11_23 in "${RESOLUCIONES_INV_10_11_23[@]}"; do
                echo "$entrada_inv_10_11_23" >> "${DIR_BIND}/${ARCH_CONF_INVERSO_10_11_23}"
        done
        chmod +r "${DIR_BIND}/${ARCH_CONF_INVERSO_10_11_23}"

		
   	for entrada_inv_192_168_53 in "${RESOLUCIONES_INV_192_168_53[@]}"; do
                echo "$entrada_inv_192_168_53" >> "${DIR_BIND}/${ARCH_CONF_INVERSO_192_168_53}"
        done
        chmod +r "${DIR_BIND}/${ARCH_CONF_INVERSO_192_168_53}"

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

exit_conf "0"

