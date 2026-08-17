#!/bin/bash


if [[ -z "$1" ]]; then
	echo "[ERROR] This script needs a directory"
	exit 1
fi

target_dir="$1"
mkdir -p /root/shadow/

echo "Finding and copying files..."

find "$target_dir" -type f -size +5M -exec cp {} /root/shadow
echo "[COPIED SUCCESSFULLY]"	


