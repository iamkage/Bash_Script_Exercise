#!/bin/bash


if [[ "$#" -ne 1 ]]; then
	echo "[WARN] $0 USAGE: <file.txt>"
	exit 1
fi

if [[ ! -f "$1" ]]; then
	echo "FILE $1 DOSEN'T EXIST"
	exit 1
fi

while read -r line; do
	if [[ -z "$line" || "$line" == "#"* ]]; then
		continue
	fi
	
	if [[ ! -e "$line" ]]; then
		echo "[WARN] File missing."
	elif [[ -x "$line" ]]; then
		echo "[ALERT] Executable FILE founded"
	elif [[ -w "$line" ]]; then
		echo "[WARN] $line IS WRITABLE"
	else
		echo "FILE $line is only readable"
	fi


done < "$1"
