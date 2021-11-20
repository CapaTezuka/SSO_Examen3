#! /bin/bash
#identificando SistemaOperativo
echo "Detectando SistemaOperativo"
#imprimir OS
NOMBRE=$(awk -F= '/^NAME/{print $2}' /etc/os-release)
SISOP=$(hostnamectl | grep ubuntu)
INS=$(yum list installed | grep epel)

if [ -z "$SISOP" ];
then
	echo "Su sistema es: "
	echo "$NOMBRE"
	
		if [ -z "$INS" ];
		then
			echo "Descargando EPEL"
			yum -y install epel-release
			echo "EPEL instalado"
		else 
			echo "EPEl ya está listo"
		fi
		echo "Detectando ClamAV"
		INS=$(yum list installed | grep clamav)
		if  [ -z "$INS" ]; 
		then
			echo "Instalando ClamAV"
			yum -y install clamav clamav-devel
		else 
			echo "ClamAV ya está listo"
		fi

		echo "Pulse enter si desea actualizar"
		read -p "Pulse cualquier otra tecla para cancelar: " ack
		if [ -z "$ack" ];
		then
			echo "Actualizando, por favor espere"
			yum update
		else 
			echo "No se actualizo"
		fi
fi

OS=$(hostnamectl | grep centos)
if [ -z "$SISOP" ];
then

	echo "El sistema es: "
	echo "$NOMBRE"
		echo "Detectando ClamAV"
		INS=$(dpkg-query -l | grep clamav)
		if  (apt list clamav); 
		then
			echo "ClamAV ya está instalado "
		else 
			echo "Instalando ClamAV"
			apt-get install clamav clamav-daemon -y
		fi

		#echo "Pulse enter si desea actualizar"
		#read -p "Pulsa cualquier tecla para cancelar: " ack
		#if  ("$ack" = ""); 
		#then
			echo "Actualizando, por favor espere"
			sudo apt-get update
		#else 
		#	echo "No se actualizo"
		#fi

fi 


exit