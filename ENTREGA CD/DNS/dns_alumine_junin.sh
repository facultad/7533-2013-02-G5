#!/bin/bash

## Configuración de Servidor DNS para la Zona Alumine y Junin de los andes

ETC_BIND="${_ETC_BIND:-/etc/bind}"
DOMINIO_EMPRESA="${_DOMINIO_EMPRESA:-neuquen.dc.fi.uba.ar}"

DOMINIO_DNS="neuquen.dc.fi.uba.ar"
CONF_LOCAL="db.local"
CONF_ROOT="rootdns.ca"
CONF_ALUMINE="db.alumine"
CONF_JUNIN="db.junin"


CONF_INVERSO_10_9_12_192_197="db.local.10.9.12.192-197" #F
CONF_INVERSO_10_134_13_48_49="db.local.10.134.13.48-49" #M
CONF_INVERSO_10_11_22="db.local.10.11.22" #B
CONF_INVERSO_10_134_13_160_162="db.local.10.134.13.160-162" #L
CONF_INVERSO_10_134_13_40_42="db.local.10.134.13.40-42" #P

CONF_INVERSO_10_134_13_128_131="db.local.10.134.13.128-131" #J
CONF_INVERSO_10_134_13_44_46="db.local.10.134.13.44-46" #O
CONF_INVERSO_10_134_1="db.local.10.134.1" #D
CONF_INVERSO_10_134_13_96_97="db.local.10.134.13.96-97" #H
CONF_INVERSO_10_134_5_128_133="db.local.10.134.5.128-133" #E
CONF_INVERSO_10_134_13_36_38="db.local.10.134.13.36-38" #T
CONF_INVERSO_10_134_13_32_34="db.local.10.134.13.32-34" #V
CONF_INVERSO_10_134_13_28_30="db.local.10.134.13.28-30" #X

CONF_INVERSO_172_13_1="db.local.172.13.1" #Y
CONF_INVERSO_137_43="db.local.137.43" #S


IP_DNSROOT="${_IP_DNSROOT:-10.9.12.196}"

IP_DNS="${_IP_DNS_2:-127.0.0.1}"
SERVIDOR_DNS_ROOT="${DOMINIO_EMPRESA}	3600000	A	${IP_DNSROOT}"

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



ZONES="
zone \"alumine.${DOMINIO_DNS}\" IN {
	type master;
	file \"${ETC_BIND}/${CONF_ALUMINE}\";
	allow-update { none; };
};	

zone \"junin.${DOMINIO_DNS}\" IN {
	type master;
	file \"${ETC_BIND}/${CONF_JUNIN}\";
	allow-update { none; };
};

zone \"in-addr.arpa\" IN {
	type forward;
	forwarders { ${IP_DNSROOT}; };
};

zone \"192-197.12.9.10.in-addr.arpa\" IN {
	type master;
	file \"${ETC_BIND}/${CONF_INVERSO_10_9_12_192_197}\";
	allow-update { none; };
};

zone \"48-49.13.134.10.in-addr.arpa\" IN {
	type master;
	file \"${ETC_BIND}/${CONF_INVERSO_10_134_13_48_49}\";
	allow-update { none; };
};

zone \"22.11.10.in-addr.arpa\" IN {
	type master;
	file \"${ETC_BIND}/${CONF_INVERSO_10_11_22}\";
	allow-update { none; };
};

zone \"160-162.13.134.10.in-addr.arpa\" IN {
	type master;
	file \"${ETC_BIND}/${CONF_INVERSO_10_134_13_160_162}\";
	allow-update { none; };
};

zone \"40-42.13.134.10.in-addr.arpa\" IN {
	type master;
	file \"${ETC_BIND}/${CONF_INVERSO_10_134_13_40_42}\";
	allow-update { none; };
};

zone \"128-131.13.134.10.in-addr.arpa\" IN {
	type master;
	file \"${ETC_BIND}/${CONF_INVERSO_10_134_13_128_131}\";
	allow-update { none; };
};

zone \"44-46.13.134.10.in-addr.arpa\" IN {
	type master;
	file \"${ETC_BIND}/${CONF_INVERSO_10_134_13_44_46}\";
	allow-update { none; };
};

zone \"1.134.10.in-addr.arpa\" IN {
	type master;
	file \"${ETC_BIND}/${CONF_INVERSO_10_134_1}\";
	allow-update { none; };
};

