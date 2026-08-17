#!/bin/bash


if [[ "$EUID" -ne 0 ]]; then
	echo "[ERROR] You have to be root";
	exit 1
fi

if [[ -z "$1" ]]; then
	echo "[ERROR] This script requires an argument"
	echo "[$0 USAGE] <directory>"
	exit 1
fi

if [[ ! -d "$1" ]]; then
	echo "[ERROR] This directory $1 does not exist"
	exit 1
fi

target_dir="$1"
mkdir -p /backup
dir_backup="/backup"

find "$target_dir" -type f -name "*.log" -mtime -7 -exec cp -t /backup {}+

echo "[SUCCESS]"


