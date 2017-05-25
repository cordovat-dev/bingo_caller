#!/bin/bash

RUTA=`dirname $0`
ARCHLISTA="$RUTA/lista.txt"
ARCHTEMP=`mktemp /tmp/bingo_XXXXXXXX`
ARCHTEMP2=`mktemp /tmp/bingo_XXXXXXXX`
vcont=0
function salir {
	rm "${ARCHTEMP}" "${ARCHTEMP2}"
	echo -en "\n Ejecutado $vcont veces \n"
	exit $1
}

control_c()
{
	echo -en "\n*** ¡Abortado! ***\n"
	salir 0	
}

trap control_c SIGINT

cp "${ARCHLISTA}" "${ARCHTEMP}"
LA=$(wc -l "${ARCHTEMP}" |awk '{print $1}')
while true; do
	vcont=$[ $vcont + 1 ]
	LONGARCH=$(wc -l "${ARCHTEMP}" |awk '{print $1}')
	if [ $LONGARCH -eq 0 ];then
		salir 0
	fi
	NUMAL=$(shuf -i 1-$LONGARCH -n 1)

	NUM=$(sed -n -e ${NUMAL}p "${ARCHTEMP}")
	espeak -v es "$NUM" 2> /dev/null &
	figlet -f "$RUTA/fonts/doh.flf" $NUM
	#figlet -f "$RUTA/fonts/big.flf" $NUM
	#FONT="$RUTA/fonts/$( ls $RUTA/fonts/|shuf -n 1)"
	#figlet -f "$FONT" $NUM
	#basename "$FONT"
	#DISPLAY=:0.0 notify-send -i "$(readlink -e $RUTA/numeros/$NUM.png)" "Bingo" "Bingo"
	echo
	sed -i.bak -e "${NUMAL},${NUMAL}d" "${ARCHTEMP}"
	sleep 8
done

salir 0