zone \"96-97.13.134.10.in-addr.arpa\" IN {
	type master;
	file \"${ETC_BIND}/${CONF_INVERSO_10_134_13_96_97}\";
	allow-update { none; };
};

zone \"128-133.5.134.10.in-addr.arpa\" IN {
	type master;
	file \"${ETC_BIND}/${CONF_INVERSO_10_134_5_128_133}\";
	allow-update { none; };
};

zone \"36-38.13.134.10.in-addr.arpa\" IN {
	type master;
	file \"${ETC_BIND}/${CONF_INVERSO_10_134_13_36_38}\";
	allow-update { none; };
};

zone \"32-34.13.134.10.in-addr.arpa\" IN {
	type master;
	file \"${ETC_BIND}/${CONF_INVERSO_10_134_13_32_34}\";
	allow-update { none; };
};

zone \"28-30.13.134.10.in-addr.arpa\" IN {
	type master;
	file \"${ETC_BIND}/${CONF_INVERSO_10_134_13_28_30}\";
	allow-update { none; };
};

zone \"43.137.in-addr.arpa\" IN {
	type master;
	file \"${ETC_BIND}/${CONF_INVERSO_137_43}\";
	allow-update { none; };
};

zone \"1.13.172.in-addr.arpa\" IN {
	type master;
	file \"${ETC_BIND}/${CONF_INVERSO_172_13_1}\";
	allow-update { none; };
};


zone \"${DOMINIO_EMPRESA}\" IN {
	type forward;
	forwarders { ${IP_DNSROOT}; };
};
"


declare -a DIRECTAS_ALUMINE=(
"fokker	IN	A	10.9.12.192 ; Red F /26 " \
"R13.fokker	IN	A	10.9.12.193;" \
"R14.fokker	IN	A	10.9.12.194;" \
"R15.fokker	IN	A	10.9.12.195;" \
"nsroot.fokker	IN	A	10.9.12.196;" \
"c.fokker	IN	A	10.9.12.197;" \
\
"mikoyan	IN	A	10.134.13.48 ; Red M /28 "  \
"R14.mikoyan	IN	A	10.134.13.49;" \
\
"boeing	IN	A	10.11.22.0 ; Red B /24 "  \
"R14.boeing	IN	A	10.11.22.2;" \
"R15.boeing	IN	A	10.11.22.3;" \
"R16.boeing	IN	A	10.11.22.4;" \
"ftp.boeing	IN	A	10.11.22.1;" \
\
"lockheed	IN	A	10.134.13.160 ; Red L /27 "  \
"R12.lockheed	IN	A	10.134.13.161;" \
"R16.lockheed	IN	A	10.134.13.162;" \
\
"panavia	IN	A	10.134.13.40 ; Red P /30 "  \
"R9.panavia	IN	A	10.134.13.41;" \
"R13.panavia	IN	A	10.134.13.42;" \
)

