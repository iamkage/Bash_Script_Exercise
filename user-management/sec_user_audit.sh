#!/bin/bash

min_uid=""
shell=""
log_file=""
log_enable=false

TMP_FILE=$(mktemp /tmp/user_audit.XXXXXX)

while getopts ":m:s:l:h" opt; do
	case ${opt} in
		:) echo "[ERROR] Missing Arguments: '-$OPTARG' needs an argument"; exit 1;;
		m) min_uid="$OPTARG";;
		s) shell="$OPTARG";;
		l) log_file="$OPTARG"; log_enable=true;;
		h) echo "[HELP] $0 USAGE: [-m] <min_uid> [-s] <shell> [-l] <log file>"
			exit 1
			;;
		?) echo "[ERR] Invalid Arguments"
			exit 1;;
	esac
done

if [[ -z "$min_uid" && -z "$shell" ]]; then
	echo "[ERROR] Arguments needed [-m] or [-s]"
	exit 1
fi

if [[ -n "$min_uid" ]] && ! [[ "$min_uid" =~ ^[0-9]+$ ]]; then
	echo "[ERROR] Argument [-m] has to be a positive integer"
	exit 1
fi

if [[ -n "$shell" ]] && ! [[ "$shell" =~ ^/ ]]; then
	echo "[ERROR] Argument [-s] has to be an absolute path"
        exit 1
fi    

if [[ "$log_enable" == true ]]; then
	exec 3>&1
	exec 1> "$log_file"
fi

cleanup () {
	
	echo "[CLEAN] Deleting tmp files..."
	sleep 1
	rm  -rf "$TMP_FILE"
	if [[ "$log_enable" == true ]]; then
		exec 1>&3
		exec 3>&-
	fi
	echo "[DEL] AUDIT COMPLETED. FILES DELETED"

}


trap cleanup EXIT SIGINT SIGTERM

user_audit () {
	local min_uid="$1"
	local target_shell="$2"
	gawk -F: -v uid="$min_uid" -v sh="$target_shell" '
		{
			if (uid != "" && $3 < uid) {next}
			if (sh != "" && $NF != sh) {next}
			print $0
		} ' /etc/passwd > "$TMP_FILE"

	cat "$TMP_FILE"	
}

user_audit "$min_uid" "$shell"
