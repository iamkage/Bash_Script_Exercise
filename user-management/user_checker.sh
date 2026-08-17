#!/bin/bash

user=""

while getopts "u:h" opt; do
	case "${opt}" in
		u) user="$OPTARG" ;;
		h) echo "[WAR] $0 USAGE: <user>"
			exit 1
			;;
		?) echo "[WARN]	INVALID ARGUMENT"
			exit 1 ;;
	esac
done

shift $((OPTIND - 1)) 

if [[ -z "$user" ]]; then
	echo "[WARN] ERROR! User parameter '-u' is needed."
	exit 1
fi

check_user () {
	local username="$1"
	if grep -q "^${username}:" /etc/passwod; then
		grep "$username" /etc/passwd | awk -F':' '{print $1, $3, $NF}'
		success=$(return 0)
		echo "SUCCESS! EXIT STATUS $success"
	else 
		echo "[ERROR] $username doesn't founded"
	       	return 1
	fi
}

check_user "$user"

if [[ $? -eq 0 ]]; then
	echo "[SUCCESS]"
else
	echo "[FAILURE]"
fi