declare -a DIRECTAS_JUNIN=(
"jumbo	IN	A	10.134.13.128 ; Red J /27 "  \
"R8.jumbo	IN	A	10.134.13.129;" \
"R9.jumbo	IN	A	10.134.13.130;" \
"masterVRRP.jumbo	IN	A	10.134.13.131;" \
\
"osprey	IN	A	10.134.13.44 ; Red O /30 "  \
"R3.osprey	IN	A	10.134.13.45;" \
"R7.osprey	IN	A	10.134.13.46;" \
\
"douglas	IN	A	10.134.1.0 ; Red D /24 "  \
"telnet.douglas	IN	A	10.134.1.130;" \
"R7.douglas	IN	A	10.134.1.1;" \
"R8.douglas	IN	A	10.134.1.2;" \
"R9.douglas	IN	A	10.134.1.3;" \
"b.douglas	IN	A	10.134.1.5;" \
"masterVRRP.douglas	IN	A	10.134.1.4;" \
\
"havilland	IN	A	10.134.13.96 ; Red H /27 "  \
"R10.havilland	IN	A	10.134.13.97;" \
\
"embraer	IN	A	10.134.5.128 ; Red E /25 "  \
"telnet.embraer	IN	A	10.134.5.129;" \
"R9.embraer	IN	A	10.134.5.130;" \
"R10.embraer	IN	A	10.134.5.131;" \
"R11.embraer	IN	A	10.134.5.132;" \
"ns2.embraer	IN	A	10.134.5.133;" \
\
"tupolev	IN	A	10.134.13.36 ; Red T privada /30 "  \
"R6.tupolev	IN	A	10.134.13.37;" \
"R11.tupolev	IN	A	10.134.13.38;" \
\
"vector	IN	A	10.134.13.32 ; Red V privada /30 "  \
"R6.vector	IN	A	10.134.13.33;" \
"R12.vector	IN	A	10.134.13.34;" \
\
"xingu	IN	A	10.134.13.28 ; Red X privada /30 "  \
"R11.xingu	IN	A	10.134.13.29;" \
"R12.xingu	IN	A	10.134.13.30;" \
\
"R6.saab	IN	A	137.43.1.2;" \
"INTERNET.saab	IN	A	137.43.1.1;" \
\
"R11.saab2	IN	A	137.43.1.6;" \
"INTERNET.saab2	IN	A	137.43.1.5;" \
\
"R12.saab3	IN	A	137.43.1.10;" \
"INTERNET.saab3	IN	A	137.43.1.9;" \
\
"R1R7.yakovlev	IN	A	172.13.1.193;" \
"R1R13.yakovlev	IN	A	172.13.1.197;" \
\
"R7R1.yakovlev	IN	A	172.13.1.194;" \
"R7R13.yakovlev	IN	A	172.13.1.201;" \
\
"R13R1.yakovlev	IN	A	172.13.1.198;" \
"R13R7.yakovlev	IN	A	172.13.1.202;" \
\
)


declare -a INVERSAS_10_9_12_192_197=(
"192	IN	PTR	fokker.alumine.${DOMINIO_DNS}; 	Red F  /26 " \
"193	IN	PTR	R13.fokker.alumine.${DOMINIO_DNS}; " \
"194	IN	PTR	R14.fokker.alumine.${DOMINIO_DNS}; " \
"195	IN	PTR	R15.fokker.alumine.${DOMINIO_DNS}; " \
"196	IN	PTR	nsroot.fokker.alumine.${DOMINIO_DNS}; " \
"197	IN	PTR	c.fokker.alumine.${DOMINIO_DNS};" \
)

declare -a INVERSAS_10_134_13_48_49=(
"48	IN	PTR	mikoyan.alumine.${DOMINIO_DNS}; 	Red M  /28 " \
"49	IN	PTR	R14.mikoyan.alumine.${DOMINIO_DNS}; " \
)

declare -a INVERSAS_10_11_22=(
"0	IN	PTR	boeing.alumine.${DOMINIO_DNS}; 	Red B  /24 " \
"2	IN	PTR	R14.boeing.alumine.${DOMINIO_DNS}; " \
"3	IN	PTR	R15.boeing.alumine.${DOMINIO_DNS}; " \
"4	IN	PTR	R16.boeing.alumine.${DOMINIO_DNS}; " \
"1	IN	PTR	ftp.boeing.alumine.${DOMINIO_DNS}; " \
)

declare -a INVERSAS_10_134_13_160_162=(
"160	IN	PTR	lockheed.alumine.${DOMINIO_DNS}; 	Red L  /27 " \
"161	IN	PTR	R12.lockheed.alumine.${DOMINIO_DNS}; " \
"162	IN	PTR	R16.lockheed.alumine.${DOMINIO_DNS}; " \
)

declare -a INVERSAS_10_134_13_40_42=(
"40	IN	PTR	panavia.alumine.${DOMINIO_DNS}; 	Red P  /30 " \
"41	IN	PTR	R9.panavia.alumine.${DOMINIO_DNS}; " \
"42	IN	PTR	R13.panavia.alumine.${DOMINIO_DNS}; " \
)

declare -a INVERSAS_10_134_13_128_131=(
"128	IN	PTR	jumbo.junin.${DOMINIO_DNS}; 	Red J  /27 " \
"129	IN	PTR	R8.jumbo.junin.${DOMINIO_DNS}; " \
"130	IN	PTR	R9.jumbo.junin.${DOMINIO_DNS}; " \
"131	IN	PTR	masterVRRP.jumbo.junin.${DOMINIO_DNS}; " \
)

