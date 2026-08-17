#!/bin/bash


if [[ $EUID -ne 0 ]]; then
	echo "[ERROR] You must be ROOT"
	exit 1
fi

if [[ -z "$1" ]]; then
	echo "[ERROR] $0 needs an argument"
	exit 1
fi

if id "$1" &>/dev/null; then
	echo "[EXIST] That user already exist"
	exit 0
else
	useradd -s /bin/bash "$1"
	echo "[NEW USER] USER $1 CREATED"

fi       
