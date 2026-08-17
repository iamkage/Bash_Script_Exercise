#!/bin/bash


if [[ "$EUID" -ne 0 ]]; then
	echo "[ERROR] You must be root"
	exit 1
fi

for servizio in sshd firewalld crond; do
	if systemctl is-active --quiet "$servizio"; then
		echo "[OK] $servizio is RUNNING"
	else 
		echo "[WARNING] $servizio is not running"
	fi
done