declare -a INVERSAS_10_134_13_44_46=(
"44	IN	PTR	osprey.junin.${DOMINIO_DNS}; 	Red O  /30 " \
"45	IN	PTR	R3.osprey.junin.${DOMINIO_DNS}; " \
"46	IN	PTR	R7.osprey.junin.${DOMINIO_DNS}; " \
)

declare -a INVERSAS_10_134_1=(
"0	IN	PTR	douglas.junin.${DOMINIO_DNS}; 	Red D  /24 " \
"130	IN	PTR	telnet.douglas.junin.${DOMINIO_DNS}; " \
"1	IN	PTR	R7.douglas.junin.${DOMINIO_DNS}; " \
"2	IN	PTR	R8.douglas.junin.${DOMINIO_DNS}; " \
"3	IN	PTR	R9.douglas.junin.${DOMINIO_DNS}; " \
"5	IN	PTR	b.douglas.junin.${DOMINIO_DNS};" \
"4	IN	PTR	masterVRRP.douglas.junin.${DOMINIO_DNS}; " \
)

declare -a INVERSAS_10_134_13_96_97=(
"96	IN	PTR	havilland.junin.${DOMINIO_DNS}; 	Red H  /27 " \
"97	IN	PTR	R10.havilland.junin.${DOMINIO_DNS}; " \
)

declare -a INVERSAS_10_134_5_128_133=(
"128	IN	PTR	embraer.junin.${DOMINIO_DNS}; 	Red E  /25 " \
"129	IN	PTR	telnet.embraer.junin.${DOMINIO_DNS}; " \
"130	IN	PTR	R9.embraer.junin.${DOMINIO_DNS}; " \
"131	IN	PTR	R10.embraer.junin.${DOMINIO_DNS}; " \
"132	IN	PTR	R11.embraer.junin.${DOMINIO_DNS}; " \
"132	IN	PTR	ns2.embraer.junin.${DOMINIO_DNS}; " \
)

declare -a INVERSAS_10_134_13_36_38=(
"36	IN	PTR	tupolev.junin.${DOMINIO_DNS}; 	Red T /30 " \
"37	IN	PTR	R6.tupolev.junin.${DOMINIO_DNS}; " \
"38	IN	PTR	R11.tupolev.junin.${DOMINIO_DNS}; " \
)

declare -a INVERSAS_10_134_13_32_34=(
"32	IN	PTR	vector.junin.${DOMINIO_DNS}; 	Red V /30 " \
"33	IN	PTR	R6.vector.junin.${DOMINIO_DNS}; " \
"34	IN	PTR	R12.vector.junin.${DOMINIO_DNS}; " \
)

declare -a INVERSAS_10_134_13_28_30=(
"28	IN	PTR	xingu.junin.${DOMINIO_DNS}; 	Red X /30 " \
"29	IN	PTR	R11.xingu.junin.${DOMINIO_DNS}; " \
"30	IN	PTR	R12.xingu.junin.${DOMINIO_DNS}; " \
)

declare -a INVERSAS_172_13_1=(
"193	IN	PTR	R1R7.yakovlev.junin.${DOMINIO_DNS};  " \
"197	IN	PTR	R1R13.yakovlev.junin.${DOMINIO_DNS};  " \
"194	IN	PTR	R7R1.yakovlev.junin.${DOMINIO_DNS};  " \
"201	IN	PTR	R7R13.yakovlev.junin.${DOMINIO_DNS};  " \
"198	IN	PTR	R13R1.yakovlev.junin.${DOMINIO_DNS};  " \
"202	IN	PTR	R13R7.yakovlev.junin.${DOMINIO_DNS};  " \
)

