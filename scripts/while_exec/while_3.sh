#!/bin/bash


if [[ $# -ne 1 ]]; then
	echo "[WARNING] $0 USAGE: </.../*.log>"
	exit 1
fi

if [[ ! -f "$1" ]]; then
	echo "[WARNING] FILE $1 IS NOT VALID"
	exit 1
fi

while read -r line; do
	if [[ -z "$line" || "$line" == "#"* ]]; then
		continue
	fi
		
	clean_line=${line,,}

	if [[ "$clean_line" =~ failed|error|critical ]]; then
		echo "[ALERT] CRITICAL EVENT FOUND -> ${line}"
	elif [[ "$clean_line" =~ warn|warning ]]; then
		echo "[WARN] -> ${line}"
	else
		echo "[INFO] ${line}"
	fi

done < "$1"
