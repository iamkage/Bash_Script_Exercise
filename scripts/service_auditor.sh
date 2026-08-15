#!/bin/bash


if [[ $# -eq 0 ]]; then
	echo "ERROR! Invalid Argument. $0 usage: <service_name>"
	exit 1
fi

for services in "$@"; do
	if systemctl is-active --quiet "$services"; then
		echo "The service $services is active"
		if [[ -f "$services" && -d "$sevices" ]]; then
			echo "[OK] Service '<nome>' is RUNNING and configuration exists."
		elif [[ ! -d "etc/$services" ]]; then
			echo "[WARNING] Service '<nome>' is RUNNING but /etc/$services is missing!"
		fi
	else 
		echo "ERROR! Service $services is INACTIVE or NOT FOUNDED."
	fi
done
		