declare -a INVERSAS_137_43=( 
"2.1	IN	PTR	R6.saab.junin.${DOMINIO_DNS};" \
"1.1	IN	PTR	INTERNET.saab.junin.${DOMINIO_DNS};" \
\
"6.1	IN	PTR	R11.saab2.junin.${DOMINIO_DNS};" \
"5.1	IN	PTR	INTERNET.saab2.junin.${DOMINIO_DNS};" \
\
"10.1	IN	PTR	R12.saab3.junin.${DOMINIO_DNS};" \
"9.1	IN	PTR	INTERNET.saab3.junin.${DOMINIO_DNS};" \
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

function write_named_conf 
{	
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

function write_named_conf_local 
{	
	echo -e "${SERVIDOR_DNS_ROOT}" > "${ETC_BIND}/${CONF_ROOT}"	
	echo -e "$CONF_OPTIONS" > "${ETC_BIND}/named.conf.local"
	echo -e "$ZONES" >> "${ETC_BIND}/named.conf.local"
	chmod +r "${ETC_BIND}/named.conf.local"
	return 0
}



function write_resoluciones
{	
	file_replace "${ETC_BIND}/${CONF_LOCAL}" "127.0.0.1" "${IP_DNS}" 
	
	cp "${ETC_BIND}/${CONF_LOCAL}" "${ETC_BIND}/${CONF_ALUMINE}"
	cp "${ETC_BIND}/${CONF_LOCAL}" "${ETC_BIND}/${CONF_JUNIN}"

	cp "${ETC_BIND}/${CONF_LOCAL}" "${ETC_BIND}/${CONF_INVERSO_10_9_12_192_197}"
	cp "${ETC_BIND}/${CONF_LOCAL}" "${ETC_BIND}/${CONF_INVERSO_10_134_13_48_49}"
	cp "${ETC_BIND}/${CONF_LOCAL}" "${ETC_BIND}/${CONF_INVERSO_10_11_22}"
	cp "${ETC_BIND}/${CONF_LOCAL}" "${ETC_BIND}/${CONF_INVERSO_10_134_13_160_162}"
	cp "${ETC_BIND}/${CONF_LOCAL}" "${ETC_BIND}/${CONF_INVERSO_10_134_13_40_42}"
	
	cp "${ETC_BIND}/${CONF_LOCAL}" "${ETC_BIND}/${CONF_INVERSO_10_134_13_128_131}"
	cp "${ETC_BIND}/${CONF_LOCAL}" "${ETC_BIND}/${CONF_INVERSO_10_134_13_44_46}"
	cp "${ETC_BIND}/${CONF_LOCAL}" "${ETC_BIND}/${CONF_INVERSO_10_134_1}"
	cp "${ETC_BIND}/${CONF_LOCAL}" "${ETC_BIND}/${CONF_INVERSO_10_134_13_96_97}"
	cp "${ETC_BIND}/${CONF_LOCAL}" "${ETC_BIND}/${CONF_INVERSO_10_134_5_128_133}"
	cp "${ETC_BIND}/${CONF_LOCAL}" "${ETC_BIND}/${CONF_INVERSO_10_134_13_36_38}"
	cp "${ETC_BIND}/${CONF_LOCAL}" "${ETC_BIND}/${CONF_INVERSO_10_134_13_32_34}"
	cp "${ETC_BIND}/${CONF_LOCAL}" "${ETC_BIND}/${CONF_INVERSO_10_134_13_28_30}"
	
	cp "${ETC_BIND}/${CONF_LOCAL}" "${ETC_BIND}/${CONF_INVERSO_172_13_1}"
	cp "${ETC_BIND}/${CONF_LOCAL}" "${ETC_BIND}/${CONF_INVERSO_137_43}"
	
	# directas
	file_replace "${ETC_BIND}/${CONF_ALUMINE}" "localhost" "alumine.${DOMINIO_DNS}"
	file_replace "${ETC_BIND}/${CONF_ALUMINE}" "127.0.0.1" "${IP_DNS}"
	for resolution in "${DIRECTAS_ALUMINE[@]}"; do
		echo "$resolution" >> "${ETC_BIND}/${CONF_ALUMINE}"
	done
	chmod +r "${ETC_BIND}/${CONF_ALUMINE}"
	
	file_replace "${ETC_BIND}/${CONF_JUNIN}" "localhost" "junin.${DOMINIO_DNS}"
	file_replace "${ETC_BIND}/${CONF_JUNIN}" "127.0.0.1" "${IP_DNS}"
	for resolution in "${DIRECTAS_JUNIN[@]}"; do
		echo "$resolution" >> "${ETC_BIND}/${CONF_JUNIN}"
	done
	chmod +r "${ETC_BIND}/${CONF_JUNIN}"	
	
	
	#inversas
	for resolution in "${INVERSAS_10_9_12_192_197[@]}"; do
		echo "$resolution" >> "${ETC_BIND}/${CONF_INVERSO_10_9_12_192_197}"
	done
	chmod +r "${ETC_BIND}/${CONF_INVERSO_10_9_12_192_197}"
	
	
	for resolution in "${INVERSAS_10_134_13_48_49[@]}"; do
		echo "$resolution" >> "${ETC_BIND}/${CONF_INVERSO_10_134_13_48_49}"
	done
	chmod +r "${ETC_BIND}/${CONF_INVERSO_10_134_13_48_49}"
	
	
	for resolution in "${INVERSAS_10_11_22[@]}"; do
		echo "$resolution" >> "${ETC_BIND}/${CONF_INVERSO_10_11_22}"
	done
	chmod +r "${ETC_BIND}/${CONF_INVERSO_10_11_22}"
	
	
	for resolution in "${INVERSAS_10_134_13_160_162[@]}"; do
		echo "$resolution" >> "${ETC_BIND}/${CONF_INVERSO_10_134_13_160_162}"
	done
	chmod +r "${ETC_BIND}/${CONF_INVERSO_10_134_13_160_162}"
	
	
	for resolution in "${INVERSAS_10_134_13_40_42[@]}"; do
		echo "$resolution" >> "${ETC_BIND}/${CONF_INVERSO_10_134_13_40_42}"
	done
	chmod +r "${ETC_BIND}/${CONF_INVERSO_10_134_13_40_42}"
	
	
	for resolution in "${INVERSAS_10_134_13_128_131[@]}"; do
		echo "$resolution" >> "${ETC_BIND}/${CONF_INVERSO_10_134_13_128_131}"
	done
	chmod +r "${ETC_BIND}/${CONF_INVERSO_10_134_13_128_131}"
	
	
	for resolution in "${INVERSAS_10_134_13_44_46[@]}"; do
		echo "$resolution" >> "${ETC_BIND}/${CONF_INVERSO_10_134_13_44_46}"
	done
	chmod +r "${ETC_BIND}/${CONF_INVERSO_10_134_13_44_46}"
	
	
	for resolution in "${INVERSAS_10_134_1[@]}"; do
		echo "$resolution" >> "${ETC_BIND}/${CONF_INVERSO_10_134_1}"
	done
	chmod +r "${ETC_BIND}/${CONF_INVERSO_10_134_1}"
	
	
	for resolution in "${INVERSAS_10_134_13_96_97[@]}"; do
		echo "$resolution" >> "${ETC_BIND}/${CONF_INVERSO_10_134_13_96_97}"
	done
	chmod +r "${ETC_BIND}/${CONF_INVERSO_10_134_13_96_97}"
	
	
	for resolution in "${INVERSAS_10_134_5_128_133[@]}"; do
		echo "$resolution" >> "${ETC_BIND}/${CONF_INVERSO_10_134_5_128_133}"
	done
	chmod +r "${ETC_BIND}/${CONF_INVERSO_10_134_5_128_133}"
	
	
	for resolution in "${INVERSAS_10_134_13_36_38[@]}"; do
		echo "$resolution" >> "${ETC_BIND}/${CONF_INVERSO_10_134_13_36_38}"
	done
	chmod +r "${ETC_BIND}/${CONF_INVERSO_10_134_13_36_38}"
	
	
	for resolution in "${INVERSAS_10_134_13_32_34[@]}"; do
		echo "$resolution" >> "${ETC_BIND}/${CONF_INVERSO_10_134_13_32_34}"
	done
	chmod +r "${ETC_BIND}/${CONF_INVERSO_10_134_13_32_34}"
	
	
	for resolution  in "${INVERSAS_10_134_13_28_30[@]}"; do
		echo "$resolution" >> "${ETC_BIND}/${CONF_INVERSO_10_134_13_28_30}"
	done
	chmod +r "${ETC_BIND}/${CONF_INVERSO_10_134_13_28_30}"
	
	
	for resolution in "${INVERSAS_172_13_1[@]}"; do
		echo "$resolution" >> "${ETC_BIND}/${CONF_INVERSO_172_13_1}"
	done
	chmod +r "${ETC_BIND}/${CONF_INVERSO_172_13_1}"
	
	
	for resolution in "${INVERSAS_137_43[@]}"; do
		echo "$resolution" >> "${ETC_BIND}/${CONF_INVERSO_137_43}"
	done
	chmod +r "${ETC_BIND}/${CONF_INVERSO_137_43}"
	

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




echo "Dns alumine y junin"

validaciones

write_confs

start_bind9

echo "Servidor dns de alumine y junin corriendo"

exit_conf

