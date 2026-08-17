#!/bin/bash


if [[ "$EUID" -ne 0 ]]; then
	echo "[ERROR] You have to be root"
	exit 1
fi

if [[ -z "$1" ]]; then
	echo "[ERROR] This script requires an argument"
	exit 1
fi

if [[ ! -d "$1" ]]; then
	echo "[ERROR] This directory does not exist"
	exit 1
fi

directory="$1"
find "$directory" -type f -perm /4000 > /var/log/suid_files.txt

if [[ -s /var/log/suid_files.txt ]]; then
	echo "[WARNING] SUID files found! Check /var/log/suid_files.txt"
else
	echo "[OK] No SUID files detected"	
fi
