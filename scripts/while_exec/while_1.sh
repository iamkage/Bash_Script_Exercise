#!/bin/bash


if [[ $# -ne 1 ]]; then
	echo "Warning: INVALID ARGUMENT. $0 USAGE: </etc/fstab> or </etc/ssh/sshd_config>"
	exit 1
fi

if [[ ! -f ${1} ]]; then 
	echo "WARNING! $1 does not exist"
	exit 1
fi

while -read "$1"; do
	if [[ "$line" == "#"* ]]; then
		break
	elif grep -E "password"|"root"; then
		echo "[WARNING, LINE FOUND] -> ${line}"
	else 
		echo "[CONFIG] ${line}"
	fi
done	
