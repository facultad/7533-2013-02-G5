#!/bin/bash


# Copias de seguridad de los archivos de bindeo


declare -a ARCHIVOS_BIND=("named.conf" "named.conf.local" "db.local")
declare -a ARCHIVOS_EXTRAS=("rootdns.ca" "db.inverso" "db.root.dns" "db.alumine" "db.junin" \
"db.local.10" "db.local.192_168" "db.local.172_13" "db.local.137_43" "db.local.10.9.12.192-197" "db.local.10.134.13.48-49" \
"db.local.10.11.22" "db.local.10.134.13.160-162" "db.local.10.134.13.40-42" "db.local.10.134.13.128-131" "db.local.10.134.13.44-46" \
"db.local.10.134.1" "db.local.10.134.13.96-97" "db.local.10.134.5.128-133" "db.local.10.134.13.36-38" "db.local.10.134.13.32-34" \
"db.local.10.134.13.28-30" "db.local.172.13.1" "db.local.137.43" "db.local.10.134.13.64-65" "db.local.10.11.23" "db.local.192.168.53" \
)


_DIR_BIND="/etc/bind" ## /etc/bind
DIR_BIND="${_DIR_BIND}"

_DOMINIO_DNS_ROOT="neuquen.dc.fi.uba.ar"

_IP_DNS_ROOT="10.9.12.197"
_IP_DNS_1="10.134.13.66"
_IP_DNS_2="10.134.5.129"

ES_SUPER_USUARIO="FALSE"

EXT_COPIA="original"


#Funciones

function cargar_variables_entorno {

	if [ "$ES_SUPER_USUARIO" = "TRUE" ]; then

		echo "Cargando Variables de Entorno ..."
	
		export _DIR_BIND
		export _IP_DNS_ROOT
		export _IP_DNS_1
		export _IP_DNS_2	
		export _DOMINIO_DNS_ROOT

		echo "Cargando comandos alias ..."

		alias dns1='bash dns_chosmalal.sh'
		alias dns2='bash dns_alumine_junin.sh'
		alias dnsroot='bash dns_root.sh'

		alias test_zona_1='bash test_dns_zona_1.sh'
		alias test_zona_2='bash test_dns_zona_2.sh'

		alias revertir='. ./respaldo.sh -revertir'
		alias borrar_archivos='. ./respaldo.sh -br'
		alias conf_defecto='. ./respaldo.sh -cargar_conf_defecto'
	
	fi

	return 0;
}



function comprobar_usuario_root {
	if [ "$USER" != "root" ]; then
		echo "Debe iniciar la ejecucion como usuario root"
		finalizar "5" "No es usuario Root"
		ES_SUPER_USUARIO="FALSE"
	else
		ES_SUPER_USUARIO="TRUE"
	fi

	return 0
}



function finalizar {
	if [ "$ES_SUPER_USUARIO" = "TRUE" ]; then
		if [ "$1" = "0" ];then 
			echo "Fin."
		else
			echo "Fin: Error $1 : ${2}."
		fi
	fi
}



function mostrar_ayuda {
	
echo ""
echo "-ayuda 		: muestra esta ayuda"
echo "-revertir		: reestablece los archivos desde las copias de respaldo"
echo "-br		: borra los archivos de respaldo"
echo "-revertir -rbind	: reinicia el demonio de bind"
echo "-cargar_conf_defecto : carga algunos archivos de bind por defecto"

finalizar "0"
}








echo "::::::::::::::::::::::::::::::::::::::::::::::::::"
echo



echo "Inicianado script de para respaldar archivos..."
echo ""

comprobar_usuario_root

cargar_variables_entorno

if [ "$ES_SUPER_USUARIO" != "TRUE" ]; then
	echo "Script Abortado. "

elif [ "$1" = "-ayuda" ]; then
	mostrar_ayuda

elif [ "$#" = "0" ]; then
	
	if [ "${ARCHIVOS_RESPALDADOS:-FALSE}" = "FALSE" ]; then

		echo "Creando Archivos de Respaldo..."

		for nom in "${ARCHIVOS_BIND[@]}"; do
		
			if [ -f "${DIR_BIND}/${nom}" ]; then
				cp "${DIR_BIND}/${nom}" "${DIR_BIND}/${nom}.${EXT_COPIA}"

				if [ "$?" != "0" ]; then
					echo "Error al copiar archvivo $nom"
				fi
			else
				echo "Error: Falta archivo ${nom}"
			fi
		done;
		export	ARCHIVOS_RESPALDADOS="TRUE"

	else
		echo "Error: Ya existen copias de respaldo para lo archivos."
	fi

