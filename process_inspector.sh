#!/bin/bash

process_name=""
output_file=""
while getops "p:l:h" opt; do
	case "${opt}" in
		p) process_name="$OPTARG" ;;
		l)  output_file="$OPTARG" ;;
		h) echo "[WARN] $0 USAGE: <process_name> <log_file>" 
			exit 
			;;
	esac
done

if [[ -z "$process_name" ]]; then
	echo "[WARN] ERROR ARGUMENT"
	exit 1
fi

if [[ "$output_file" ]]; then
	exec 1> "$output_file"
fi

ps aux | awk  '{print $1, $2. $NF}'

exec 1>&3

exec 3>&-

echo "STAMPO"


