#!/bin/bash

if [[ "$EUID" -ne 0 ]]; then
	echo "[ERROR] You must be root"
	exit 1
fi

if [[ -z "$1" ]]; then
	echo "[ERROR] This script needs a directory as argument"
	exit 1
fi

if [[ ! -d "$1" ]]; then
	echo "[ERROR] This directory $1 does not exist"
	exit 1
fi

directory="$1"

delete=$(find "$directory" -type -f -name "*.tmp" -exec rm -v {} \; | wc -l)
echo "[OK] $delete FILES DELETED"