elif [ "$1" = "-revertir" ]; then
	if [ "${ARCHIVOS_RESPALDADOS:-FALSE}" = "TRUE" ]; then

		echo "Revirtiendo archivos..."

		for nom in "${ARCHIVOS_BIND[@]}"; do
			#echo $nom

			if [ -f "${DIR_BIND}/${nom}.${EXT_COPIA}" ]; then

				rm "${DIR_BIND}/${nom}"		

				cp "${DIR_BIND}/${nom}.${EXT_COPIA}" "${DIR_BIND}/${nom}"

				if [ "$?" != "0" ]; then
					echo "Error al restaurar archivo $nom"
				fi
			fi
		done;

		## Borro archivos particulares creados
		for nom_arch_extra in "${ARCHIVOS_EXTRAS[@]}"; do
			#echo $nom

			if [ -f "${DIR_BIND}/${nom_arch_extra}" ]; then

				rm "${DIR_BIND}/${nom_arch_extra}"		

				if [ "$?" != "0" ]; then
					echo "Error al borrar archvivo $nom_arch_extra"
				fi
			fi
		done;

		echo "Hecho."
		export	ARCHIVOS_RESPALDADOS="TRUE"


		if [ "$2" = "-rbind" ]; then
			echo ""
			echo "Reiniciando BIND ..."

			/etc/init.d/bind9 restart
		fi
	else
		echo "Error: no existen copias de respaldo para revertir los archivos."
	fi

elif [ "$1" = "-br" ]; then
	
	if [ "${ARCHIVOS_RESPALDADOS:-FALSE}" = "TRUE" ]; then
	
		echo "Borrando respaldos..."
	
		## Borro archivos de respaldo
		for nom in "${ARCHIVOS_BIND[@]}"; do
			#echo $nom

			if [ -f "${DIR_BIND}/${nom}.${EXT_COPIA}" ]; then

				rm "${DIR_BIND}/${nom}.${EXT_COPIA}"		

				#mv "${DIR_BIND}/${nom}.${EXT_COPIA}" "${DIR_BIND}/${nom}"

				if [ "$?" != "0" ]; then
					echo "Error al borrar archvivo $nom"
				fi
			fi

		done;
	
		## Borro archivos particulares creados
		for nom_arch_extra in "${ARCHIVOS_EXTRAS[@]}"; do
			#echo $nom

			if [ -f "${DIR_BIND}/${nom_arch_extra}" ]; then

				rm "${DIR_BIND}/${nom_arch_extra}"		

				if [ "$?" != "0" ]; then
					echo "Error al borrar archvivo $nom_arch_extra"
				fi
			fi
		done;
		export	ARCHIVOS_RESPALDADOS="FALSE"	
		echo "Hecho."

	else
		echo "Error: No existen archivos de respaldo que borrar"
	fi

elif [ "$1" = "-cargar_conf_defecto" ]; then

	if [ "${ARCHIVOS_RESPALDADOS:-FALSE}" = "TRUE" ]; then
	echo "Cargando Configuracion por defecto"

	echo ";
; BIND data file for local loopback interface
;
$TTL	604800
@	IN	SOA	localhost. root.localhost. (
			      2		; Serial
			 604800		; Refresh
			  86400		; Retry
			2419200		; Expire
			 604800 )	; Negative Cache TTL
;
@	IN	NS	localhost.
@	IN	A	127.0.0.1
@	IN	AAAA	::1" > "${DIR_BIND}/db.local" 
	
	echo "// This is the primary configuration file for the BIND DNS server named.
//
// Please read /usr/share/doc/bind9/README.Debian.gz for information on the 
// structure of BIND configuration files in Debian, *BEFORE* you customize 
// this configuration file.
//
// If you are just adding zones, please do that in /etc/bind/named.conf.local

include \"/etc/bind/named.conf.options\";
include \"/etc/bind/named.conf.local\";
include \"/etc/bind/named.conf.default-zones\";" > "${DIR_BIND}/named.conf"


	echo "" > "${DIR_BIND}/named.conf.local"


	## Borro archivos particulares creados
	for nom_arch_extra in "${ARCHIVOS_EXTRAS[@]}"; do
		#echo $nom

		if [ -f "${DIR_BIND}/${nom_arch_extra}" ]; then

			rm "${DIR_BIND}/${nom_arch_extra}"		

			if [ "$?" != "0" ]; then
				echo "Error al borrar archvivo $nom_arch_extra"
			fi
		fi
	done;
	fi
else
	echo "Error: Parametro/s incorrecto/s."
fi



finalizar "0"
echo ""
echo "::::::::::::::::::::::::::::::::::::::::::::::::::"
