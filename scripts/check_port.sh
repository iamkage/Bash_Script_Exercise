#!/bin/bash

ip=$1
port=$2

if [ $# -ne 2 ]; then
	echo "ERROR! USAGE: $0 <ip> <port>"
	exit 1
fi

nc -zv -w 2 $ip $port &>/dev/null

if [ $? -eq 0 ]; then
	echo "SUCCESS! The port "$port" is open on IP: "$ip""
else
	echo "ERROR! That port is UNREACHABLE."
	exit 1
fi	
