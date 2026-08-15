#!/bin/bash

if [[ $# -eq 0 ]]; then
	echo "ERROR, INVALID ARGUMENT! $0 USAGE: <user 1> <user 2> ... <user n>"
	exit 1
fi

for users in "$@"; do
	user_found=$(grep -q "$USERNAME:" /etc/passwd)
	if [[ ! "$user_found" ]]; then
		echo "ERROR! $users 'doesn't' exist"
		exit 1
	elif [[ -d /home/$user_found ]]; then
		echo "$user_found ok! "
	else
		echo "WARNING! $user_found home 'doesen't' exist."
	exit 1
	fi
done	
		
