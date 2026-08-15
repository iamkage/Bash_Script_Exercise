#!/bin/bash


if [[ $# -ne 1 ]]; then
	echo "[WARNING] $0 USAGE: <./user_audit.sh> </etc/passwd> "
	exit 1
fi

if [[ ! -f "$1" ]]; then
	echo "[WARNING]: $1 is not a valid file"
	exit 1
fi

while read -r line; do 
	if [[ -z "$line" || "$line" == "#"* ]]; then
		continue
	elif [[ "$line" =~ ^root:|| /bin/bash ]]; then
		echo "[ALERT] Account interattivo/root trovato -> ${line}"
	elif [[ "$line" =~ nologin|false ]]; then
		echo "[INFO] Account di servizio (no login) -> ${line}"
	else 
		echo "[USER] $line"
	fi
done < "$1"

