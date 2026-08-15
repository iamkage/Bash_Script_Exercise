#!/bin/bash

if [[ $# -eq 0 ]]; then
	echo "MUST BE ONE ARGUMENT!"
	exit 1
fi

NUM_FILE=$1

for (( i=0; i<=NUM_FILE; i++ )); do
	FILE_NAME="log_$i.log"
	touch "$FILE_NAME"
	echo "FILE $FILE_NAME Created"
	if [[ -z "$FILE_NAME" ]]; then
		$FILE_NAME < "Prova testo!!"IFS
	fi
done
