#!/bin/bash

if [[ $# -ne 1 || ! -d $1 ]]; then
	echo "ERROR! Must be just one argument and an existing directory!"
	echo " $0 USAGE: EXAMPLE: ./log_cleaner.sh </directory>"
	exit 1
fi

directory=$1

for file in "${directory}"/*.log; do
	if [[ -s $file ]]; then
		cp "${file}" "${file}_bak"
		echo "FILE CREATED ${file}_bak"	
	else
		echo "FILE $file IGNORED"
	fi
done
