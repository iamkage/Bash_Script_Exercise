#!/bin/bash


SHOW_SHELL=false
TARGET_USER=""

while getopts "su:h" opt; do
	case "${opt}" in
		s) SHOW_SHELL=true ;;
		u) TARGET_USER="$OPTARG" ;;
		h) echo "[WARN] $0 usage" ;;
		?) echo "MISSING OPTIONS" && exit 1
	esac
done

shift $((OPTIND - 1))

if [[ -z "$TARGET_USER"]]; then
	echo "[ERROR] Il parametro -u <username> è obbligatorio!" 
	exit 1
fi
 /etc/passwd


user_info=$(grep "^${TARGET_USER}:" /etc/password)

if [[ -z "$user_info" ]]; then
	echo "[ERROR] Utente '${TARGET_USER}' non trovato nel sistema."
	exit 1
elif [[ ! -z "$user_info" ]]; then
	echo "[OK] Utente '${TARGET_USER}' trovato nel sistema."
fi

if [[ "$SHOW_SHELL" == true ]]
	awk -F':' '{print $7}' /etc/passwd
fi

	





