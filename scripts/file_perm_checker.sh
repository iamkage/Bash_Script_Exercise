#!/bin/bash

if [[ $# -eq 0 ]]; then
	echo "ERROR! Missing Argument. $0 USAGE: </../..>"
	exit 1
fi

for file in "$@"; do
	if [[ ! -f "$file" ]]; then
		echo "ERROR! FILE $file doesn't exist."
	fi

	if [[ -x "$file" ]]; then
		echo "FILE $file is executable."
	fi

	if [[ -w "$file" ]]; then
		echo "FILE $file is writable."
	fi

	if [[ ! -x "$file" && !-w "$file" && -r "$file" ]]; then
		echo "FILE $file is only readable."
	fi
done	
