#!/bin/bash

RUTA=`dirname $0`
ARCHBASE="$RUTA/prueba.svg"
ARCHTEMP=`mktemp /tmp/bingo_XXXXXXXX.png`

for i in {0..99}; do 
	cp "${ARCHBASE}" "${ARCHTEMP}"
	sed -i "s/NUMERO/$i/g" "${ARCHTEMP}"
	inkscape --export-png="$RUTA/numeros/$i.png" --export-dpi=300 "${ARCHTEMP}"
done






