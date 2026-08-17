#!/bin/bash

directory=""
type_audit=""
log_file=""
log_enable=false

while getopts "d:p:l:h" opt; do
	case ${opt} in
		d) directory="$OPTARG";;
		p) type_audit="$OPTARG";;
		l) log_file="$OPTARG" log_enable=true;;
		h) echo "[HELP] $0 USAGE: [-d] <directory> [-p] <type> [-l] <log_file>";;
		?) echo "[ERR] ERROR! MISSING ARGUMENT";;
	esac
done

if [[ -z "$directory" && -z "$type_audit" ]]; then
	echo "[ERRORE] Arguments [-d] and [-p] are needed."
	exit 1
fi

if [[ -n "$directory" ]] && ! [[ -d "$directory" ]]; then
	echo "[ERROR] This directory $directory does not exist"
	exit 1
fi

if [[ -n "$type_audit" ]] && [[ "$type_audit" != "suid" && "$type_audit" != "writable" ]]; then
	echo "[ERROR] $type_audit valid arguments: <suid> or <writable>"
	exit 1
fi

cerca_suid () {
	local dir="$1"
	if [[ -z "$dir" ]]; then
		echo "[ERROR] $dir is empty"
		return 1
	else 
		search=$(find "$dir" -type f -perm /4000)
		echo "[RESULT] $search"
	fi

}



cleanup () {
	echo "[CLEANUP] Audit Session Terminated"
	
}

trap cleanup EXIT SIGINT
cerca_suid "$directory"


